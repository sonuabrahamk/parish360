import { Observable } from 'rxjs';
import { EXPENSES, EXTENSION } from './api.constants';
import { ApiService } from './api.service';
import { Injectable } from '@angular/core';
import { Expense } from '../interfaces/expenses.interface';

@Injectable({ providedIn: 'root' })
export class ExpenseService {
  constructor(private apiService: ApiService) {}

  getExpenses(): Observable<Expense[]> {
    return this.apiService.get<Expense[]>(EXPENSES + EXTENSION);
  }
}
