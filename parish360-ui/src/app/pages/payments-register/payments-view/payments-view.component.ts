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

@Component({
  selector: 'app-payments-view',
  standalone: true,
  imports: [
    CommonModule,
    FontAwesomeModule,
    ReactiveFormsModule,
    FooterComponent,
    SectionFormComponent,
  ],
  templateUrl: './payments-view.component.html',
  styleUrl: './payments-view.component.css',
})
export class PaymentsViewComponent {
  screen: string = SCREENS.PAYMENTS;
  isEditMode: boolean = true;

  faArrowLeft = faArrowLeft;
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
    private fb: FormBuilder
  ) {}

  ngOnInit() {
    this.paymentId = this.route.snapshot.paramMap.get('paymentId');
    if (this.paymentId) {
      this.isEditMode = false;
      this.paymentService.getPayment(this.paymentId).subscribe((payment) => {
        this.payment = payment;
        this.loadPaymentForm();
      });
    }
    this.loadPaymentForm();
  }

  onBackClick() {
    this.router.navigate(['/payments']);
  }

  loadPaymentForm() {
    this.paymentForm = this.fb.group({
      type: [this.payment?.type || ''],
      payment_on: [this.payment?.payment_on || new Date()],
      received_by: [this.payment?.received_by || ''],
      payee: [this.payment?.payee || ''],
      amount: [this.payment?.amount || ''],
      currency: [this.payment?.currency || ''],
      remarks: [this.payment?.remarks || ''],
      subscriptions: this.loadSubscriptions(this.payment?.subscriptions),
      donations: this.loadDonations(this.payment?.donations),
      bookings: this.loadBookings(this.payment?.bookings),
    });
    !this.isEditMode ? this.paymentForm.disable() : null;
  }

  loadSubscriptions(subscriptions?: Subscription[]) {
    if (subscriptions?.length) {
      return this.fb.array(
        subscriptions.map((subscription) =>
          this.fb.group({
            book_no: [subscription.book_no || ''],
            from: [subscription.from || ''],
            to: [subscription.to || ''],
            note: [subscription.note || ''],
          })
        )
      );
    }
    if (this.isEditMode) {
      return this.fb.array([
        this.fb.group({
          book_no: [''],
          from: [new Date()],
          to: [new Date()],
          note: [''],
        }),
      ]);
    }
    return this.fb.array<Subscription[]>;
  }

  loadDonations(donations?: Donation[]) {
    if (donations?.length) {
      return this.fb.array(
        donations.map((donation) => {
          this.fb.group({
            association: [donation.association || ''],
            note: [donation.note || ''],
          });
        })
      );
    }
    if (this.isEditMode) {
      return this.fb.array([
        this.fb.group({
          association: [''],
          note: [''],
        }),
      ]);
    }
    return this.fb.array<Donation[]>;
  }

  loadBookings(bookings?: BookingsPayment[]) {
    if (bookings?.length) {
      return this.fb.array(
        bookings.map((booking) => {
          this.fb.group({
            booking_id: [booking.booking_id || ''],
            type: [booking.type || ''],
            note: [booking.note || ''],
          });
        })
      );
    }
    if (this.isEditMode) {
      return this.fb.array([
        this.fb.group({
          booking_id: [''],
          type: [''],
          note: [''],
        }),
      ]);
    }
    return this.fb.array<Donation[]>;
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

  formArray(key: string): FormArray {
    return this.paymentForm.get(key) as FormArray;
  }
}
