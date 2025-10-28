import { CommonModule } from '@angular/common';
import { Component } from '@angular/core';
import { FormBuilder, FormGroup, ReactiveFormsModule } from '@angular/forms';
import { ActivatedRoute, Router } from '@angular/router';
import { FontAwesomeModule } from '@fortawesome/angular-fontawesome';
import { faArrowLeft } from '@fortawesome/free-solid-svg-icons';
import { SectionFormComponent } from '../../../components/common/section-form/section-form.component';
import { AgGridModule } from 'ag-grid-angular';
import {
  GridApi,
  ColDef,
  RowSelectionOptions,
  GridReadyEvent,
} from 'ag-grid-community';
import {
  BookingRequest,
  BookingResponse,
  Bookings,
} from '../../../services/interfaces/bookings.interface';
import { ResourceService } from '../../../services/api/resource.service';
import { LiturgyService } from '../../../services/api/liturgy.service';
import { Payment } from '../../../services/interfaces/payments.interface';
import { Account } from '../../../services/interfaces/accounts.interface';
import { AccountService } from '../../../services/api/accounts.service';
import { ToastService } from '../../../services/common/toast.service';
import { BookingService } from '../../../services/api/bookings.service';
import { Resource } from '../../../services/interfaces/resources.interface';
import { Services } from '../../../services/interfaces/services.interface';

@Component({
  selector: 'app-bookings-view',
  standalone: true,
  imports: [
    CommonModule,
    FontAwesomeModule,
    ReactiveFormsModule,
    SectionFormComponent,
    AgGridModule,
  ],
  templateUrl: './bookings-view.component.html',
  styleUrl: './bookings-view.component.css',
})
export class BookingsViewComponent {
  currentDate: string = new Date().toISOString().slice(0, 16);
  nextDate: string = new Date(
    new Date(this.currentDate).setDate(new Date().getDate() + 1)
  )
    .toISOString()
    .slice(0, 16);
  faArrowLeft = faArrowLeft;

  bookingCode!: string;
  booking!: BookingResponse;
  bookingsForm!: FormGroup;
  isEditMode: boolean = true;

  totalBookingAmount: number = 0;
  accounts!: Account[];
  payment!: Payment;
  paymentForm!: FormGroup;
  payments!: Payment[];

  private gridApi!: GridApi;
  rowData: any[] = [];
  paginationPageSize = 5;
  paginationPageSizeSelector: number[] | boolean = [5, 10, 20];
  defaultColDef: ColDef = {
    flex: 1,
    filter: true,
    floatingFilter: true,
  };
  rowSelection: RowSelectionOptions | 'single' | 'multiple' = {
    mode: 'multiRow',
    checkboxes: true,
    headerCheckbox: true,
    enableClickSelection: true,
  };

  columnDefs: ColDef<any>[] = [];
  resourceColDefs: ColDef<Resource>[] = [
    {
      headerName: 'Resource Name',
      field: 'name',
    },
    {
      headerName: 'Description',
      field: 'description',
      flex: 1,
    },
    {
      headerName: 'Booking Amount',
      field: 'amount',
    },
    {
      headerName: 'Capacity',
      field: 'capacity',
    },
    {
      headerName: 'Mass Compatible',
      field: 'mass_compatible',
    },
  ];
  serviceColDefs: ColDef<Services>[] = [
    {
      headerName: 'Service Name',
      field: 'name',
    },
    {
      headerName: 'Service Type',
      field: 'type',
    },
    {
      headerName: 'Date',
      field: 'date',
    },
    {
      headerName: 'Start Time',
      field: 'start_time',
    },
    {
      headerName: 'End Time',
      field: 'end_time',
    },
  ];
  paymentColDefs: ColDef<Payment>[] = [
    {
      headerName: 'Paid To',
      field: 'paid_to',
    },
    {
      headerName: 'Account',
      field: 'account_id',
    },
    {
      headerName: 'amount',
      field: 'amount',
    },
    {
      headerName: 'Currency',
      field: 'currency',
    },
    {
      headerName: 'Payment Mode',
      field: 'payment_mode',
    },
  ];

  constructor(
    private route: ActivatedRoute,
    private router: Router,
    private fb: FormBuilder,
    private resourceService: ResourceService,
    private liturgyService: LiturgyService,
    private accountService: AccountService,
    private bookingService: BookingService,
    private toast: ToastService
  ) {}

  ngOnInit() {
    this.accountService.getAccountsList().subscribe({
      next: (accounts) => {
        this.accounts = accounts;
        // fetch booking information if provdided
        this.route.paramMap.subscribe((params) => {
          this.bookingCode = params.get('sectionId') || '';
          if (this.bookingCode !== 'create' && this.bookingCode !== '') {
            this.bookingsForm.disable();
            this.paymentForm.disable();
            this.isEditMode = false;
            this.bookingService.getBookingByCode(this.bookingCode).subscribe({
              next: (booking) => {
                this.booking = booking;
                this.setBookingFormValues();
                this.bookingsForm.disable();
                this.paymentForm.disable();
                if (booking.booking_type === 'resource') {
                  this.columnDefs = this.resourceColDefs;
                  this.rowData = booking.items;
                  this.payments = booking?.payment??[];
                } else {
                  this.columnDefs = this.serviceColDefs;
                  this.rowData = booking.items;
                  this.payments =  booking?.payment??[];
                }
              },
              error: (error) => {
                this.toast.error('Could not fetch booking information!');
              },
            });
          } else {
            this.setBookingFormValues();
            this.setPaymentFormValues();
            this.loadResourcesTable(this.currentDate, this.nextDate);
          }
        });
      },
      error: () => {
        this.toast.error('could not fetch accounts');
      },
    });
    this.setBookingFormValues();
    this.setPaymentFormValues();
  }

  onGridReady(params: GridReadyEvent) {
    this.gridApi = params.api;
  }

  onSelectionChanged(event: any) {
    const selectedRows = this.gridApi.getSelectedRows();
    let totalAmount = 0;
    selectedRows.forEach((row) => {
      totalAmount += row.amount;
    });
    this.totalBookingAmount = totalAmount;
  }

  onBookingInfoUpdate() {
    const from_date = this.bookingsForm.get('booked_from')?.value;
    const to_date = this.bookingsForm.get('booked_to')?.value;
    if (this.bookingsForm.get('booking_type')?.value === 'resource') {
      this.loadResourcesTable(from_date, to_date);
    } else {
      this.loadServiceIntentionsTable(from_date.split('T')[0], to_date.split('T')[0]);
    }
  }

  setBookingFormValues() {
    this.bookingsForm = this.fb.group({
      booking_code: [this.booking?.booking_code || ''],
      booked_by: [this.booking?.booked_by || ''],
      contact: [this.booking?.contact || ''],
      family_code: [this.booking?.family_code || ''],
      event: [this.booking?.event || ''],
      description: [this.booking?.description || ''],
      booking_type: [this.booking?.booking_type || 'resource'],
      booked_from: [this.booking?.booked_from || this.currentDate],
      booked_to: [this.booking?.booked_to || this.nextDate],
      status: [this.booking?.status || ''],
    });
  }

  setPaymentFormValues() {
    this.paymentForm = this.fb.group({
      type: [this.payment?.type || 'BOOKINGS'],
      paid_to: [this.payment?.paid_to || ''],
      account_id: [
        this.payment?.account_id || this.accounts?.length > 0
          ? this.accounts[0].id
          : '',
      ],
      payment_mode: [this.payment?.payment_mode || 'cash'],
      booking_code: [this.payment?.booking_code || ''],
      description: [this.payment?.description || ''],
      amount: [this.payment?.amount || 0],
      currency: [this.payment?.currency || 'INR'],
    });
  }

  loadResourcesTable(from_date: string, to_date: string) {
    this.resourceService.getResourcesList().subscribe({
      next: (resources) => {
        this.columnDefs = this.resourceColDefs;
        this.rowData = resources;
      },
      error: () => {
        this.toast.error('error in loading resources');
      },
    });
  }

  loadServiceIntentionsTable(from_date: string, to_date: string) {
    this.liturgyService.getServicesOnDateRange(from_date, to_date).subscribe({
      next: (services) => {
        this.columnDefs = this.serviceColDefs;
        this.rowData = services;
      },
      error: () => {
        this.toast.error('error in loading resources');
      },
    });
  }

  onBackClick() {
    this.router.navigate(['bookings']);
  }

  onSave() {
    const bookingRequest: BookingRequest = this.bookingsForm?.value;
    const items: string[] = [];
    this.gridApi.getSelectedRows().map((row) => items.push(row.id));
    const payment: Payment = this.paymentForm?.value;
    bookingRequest.items = items;
    bookingRequest.payment = payment;
    bookingRequest.payment.payee = bookingRequest.booked_by;
    bookingRequest.payment.type = 'BOOKING';
    this.bookingService.createBookings(bookingRequest).subscribe({
      next: (booking) => {
        this.toast.success('Booking created successfully!');
        this.router.navigate(['/bookings']);
      },
      error: (error) => {
        this.toast.error(error);
      },
    });
  }
}
