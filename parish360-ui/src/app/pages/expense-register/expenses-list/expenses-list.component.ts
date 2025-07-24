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
    },
    {
      headerName: 'Category',
      field: 'category',
    },
    {
      headerName: 'Amount',
      field: 'amount',
    },
    {
      headerName: 'Paid to',
      field: 'paid_to',
    },
    {
      headerName: 'Payment method',
      field: 'payment_method',
    },
    {
      headerName: 'Remarks',
      field: 'remarks',
    },
  ];

  constructor(private router: Router, private expenseService: ExpenseService) {}

  ngOnInit() {
    this.expenseService.getExpenses().subscribe((expense) => {
      this.rowData = expense;
    });
  }

  onCreate() {
    this.router.navigate(['/expenses/create']);
  }

  onDelete() {
    console.log('Delete function');
  }

  onGridReady(params: GridReadyEvent) {
    this.gridApi = params.api;
  }
}
