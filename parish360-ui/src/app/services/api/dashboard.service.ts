import { Injectable } from '@angular/core';
import { Observable } from 'rxjs';
import { ACCOUNT_STATEMENT, BASE_URL, DASHBOARD } from './api.constants';
import { ApiService } from './api.service';
import { AccountStatement, Summary } from '../interfaces/dashboard.interface';
import { Member } from '../interfaces/member.interface';

@Injectable({ providedIn: 'root' })
export class DashboardService {
  constructor(private apiService: ApiService) {}

  getParishReport(): Observable<Summary> {
    return this.apiService.get<Summary>(DASHBOARD);
  }

  getAllMembers(): Observable<Member[]> {
    return this.apiService.get<Member[]>(DASHBOARD + BASE_URL.MEMBERS_LIST);
  }

  getAccountStatement(
    startDate: string,
    endDate: string
  ): Observable<AccountStatement[]> {
    return this.apiService.get<AccountStatement[]>(
      ACCOUNT_STATEMENT(startDate, endDate)
    );
  }
}
