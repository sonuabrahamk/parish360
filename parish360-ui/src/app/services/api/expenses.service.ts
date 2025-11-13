import { Observable } from 'rxjs';
import { EXPENSE_BY_ID, EXPENSES, EXTENSION } from './api.constants';
import { ApiService } from './api.service';
import { Injectable } from '@angular/core';
import { Expense } from '../interfaces/expenses.interface';

@Injectable({ providedIn: 'root' })
export class ExpenseService {
  constructor(private apiService: ApiService) {}

  getExpenses(): Observable<Expense[]> {
    return this.apiService.get<Expense[]>(EXPENSES);
  }

  getExpense(expenseId: string): Observable<Expense> {
    return this.apiService.get<Expense>(EXPENSE_BY_ID(expenseId));
  }

  createExpense(expenseData: Expense): Observable<Blob> {
    return this.apiService.post<Blob>(EXPENSES, expenseData, {
      responseType: 'blob',
    });
  }

  updateExpense(expenseId: string, expenseData: Expense): Observable<Expense> {
    return this.apiService.patch<Expense>(
      EXPENSE_BY_ID(expenseId),
      expenseData
    );
  }

  deleteExpense(expenseId: string): Observable<void> {
    return this.apiService.delete<void>(EXPENSE_BY_ID(expenseId));
  }
  
  getVoucher(expenseId: string): Observable<Blob> {
    return this.apiService.get<Blob>(`${EXPENSE_BY_ID(expenseId)}/voucher`, {
      responseType: 'blob',
    });
  }

  printVoucher(voucherBlob: Blob) {
    const url = URL.createObjectURL(voucherBlob);
    const iframe = document.createElement('iframe');
    iframe.style.display = 'none';
    iframe.src = url;
    document.body.appendChild(iframe);

    iframe.onload = () => {
      iframe.contentWindow?.focus();
      iframe.contentWindow?.print();

      window.addEventListener('afterprint', () => {
        document.body.removeChild(iframe);
        URL.revokeObjectURL(url);
      });
    };
  }
}
