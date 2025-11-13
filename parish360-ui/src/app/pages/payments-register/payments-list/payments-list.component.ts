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
import { ToastService } from '../../../services/common/toast.service';

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
      headerName: 'Paid To',
      field: 'paid_to',
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

  constructor(
    private paymentService: PaymentService,
    private router: Router,
    private toast: ToastService
  ) {}

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
    const selectedRows = this.gridApi.getSelectedRows();
    if (selectedRows.length === 0) {
      this.toast.warn('No payment selected for deletion.');
      return;
    }
    if (selectedRows.length > 1) {
      this.toast.warn('Please select only one payment to delete at a time.');
      return;
    }
    this.toast
      .confirm('Are you sure you want to delete the selected payment?')
      .then((confirmed) => {
        if (confirmed) {
          const paymentId = selectedRows[0].id;
          this.paymentService.deletePayment(paymentId).subscribe({
            next: () => {
              this.toast.success('Payment deleted successfully.');
              this.rowData = this.rowData.filter(
                (payment) => payment.id !== paymentId
              );
            },
            error: (error) => {
              this.toast.error(
                'Failed to delete the payment: ' + error.message
              );
            },
          });
        }
      });
  }

  onPrintReceipt() {
    const selectedRows = this.gridApi.getSelectedRows();
    if (selectedRows.length === 0) {
      this.toast.warn('No payment selected for printing receipt.');
      return;
    }
    if (selectedRows.length > 1) {
      this.toast.warn('Please select only one payment to print receipt at a time.');
      return;
    }
    const paymentId = selectedRows[0].id;
    this.paymentService.getReceipt(paymentId).subscribe({
      next: (receiptBlob) => {
        this.paymentService.printReceipt(receiptBlob);
      },
      error: (error) => {
        this.toast.error('Failed to fetch the receipt: ' + error.message);
      },
    });
  }
}
