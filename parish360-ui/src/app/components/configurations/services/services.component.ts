import { CommonModule } from '@angular/common';
import { Component } from '@angular/core';
import { CanCreateDirective } from '../../../directives/can-create.directive';
import { CanDeleteDirective } from '../../../directives/can-delete.directive';
import { SCREENS } from '../../../services/common/common.constants';
import { Services } from '../../../services/interfaces/services.interface';
import { AgGridModule } from 'ag-grid-angular';
import {
  ColDef,
  GridApi,
  GridReadyEvent,
  RowSelectionOptions,
} from 'ag-grid-community';
import { LiturgyService } from '../../../services/api/liturgy.service';
import { StatusComponent } from '../../../pages/bookings/bookings-list/status.component';
import { ToastService } from '../../../services/common/toast.service';

@Component({
  selector: 'app-services',
  standalone: true,
  imports: [CommonModule, CanCreateDirective, CanDeleteDirective, AgGridModule],
  templateUrl: './services.component.html',
  styleUrl: './services.component.css',
})
export class ServicesComponent {
  screen: string = SCREENS.CONFIGURATIONS;

  private gridApi!: GridApi;

  rowData: Services[] = [];
  paginationPageSize = 10;
  paginationPageSizeSelector: number[] | boolean = [5, 10, 20];
  defaultColDef: ColDef = {
    flex: 1,
    filter: true,
    floatingFilter: true,
    sortable: true,
  };

  rowSelection: RowSelectionOptions | 'single' | 'multiple' = {
    mode: 'multiRow',
    checkboxes: true,
    headerCheckbox: true,
    enableClickSelection: true,
  };

  columnDefs: ColDef<Services>[] = [
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
      sortable: true,
    },
    {
      headerName: 'Start Time',
      field: 'start_time',
    },
    {
      headerName: 'End Time',
      field: 'end_time',
    },
    {
      headerName: 'Amount',
      field: 'amount',
    },
    {
      headerName: 'Currency',
      field: 'currency',
    },
    {
      headerName: 'Status',
      field: 'status',
      sortable: true,
      cellRenderer: StatusComponent,
    },
  ];

  constructor(
    private liturgyService: LiturgyService,
    private toast: ToastService
  ) {}

  ngOnInit() {
    this.liturgyService.getServices().subscribe({
      next: (response) => {
        this.rowData = response;
        this.rowData.map((service) => {
          const currentDate = new Date();
          const serviceDate = new Date(service.date);
          if (serviceDate.getTime() < currentDate.getTime()) {
            service.status = 'COMPLETED';
          } else {
            service.status = 'UPCOMING';
          }
        });
      },
      error: () => {
        this.toast.error('Could not fetch services list!');
      },
    });
  }

  onGridReady(params: GridReadyEvent) {
    this.gridApi = params.api;
  }

  onCreate() {
   this.toast.warn('Create service');
  }

  onDelete() {
    const selectedRows = this.gridApi.getSelectedRows();
    if (selectedRows.length <= 0) {
      this.toast.warn('No rows selected to be deleted!');
      return;
    }
    if (selectedRows.length > 1) {
      this.toast.warn('Delete action can be performed only on one row!');
      return;
    }
    this.liturgyService.deleteService(selectedRows[0]?.id).subscribe({
      next: () => {
        this.toast.success('Service removed successfully!');
        this.ngOnInit();
      },
      error: (error) => {
        this.toast.error(error.error);
      },
    });
  }
}
