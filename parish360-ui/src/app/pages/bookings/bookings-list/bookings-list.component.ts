import { Component } from '@angular/core';
import { CanCreateDirective } from '../../../directives/can-create.directive';
import { CommonModule } from '@angular/common';
import {
  BOOKINGS,
  RESOURCE_TYPE_BOOKING,
  RESOURCES_TAB,
  SCREENS,
  SERVICE_INTENTION_TAB,
  SERVICE_TYPE_BOOKING,
} from '../../../services/common/common.constants';
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
import { ToastService } from '../../../services/common/toast.service';

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
    {
      label: RESOURCES_TAB,
      icon: faBoxesPacking,
      url: `${BOOKINGS}/${RESOURCE_TYPE_BOOKING}`,
    },
    {
      label: SERVICE_INTENTION_TAB,
      icon: faPrayingHands,
      url: `${BOOKINGS}/${SERVICE_TYPE_BOOKING}`,
    },
  ];
  activeTabIndex = 0;

  rowData: any[] = [];
  private gridApi!: GridApi;
  paginationPageSize = 10;
  paginationPageSizeSelector: number[] | boolean = [5, 10, 20];
  defaultColDef: ColDef = {
    resizable: true,
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
    private route: ActivatedRoute,
    private toastService: ToastService
  ) {}

  ngOnInit() {
    this.route.params.subscribe((params) => {
      const section = params['section'] ?? '';
      switch (section) {
        case SERVICE_TYPE_BOOKING:
          this.bookingType = SERVICE_TYPE_BOOKING;
          this.activeTabIndex = 1;
          this.loadServiceIntentionsList();
          break;
        case RESOURCE_TYPE_BOOKING:
          this.bookingType = SERVICE_TYPE_BOOKING;
          this.activeTabIndex = 0;
          this.loadResourcesList();
          break;
        default:
          this.router.navigate([`/bookings/${RESOURCE_TYPE_BOOKING}`]);
          return;
      }
    });
  }

  onGridReady(params: GridReadyEvent) {
    this.gridApi = params.api;
    setTimeout(() => {
      this.gridAutoSizeColumns();
    });
  }

  gridAutoSizeColumns() {
    const columns = this.gridApi.getAllGridColumns().filter(column => column?.getColDef()?.field !== 'description');
    const colIds = columns.map((col) => col.getColId());
    this.gridApi.autoSizeColumns(colIds);
  }

  onCreate() {
    this.router.navigateByUrl(`/bookings/view/create`);
  }

  async onRowAction(type: string) {
    const selectedRows = this.gridApi.getSelectedRows();
    if (!selectedRows || selectedRows.length <= 0) {
      this.toastService.warn('No row selected to perform any operation!');
      return;
    }
    if (selectedRows.length > 1) {
      this.toastService.warn(
        'Only one row can be selected to perform any operation!'
      );
      return;
    }
    const id = selectedRows[0]?.id ?? selectedRows[0]?.['id'];
    switch (type) {
      case 'delete':
        if (
          await this.toastService.confirm(
            'Are you sure you want to perform delete opeation on ' +
              selectedRows[0]?.booking_code +
              ' ?'
          )
        ) {
          this.bookingService.deleteBooking(id).subscribe({
            next: () => {
              this.toastService.success(
                'Successfully delete a booking record!'
              );
              this.ngOnInit();
            },
            error: (error) => {
              this.toastService.error(error);
            },
          });
        }
        break;
      case 'cancel':
        if (
          await this.toastService.confirm(
            'Are you sure you want to perform cancel opeation on ' +
              selectedRows[0]?.booking_code +
              ' ?'
          )
        ) {
          this.bookingService.cancelBooking(id).subscribe({
            next: () => {
              this.toastService.success(
                'Successfully cancelled a booking record!'
              );
              this.ngOnInit();
            },
            error: (error) => {
              this.toastService.error(error);
            },
          });
        }
        break;
      case 'payment':
        this.router.navigateByUrl('/payments/create?booking_code=' + id);
        break;
      default:
        this.toastService.warn('No action selected!');
        break;
    }
  }

  loadResourcesList() {
    this.bookingService.getBookingsByType(RESOURCE_TYPE_BOOKING).subscribe({
      next: (bookings) => {
        this.columnDefs = [
          {
            headerName: 'Booking Code',
            field: 'booking_code',
            cellRenderer: (params: any) =>
              `<a href="/bookings/view/${params.value}" >${params.value}</a>`,
          },
          {
            headerName: 'Booked From',
            field: 'booked_from',
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
            headerName: 'Resource',
            field: 'resource.name',
          },
          {
            headerName: 'Note',
            field: 'description',
            flex: 1,
          },
          {
            headerName: 'Payment Status',
            field: 'payment_status',
            cellClass: 'ag-center-cols-cell',
            cellRenderer: StatusComponent,
          },
          {
            headerName: 'Status',
            field: 'status',
            cellClass: 'ag-center-cols-cell',
            cellRenderer: StatusComponent,
          },
        ];
        this.rowData = bookings;
        this.gridAutoSizeColumns();
      },
      error: (error) => {
        this.toastService.error(error.error.message);
      },
    });
  }

  loadServiceIntentionsList() {
    this.bookingService.getBookingsByType(SERVICE_TYPE_BOOKING).subscribe({
      next: (bookings) => {
        this.columnDefs = [
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
        this.rowData = bookings;
        this.gridAutoSizeColumns();
      },
      error: () => {
        console.log('error loading service intention bookings');
      },
    });
  }
}
