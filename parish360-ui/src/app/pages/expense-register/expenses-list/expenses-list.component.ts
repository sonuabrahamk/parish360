import { Component } from '@angular/core';
import { SCREENS } from '../../../services/common/common.constants';
import { Expense } from '../../../services/interfaces/expenses.interface';
import { CommonModule } from '@angular/common';
import { AgGridModule } from 'ag-grid-angular';
import {
  GridApi,
  ColDef,
  RowSelectionOptions,
  GridReadyEvent,
} from 'ag-grid-community';
import { Router } from '@angular/router';
import { ExpenseService } from '../../../services/api/expenses.service';
import { CanCreateDirective } from '../../../directives/can-create.directive';
import { CanDeleteDirective } from '../../../directives/can-delete.directive';
import { ToastService } from '../../../services/common/toast.service';

@Component({
  selector: 'app-expenses-list',
  standalone: true,
  imports: [CommonModule, AgGridModule, CanCreateDirective, CanDeleteDirective],
  templateUrl: './expenses-list.component.html',
  styleUrl: './expenses-list.component.css',
})
export class ExpensesListComponent {
  screen: string = SCREENS.EXPENSES;

  rowData: Expense[] = [];
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

  columnDefs: ColDef<Expense>[] = [
    {
      headerName: 'Expense ID',
      field: 'id',
      cellRenderer: (params: any) =>
        `<a href="/expenses/view/${params.value}">${params.value}</a>`,
    },
    {
      headerName: 'Expense On',
      field: 'date',
      cellRenderer: (params: any) =>
        params.value ? new Date(params.value).toISOString().split('T')[0] : '',
    },
    {
      headerName: 'Paid to',
      field: 'paid_to',
    },
    {
      headerName: 'Paid By',
      field: 'paid_by',
    },
    {
      headerName: 'Description',
      field: 'description',
    },
    {
      headerName: 'Amount',
      field: 'amount',
    },
    {
      headerName: 'Curency',
      field: 'currency',
    },
  ];

  constructor(
    private router: Router,
    private expenseService: ExpenseService,
    private toast: ToastService
  ) {}

  ngOnInit() {
    this.expenseService.getExpenses().subscribe((expense) => {
      this.rowData = expense;
    });
  }

  onCreate() {
    this.router.navigate(['/expenses/create']);
  }

  onDelete() {
    const selectedRows = this.gridApi.getSelectedRows();
    if (selectedRows.length === 0) {
      this.toast.warn('Please select atleast one expense to delete.');
      return;
    }
    if (selectedRows.length > 1) {
      this.toast.warn('Please select only one expense to delete at a time.');
      return;
    }
    this.toast
      .confirm(
        'Are you sure you want to delete the selected expense? This action is irreversible.'
      )
      .then((confirmed) => {
        if (confirmed) {
          const expenseId = selectedRows[0].id;
          this.expenseService.deleteExpense(expenseId).subscribe({
            next: () => {
              this.toast.success('Expense deleted successfully.');
              this.gridApi.applyTransaction({ remove: selectedRows });
            },
            error: (error) => {
              this.toast.error('Error deleting expense: ', error);
            },
          });
        }
      });
  }

  onGridReady(params: GridReadyEvent) {
    this.gridApi = params.api;

    const columnIds = this.gridApi
      .getAllGridColumns()
      .filter((col) => col.getColDef().field !== 'description');
    setInterval(() => {
      if (this.gridApi && !this.gridApi.isDestroyed()) {
        this.gridApi.autoSizeColumns(columnIds);
      }
    });
  }
}
