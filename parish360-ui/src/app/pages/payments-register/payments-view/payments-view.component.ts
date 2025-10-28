import { CommonModule } from '@angular/common';
import { Component } from '@angular/core';
import {
  FormArray,
  FormBuilder,
  FormGroup,
  ReactiveFormsModule,
} from '@angular/forms';
import { ActivatedRoute, Router } from '@angular/router';
import { FontAwesomeModule } from '@fortawesome/angular-fontawesome';
import { faArrowLeft } from '@fortawesome/free-solid-svg-icons';
import {
  BookingsPayment,
  Donation,
  Payment,
  Subscription,
} from '../../../services/interfaces/payments.interface';
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
          alert(this.paymentId);
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
      payment_mode: [this.payment?.payment_mode || ''],
      account_id: [this.payment?.account_id || this.accounts[0]?.id || ''],
      subscription_from: [this.payment?.subscription_from || ''],
      subscription_to: [this.payment?.subscription_to || ''],
      family_code: [this.payment?.family_code || ''],
    });
  }

  onModeUpdated(event: FooterEvent) {
    if (event.isCancelTriggered) {
      this.router.navigate(['/payments']);
    } else {
      confirm('Are you sure you want to add this payment ?')
        ? this.router.navigate(['/payments'])
        : (this.isEditMode = true);
    }
  }

  get type(): string {
    return this.paymentForm.get('type')?.value as string;
  }
}
