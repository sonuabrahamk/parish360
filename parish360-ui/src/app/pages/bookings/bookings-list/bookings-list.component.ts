import { Component } from '@angular/core';
import { CanCreateDirective } from '../../../directives/can-create.directive';
import { CommonModule } from '@angular/common';
import { SCREENS } from '../../../services/common/common.constants';
import { Bookings } from '../../../services/interfaces/bookings.interface';
import { AgGridModule } from 'ag-grid-angular';
import {
  ColDef,
  GridApi,
  GridOptions,
  GridReadyEvent,
  RowSelectionModule,
  RowSelectionOptions,
} from 'ag-grid-community';
import { BookingService } from '../../../services/api/bookings.service';
import { Router } from '@angular/router';
import { CanDeleteDirective } from '../../../directives/can-delete.directive';
import { StatusComponent } from './status.component';

@Component({
  selector: 'app-bookings-list',
  standalone: true,
  imports: [CommonModule, CanCreateDirective, CanDeleteDirective, AgGridModule],
  templateUrl: './bookings-list.component.html',
  styleUrl: './bookings-list.component.css',
})
export class BookingsListComponent {
  screen: string = SCREENS.BOOKINGS;

  rowData: Bookings[] = [];
  private gridApi!: GridApi;
  paginationPageSize = 10;
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

  columnDefs: ColDef<Bookings>[] = [
    {
      headerName: 'Booking ID',
      field: 'booking_id',
    },
    {
      headerName: 'Booking Type',
      field: 'booking_type',
    },
    {
      headerName: 'Date',
      field: 'date',
    },
    {
      headerName: 'Event',
      field: 'event',
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
      headerName: 'Note',
      field: 'note',
    },
    {
      headerName: 'Status',
      field: 'status',
      cellClass: 'ag-center-cols-cell',
      cellRenderer: StatusComponent,
    },
  ];

  constructor(private bookingService: BookingService, private router: Router) {}

  ngOnInit() {
    this.bookingService.getBookings().subscribe((bookings) => {
      this.rowData = bookings;
    });
  }

  onGridReady(params: GridReadyEvent) {
    this.gridApi = params.api;
  }

  onCreate() {
    this.router.navigate(['/bookings/create']);
  }

  onDelete() {
    console.log(this.gridApi.getSelectedRows());
  }
}
