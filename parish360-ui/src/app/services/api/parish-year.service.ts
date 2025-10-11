import { Observable } from 'rxjs';
import {
  PARISH_YEAR,
  PARISH_YEAR_BY_ID,
  RESOURCE_BY_ID,
  RESOURCES,
} from './api.constants';
import { ApiService } from './api.service';
import { Injectable } from '@angular/core';
import { Resource } from '../interfaces/resources.interface';
import { ParishYear } from '../interfaces/parish-year.interface';

@Injectable({ providedIn: 'root' })
export class ParishYearService {
  constructor(private apiService: ApiService) {}

  getParishYearList(): Observable<ParishYear[]> {
    return this.apiService.get<ParishYear[]>(PARISH_YEAR);
  }

  createParishYear(parishYear: ParishYear): Observable<ParishYear> {
    return this.apiService.post<ParishYear>(PARISH_YEAR, parishYear);
  }

  updateParishYear(
    parishYearId: string,
    parishYear: ParishYear
  ): Observable<ParishYear> {
    return this.apiService.patch<ParishYear>(
      PARISH_YEAR_BY_ID(parishYearId),
      parishYear
    );
  }

  deleteParishYear(parishYearId: string): Observable<void> {
    return this.apiService.delete<void>(PARISH_YEAR_BY_ID(parishYearId));
  }
}
