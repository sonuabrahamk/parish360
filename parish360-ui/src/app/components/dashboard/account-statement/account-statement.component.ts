import { CommonModule } from '@angular/common';
import { Component } from '@angular/core';
import { AgGridModule } from 'ag-grid-angular';
import {
  GridApi,
  ColDef,
  GridReadyEvent,
  FirstDataRenderedEvent,
} from 'ag-grid-community';
import { StatusComponent } from '../../../pages/bookings/bookings-list/status.component';
import { BookingService } from '../../../services/api/bookings.service';
import { SERVICE_TYPE_BOOKING } from '../../../services/common/common.constants';
import { AccountStatement } from '../../../services/interfaces/dashboard.interface';
import { DashboardService } from '../../../services/api/dashboard.service';
import { FormsModule } from '@angular/forms';

@Component({
  selector: 'app-account-statement',
  standalone: true,
  imports: [AgGridModule, CommonModule, FormsModule],
  templateUrl: './account-statement.component.html',
  styleUrl: './account-statement.component.css',
})
export class AccountStatementComponent {
  selectedDuration: string = 'week';
  rowData: AccountStatement[] = [];
  private gridApi!: GridApi;
  paginationPageSize = 10;
  paginationPageSizeSelector: number[] | boolean = [5, 10, 20];
  defaultColDef: ColDef = {
    resizable: true,
    filter: true,
    floatingFilter: true,
  };
  columnDefs: ColDef[] = [
    {
      headerName: 'Account',
      field: 'account_name',
    },
    {
      headerName: 'Date',
      field: 'date',
    },
    {
      headerName: 'Particulars',
      valueGetter: (params) =>
        `${params.data?.party || ''} - ${params.data?.description || ''}`,
      flex: 1,
    },
    {
      headerName: 'Type',
      field: 'type',
    },
    {
      headerName: 'Amount',
      field: 'payment',
    },
    {
      headerName: 'Currency',
      field: 'currency',
    },
  ];

  constructor(
    private dashboardService: DashboardService,
    private bookingService: BookingService
  ) {}

  ngOnInit() {
    const { from, to } = this.bookingService.findFromAndToDate(
      this.selectedDuration
    );
    this.updateAccountStatement(from, to);
  }

  onGridReady(params: GridReadyEvent) {
    this.gridApi = params.api;
    setTimeout(() => {
      this.gridAutoSizeColumns();
    });
  }

  gridAutoSizeColumns() {
    if (!this.gridApi) return;

    const allColumns = this.gridApi.getAllGridColumns();
    const columnsToSize = allColumns
      ?.filter((col) => col.getColDef()?.headerName !== 'Particulars')
      .map((col) => col.getColId());

    if (columnsToSize?.length) {
      this.gridApi.autoSizeColumns(columnsToSize, false);
    }
  }

  onFirstDataRendered(params: FirstDataRenderedEvent) {
    this.gridAutoSizeColumns();
  }

  onDurationUpdate() {
    const { from, to } = this.bookingService.findFromAndToDate(
      this.selectedDuration
    );
    this.updateAccountStatement(from, to);
  }

  updateAccountStatement(from: string, to: string) {
    this.dashboardService.getAccountStatement(from, to).subscribe({
      next: (statements) => {
        this.rowData = statements;
        this.gridAutoSizeColumns();
      },
      error: () => {
        console.log('error loading service intention bookings');
      },
    });
  }
}
