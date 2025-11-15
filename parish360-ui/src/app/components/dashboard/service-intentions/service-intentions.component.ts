import { CommonModule } from '@angular/common';
import { Component } from '@angular/core';
import { AgGridModule } from 'ag-grid-angular';
import { BookingService } from '../../../services/api/bookings.service';
import { Bookings } from '../../../services/interfaces/bookings.interface';
import { ColDef, GridApi, GridReadyEvent } from 'ag-grid-community';
import { StatusComponent } from '../../../pages/bookings/bookings-list/status.component';
import { SERVICE_TYPE_BOOKING } from '../../../services/common/common.constants';

@Component({
  selector: 'app-service-intentions',
  standalone: true,
  imports: [AgGridModule, CommonModule],
  templateUrl: './service-intentions.component.html',
  styleUrl: './service-intentions.component.css',
})
export class ServiceIntentionsComponent {
  rowData: Bookings[] = [];
  private gridApi!: GridApi;
  paginationPageSize = 10;
  paginationPageSizeSelector: number[] | boolean = [5, 10, 20];
  defaultColDef: ColDef = {
    resizable: true,
    filter: false,
    floatingFilter: false,
  };
  columnDefs: ColDef[] = [
    {
      headerName: 'Booking Code',
      field: 'booking_code',
      cellRenderer: (params: any) =>
        `<a href="/bookings/view/${params.value}" >${params.value}</a>`,
    },
    {
      headerName: 'Booked By',
      field: 'booked_by',
    },
    {
      headerName: 'Contact',
      field: 'contact',
    },
    {
      headerName: 'Booking On',
      field: 'booked_from',
    },
    {
      headerName: 'Intention',
      field: 'description',
      flex: 1,
    },
    {
      headerName: 'Status',
      field: 'status',
      cellClass: 'ag-center-cols-cell',
      cellRenderer: StatusComponent,
    },
    {
      headerName: 'Payment Status',
      field: 'payment_status',
      cellClass: 'ag-center-cols-cell',
      cellRenderer: StatusComponent,
    },
  ];

  constructor(private bookingService: BookingService) {}

  ngOnInit() {
    this.bookingService.getBookingsByType(SERVICE_TYPE_BOOKING).subscribe({
      next: (bookings) => {
        this.rowData = bookings;
        this.gridAutoSizeColumns();
      },
      error: () => {
        console.log('error loading service intention bookings');
      },
    });
  }

  onGridReady(params: GridReadyEvent) {
    this.gridApi = params.api;
    setTimeout(() => {
      this.gridAutoSizeColumns();
    });
  }

  gridAutoSizeColumns() {
    const columns = this.gridApi
      .getAllGridColumns()
      .filter((column) => column?.getColDef()?.field !== 'description');
    const colIds = columns.map((col) => col.getColId());
    this.gridApi.autoSizeColumns(colIds);
  }
}
