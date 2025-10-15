import { Component } from '@angular/core';
import { SCREENS } from '../../../services/common/common.constants';
import { Payment } from '../../../services/interfaces/payments.interface';
import {
  ColDef,
  GridApi,
  GridReadyEvent,
  RowSelectionOptions,
} from 'ag-grid-community';
import { CommonModule } from '@angular/common';
import { AgGridModule } from 'ag-grid-angular';
import { PaymentService } from '../../../services/api/payments.service';
import { Router } from '@angular/router';
import { CanCreateDirective } from '../../../directives/can-create.directive';
import { CanDeleteDirective } from '../../../directives/can-delete.directive';

@Component({
  selector: 'app-payments-list',
  standalone: true,
  imports: [CommonModule, AgGridModule, CanCreateDirective, CanDeleteDirective],
  templateUrl: './payments-list.component.html',
  styleUrl: './payments-list.component.css',
})
export class PaymentsListComponent {
  screen: string = SCREENS.PAYMENTS;

  rowData: Payment[] = [];
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

  columnDefs: ColDef<Payment>[] = [
    {
      headerName: 'Payment ID',
      field: 'id',
      cellRenderer: (params: any) =>
        `<a href="/payments/view/${params.value}">${params.value}</a>`,
    },
    {
      headerName: 'Payment Type',
      field: 'type',
    },
    {
      headerName: 'Payment Date',
      field: 'created_at',
    },
    {
      headerName: 'Payment By',
      field: 'payee',
    },
    {
      headerName: 'Received By',
      field: 'received_by',
    },
    {
      headerName: 'Amount',
      field: 'amount',
    },
    {
      headerName: 'Remarks',
      field: 'description',
    },
  ];

  constructor(private paymentService: PaymentService, private router: Router) {}

  ngOnInit() {
    this.paymentService.getPayments().subscribe((payments) => {
      this.rowData = payments;
    });
  }

  onGridReady(params: GridReadyEvent) {
    this.gridApi = params.api;
  }

  onCreate() {
    this.router.navigate(['/payments/create']);
  }

  onDelete() {
    console.log(this.gridApi.getSelectedRows());
  }
}
