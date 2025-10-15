import { CommonModule } from '@angular/common';
import { Component } from '@angular/core';
import { FormBuilder, FormGroup, ReactiveFormsModule } from '@angular/forms';
import { Router } from '@angular/router';
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
  Bookings,
} from '../../../services/interfaces/bookings.interface';
import { ResourceService } from '../../../services/api/resource.service';
import { LiturgyService } from '../../../services/api/liturgy.service';
import { Payment } from '../../../services/interfaces/payments.interface';
import { Account } from '../../../services/interfaces/accounts.interface';
import { AccountService } from '../../../services/api/accounts.service';

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

  booking!: Bookings;
  bookingsForm!: FormGroup;

  accounts!: Account[];
  payment!: Payment;
  paymentForm!: FormGroup;

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

  constructor(
    private router: Router,
    private fb: FormBuilder,
    private resourceService: ResourceService,
    private liturgyService: LiturgyService,
    private accountService: AccountService,
  ) {}

  ngOnInit() {
    this.accountService.getAccountsList().subscribe({
      next: (accounts) => {
        this.accounts = accounts;
        this.setPaymentFormValues();
      },
      error: () => {
        console.log('could not fetch accounts');
      }
    });
    this.setBookingFormValues();
    this.setPaymentFormValues();
    this.loadResourcesTable(this.currentDate, this.nextDate);
  }

  onGridReady(params: GridReadyEvent) {
    this.gridApi = params.api;
  }

  onBookingInfoUpdate() {
    const from_date = this.bookingsForm.get('booked_from')?.value;
    const to_date = this.bookingsForm.get('booked_to')?.value;
    alert(from_date + '' + to_date);
    if (this.bookingsForm.get('booking_type')?.value === 'resource') {
      this.loadResourcesTable(from_date, to_date);
    } else {
      this.loadServiceIntentionsTable(from_date, to_date);
    }
  }

  setBookingFormValues() {
    this.bookingsForm = this.fb.group({
      id: [this.booking?.id || 'create'],
      booking_code: [this.booking?.booking_code || ''],
      booked_by: [this.booking?.booked_by || ''],
      contact: [this.booking?.contact || ''],
      family_code: [this.booking?.family_code || ''],
      event: [this.booking?.event || ''],
      note: [this.booking?.note || ''],
      booking_type: [this.booking?.booking_type || 'resource'],
      booked_from: [this.booking?.booked_from || this.currentDate],
      booked_to: [this.booking?.booked_to || this.nextDate],
      status: [this.booking?.status || ''],
    });
  }

  setPaymentFormValues() {
    this.paymentForm = this.fb.group({
      id: [this.payment?.id || 'create'],
      type: [this.payment?.type || 'BOOKINGS'],
      received_by: [this.payment?.received_by || ''],
      account: [
        this.payment?.account || this.accounts?.length > 0
          ? this.accounts[0].id
          : '',
      ],
      description: [this.payment?.description || ''],
      amount: [this.payment?.amount || 0],
      currency: [this.payment?.currency || 'INR'],
    });
  }

  loadResourcesTable(from_date: string, to_date: string) {
    this.resourceService.getResourcesList().subscribe({
      next: (resources) => {
        this.columnDefs = [
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
            field: 'booking_amount',
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
        this.rowData = resources;
      },
      error: () => {
        console.log('error in loading resources');
      },
    });
  }

  loadServiceIntentionsTable(from_date: string, to_date: string) {
    this.liturgyService.getServices().subscribe({
      next: (services) => {
        this.columnDefs = [
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
        this.rowData = services;
      },
      error: () => {
        console.log('error in loading resources');
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
    console.log(bookingRequest);
  }
}
