import { CommonModule } from '@angular/common';
import { Component } from '@angular/core';
import { FormBuilder, FormGroup, ReactiveFormsModule } from '@angular/forms';
import { ActivatedRoute, Router } from '@angular/router';
import { FontAwesomeModule } from '@fortawesome/angular-fontawesome';
import { faArrowLeft } from '@fortawesome/free-solid-svg-icons';
import { Payment } from '../../../services/interfaces/payments.interface';
import { PaymentService } from '../../../services/api/payments.service';
import {
  PAYMENT_TYPES,
  SCREENS,
} from '../../../services/common/common.constants';
import { FooterComponent } from '../../../components/family-records/footer/footer.component';
import { FooterEvent } from '../../../services/interfaces/permissions.interface';
import { SectionFormComponent } from '../../../components/common/section-form/section-form.component';
import { Account } from '../../../services/interfaces/accounts.interface';
import { AccountService } from '../../../services/api/accounts.service';
import { ToastService } from '../../../services/common/toast.service';
import { BookingService } from '../../../services/api/bookings.service';
import { CanEditDirective } from '../../../directives/can-edit.directive';

@Component({
  selector: 'app-payments-view',
  standalone: true,
  imports: [
    CommonModule,
    FontAwesomeModule,
    ReactiveFormsModule,
    FooterComponent,
    SectionFormComponent,
    CanEditDirective,
  ],
  templateUrl: './payments-view.component.html',
  styleUrl: './payments-view.component.css',
})
export class PaymentsViewComponent {
  screen: string = SCREENS.PAYMENTS;
  isEditMode: boolean = true;

  faArrowLeft = faArrowLeft;
  accounts: Account[] = [];
  bookingCode!: string;
  paymentId: string | null = null;
  payment!: Payment;
  paymentForm!: FormGroup;

  paymentTypes = PAYMENT_TYPES;
  paymentTypeList = [
    PAYMENT_TYPES.BOOKINGS,
    PAYMENT_TYPES.DONATIONS,
    PAYMENT_TYPES.MASS_COLLECTION,
    PAYMENT_TYPES.OFFERRINGS,
    PAYMENT_TYPES.SUBSCRIPTIONS,
  ];

  constructor(
    private route: ActivatedRoute,
    private router: Router,
    private paymentService: PaymentService,
    private fb: FormBuilder,
    private accountService: AccountService,
    private toast: ToastService,
    private bookingService: BookingService
  ) {}

  ngOnInit() {
    this.paymentId = this.route.snapshot.paramMap.get('paymentId');
    this.bookingCode =
      this.route.snapshot.queryParamMap.get('booking_code') || '';
    this.accountService.getAccountsList().subscribe({
      next: (accounts) => {
        this.accounts = accounts;
        if (this.paymentId) {
          this.paymentService
            .getPayment(this.paymentId)
            .subscribe((payment) => {
              this.payment = payment;
              this.loadPaymentForm();
              this.paymentForm.disable();
              this.isEditMode = false;
            });
        } else if (this.bookingCode !== '') {
          this.bookingService.getBookingByCode(this.bookingCode).subscribe({
            next: (booking) => {
              this.paymentForm = this.fb.group({
                type: [PAYMENT_TYPES.BOOKINGS],
                date: [new Date().toISOString().split('T')[0]],
                paid_to: [''],
                payee: [booking.booked_by || ''],
                family_code: [booking.family_code || ''],
                amount: [0],
                currency: ['INR'],
                description: ['Payment for ' + booking.description],
                booking_code: [this.bookingCode || ''],
                payment_mode: ['cash'],
                account_id: [this.accounts[0]?.id || ''],
              });
              this.paymentForm.get('type')?.disable();
              this.paymentForm.get('booking_code')?.disable();
            },
            error: (error) => {
              this.toast.error(
                'Error fetching booking details: ' + error.message
              );
            },
          });
        } else {
          this.loadPaymentForm();
        }
      },
      error: (error) => {
        this.toast.error('Error fetching accounts: ' + error.message);
      },
    });
    this.loadPaymentForm();
  }

  onBackClick() {
    this.router.navigate(['/payments']);
  }

  loadPaymentForm() {
    this.paymentForm = this.fb.group({
      type: [this.payment?.type || PAYMENT_TYPES.BOOKINGS],
      date: [
        this.payment?.date
          ? new Date(this.payment.date).toISOString().split('T')[0]
          : new Date().toISOString().split('T')[0],
      ],
      paid_to: [this.payment?.paid_to || ''],
      payee: [this.payment?.payee || ''],
      amount: [this.payment?.amount || 0],
      currency: [this.payment?.currency || 'INR'],
      description: [this.payment?.description || ''],
      booking_code: [this.payment?.booking_code || ''],
      payment_mode: [this.payment?.payment_mode || 'cash'],
      account_id: [this.payment?.account_id || this.accounts[0]?.id || ''],
      subscription_from: [this.payment?.subscription_from || ''],
      subscription_to: [this.payment?.subscription_to || ''],
      family_code: [this.payment?.family_code || ''],
    });
  }

  onModeUpdated(event: FooterEvent) {
    this.isEditMode = event.isEditMode;
    event.isEditMode ? this.paymentForm.enable() : this.paymentForm.disable();
    if (this.paymentId && event.isEditMode) {
      this.paymentForm.disable();
      this.paymentForm.get('paid_to')?.enable();
      this.paymentForm.get('payee')?.enable();
      this.paymentForm.get('description')?.enable();
      this.paymentForm.get('family_code')?.enable();
      this.paymentForm.get('payment_mode')?.enable();
    }
    event.isSaveTriggered
      ? this.toast
          .confirm('Are you sure you want to save the payment?')
          .then((confirmed) => {
            if (confirmed) {
              this.onSavePayment();
            }
          })
      : null;
    event.isDeleteTriggered
      ? this.toast
          .confirm(
            'Are you sure you want to delete the payment? This action is irreversible!'
          )
          .then((confirmed) => {
            if (confirmed) {
              this.onDeletePayment();
            }
          })
      : null;
  }

  get type(): string {
    return this.paymentForm.get('type')?.value as string;
  }

  onSavePayment() {
    if (this.paymentForm.invalid) {
      this.toast.error('Please fill all required fields correctly.');
      return;
    }
    if (!this.paymentId) {
      this.paymentService
        .createPayment(this.paymentForm.getRawValue())
        .subscribe({
          next: () => {
            this.toast.success('Payment saved successfully!');
            this.router.navigate(['/payments']);
          },
          error: (error) => {
            this.toast.error('Error saving payment: ' + error.message);
          },
        });
    } else {
      this.paymentService
        .updatePayment(this.paymentId, this.paymentForm.getRawValue())
        .subscribe({
          next: () => {
            this.toast.success('Payment updated successfully!');
            this.router.navigate(['/payments/view', this.paymentId]);
          },
          error: (error) => {
            this.toast.error('Error updating payment: ' + error.message);
          },
        });
    }
  }

  onDeletePayment() {
    if (!this.paymentId) {
      this.toast.error('No payment selected to delete.');
      return;
    }
    this.paymentService.deletePayment(this.paymentId).subscribe({
      next: () => {
        this.toast.success('Payment deleted successfully!');
        this.router.navigate(['/payments']);
      },
      error: (error) => {
        this.toast.error('Error deleting payment: ' + error.message);
      },
    });
  }
}
