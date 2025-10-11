import { Observable } from 'rxjs';
import {
  ACCOUNT_BY_ID,
  ACCOUNTS,
} from './api.constants';
import { ApiService } from './api.service';
import { Injectable } from '@angular/core';
import { Account } from '../interfaces/accounts.interface';

@Injectable({ providedIn: 'root' })
export class AccountService {
  constructor(private apiService: ApiService) {}

  getAccountsList(): Observable<Account[]> {
    return this.apiService.get<Account[]>(ACCOUNTS);
  }

  createAccount(account: Account): Observable<Account> {
    return this.apiService.post<Account>(ACCOUNTS, account);
  }

  updateAccount(
    accountId: string,
    account: Account
  ): Observable<Account> {
    return this.apiService.patch<Account>(
      ACCOUNT_BY_ID(accountId),
      account
    );
  }

  deleteAccount(accountId: string): Observable<void> {
    return this.apiService.delete<void>(ACCOUNT_BY_ID(accountId));
  }
}
