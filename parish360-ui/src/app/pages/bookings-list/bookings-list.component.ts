import { Component } from '@angular/core';
import { CanCreateDirective } from '../../directives/can-create.directive';
import { CommonModule } from '@angular/common';
import { SCREENS } from '../../services/common/common.constants';
import { Bookings } from '../../services/interfaces/bookings.interface';
import { AgGridAngular } from 'ag-grid-angular';
import { ColDef } from 'ag-grid-community';
import { BookingService } from '../../services/api/bookings.service';

@Component({
  selector: 'app-bookings-list',
  standalone: true,
  imports: [CommonModule, CanCreateDirective, AgGridAngular],
  templateUrl: './bookings-list.component.html',
  styleUrl: './bookings-list.component.css'
})
export class BookingsListComponent {
  screen: string = SCREENS.BOOKINGS;

  rowData: Bookings[] = [];
  paginationPageSize = 10;
  paginationPageSizeSelector: number[] | boolean = [5, 10, 20];
  defaultColDef: ColDef = {
    flex: 1,
    filter: true,
    floatingFilter: true,
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
    }
  ]

  constructor(private bookingService: BookingService){}

  ngOnInit(){
    this.bookingService.getBookings().subscribe((bookings) => {
      this.rowData = bookings;
    });
  }
  
}
