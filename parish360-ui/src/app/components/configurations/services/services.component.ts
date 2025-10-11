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

@Component({
  selector: 'app-services',
  standalone: true,
  imports: [
    CommonModule,
    CanCreateDirective,
    CanDeleteDirective,
    AgGridModule,
  ],
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
      headerName: 'Status',
      field: 'status',
      cellRenderer: StatusComponent,
    },
  ];

  constructor(private liturgyService: LiturgyService) {}

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
            service.status = 'IN-PROGRESS';
          }
        });
      },
      error: () => {
        console.log('Could not fetch services list!');
      },
    });
  }

  onGridReady(params: GridReadyEvent) {
    this.gridApi = params.api;
  }

  onCreate() {
    console.log('Create service');
  }
  onDelete() {
    console.log('Delete service');
  }
}
