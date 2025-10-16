import { Component } from '@angular/core';
import { CanCreateDirective } from '../../../directives/can-create.directive';
import { CommonModule } from '@angular/common';
import { SCREENS } from '../../../services/common/common.constants';
import { AgGridModule } from 'ag-grid-angular';
import {
  ColDef,
  GridApi,
  GridReadyEvent,
  RowSelectionOptions,
} from 'ag-grid-community';
import { BookingService } from '../../../services/api/bookings.service';
import { ActivatedRoute, Router } from '@angular/router';
import { CanDeleteDirective } from '../../../directives/can-delete.directive';
import { StatusComponent } from './status.component';
import {
  Tab,
  TabsComponent,
} from '../../../components/common/tabs/tabs.component';
import {
  faBoxesPacking,
  faPrayingHands,
} from '@fortawesome/free-solid-svg-icons';

@Component({
  selector: 'app-bookings-list',
  standalone: true,
  imports: [
    CommonModule,
    CanCreateDirective,
    CanDeleteDirective,
    AgGridModule,
    TabsComponent,
  ],
  templateUrl: './bookings-list.component.html',
  styleUrl: './bookings-list.component.css',
})
export class BookingsListComponent {
  screen: string = SCREENS.BOOKINGS;

  bookingType!: string;
  bookingTab: Tab[] = [
    { label: 'Resources', icon: faBoxesPacking, url: `bookings/resources` },
    {
      label: 'Service Intentions',
      icon: faPrayingHands,
      url: `bookings/service-intentions`,
    },
  ];
  activeTabIndex = 0;

  rowData: any[] = [];
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

  columnDefs: ColDef<any>[] = [];

  constructor(
    private bookingService: BookingService,
    private router: Router,
    private route: ActivatedRoute
  ) {}

  ngOnInit() {
    this.route.params.subscribe((params) => {
      const section = params['section'] ?? '';
      switch (section) {
        case 'service-intentions':
          this.bookingType = 'service-intentions';
          this.activeTabIndex = 1;
          this.loadServiceIntentionsList();
          break;
        case 'resources':
        case '':
          this.bookingType = 'resources';
          this.activeTabIndex = 0;
          this.loadResourcesList();
          break;
        default:
          this.router.navigateByUrl('/bookings');
          return;
      }
    });
    this.bookingService.getBookings().subscribe((bookings) => {
      this.rowData = bookings;
    });
  }

  onGridReady(params: GridReadyEvent) {
    this.gridApi = params.api;
  }

  onCreate() {
    this.router.navigateByUrl(`/bookings/view/create`);
  }

  onDelete() {
    console.log(this.gridApi.getSelectedRows());
  }

  loadResourcesList() {
    this.bookingService.getBookings().subscribe({
      next: (bookings) => {
        this.columnDefs = [
          {
            headerName: 'Booking Code',
            field: 'booking_code',
          },
          {
            headerName: 'Booking Type',
            field: 'booking_type',
          },
          {
            headerName: 'Date',
            field: 'booked_from',
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
        this.rowData = bookings;
      },
      error: () => {
        console.log('error loading resource bookings');
      },
    });
  }

  loadServiceIntentionsList() {
    this.bookingService.getBookings().subscribe({
      next: (bookings) => {
        this.columnDefs = [
          {
            headerName: 'Booking Code',
            field: 'booking_code',
          },
          {
            headerName: 'Booked By',
            field: 'booked_by',
          },
          {
            headerName: 'Booking On',
            field: 'booked_from',
          },
          {
            headerName: 'Event',
            field: 'event',
          },
          {
            headerName: 'Intention',
            field: 'note',
          },
          {
            headerName: 'Contact',
            field: 'contact',
          },
          {
            headerName: 'Status',
            field: 'status',
            cellClass: 'ag-center-cols-cell',
            cellRenderer: StatusComponent,
          },
        ];
        this.rowData = bookings;
      },
      error: () => {
        console.log('error loading service intention bookings');
      },
    });
  }
}
