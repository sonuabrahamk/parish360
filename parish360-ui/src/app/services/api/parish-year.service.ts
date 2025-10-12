import { Observable } from 'rxjs';
import {
  MAPPED_ASSOCIATIONS,
  PARISH_YEAR,
  PARISH_YEAR_BY_ID,
} from './api.constants';
import { ApiService } from './api.service';
import { Injectable } from '@angular/core';
import {
  ParishYear,
  ParishYearAssociation,
  ParishYearAssociationRequest,
} from '../interfaces/parish-year.interface';

@Injectable({ providedIn: 'root' })
export class ParishYearService {
  constructor(private apiService: ApiService) {}

  getParishYearList(): Observable<ParishYear[]> {
    return this.apiService.get<ParishYear[]>(PARISH_YEAR);
  }

  getParishYearInfo(parishYearId: string): Observable<ParishYear> {
    return this.apiService.get<ParishYear>(PARISH_YEAR_BY_ID(parishYearId));
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

  getParishYearAssociations(
    parishYearId: string
  ): Observable<ParishYearAssociation[]> {
    return this.apiService.get<ParishYearAssociation[]>(
      PARISH_YEAR_BY_ID(parishYearId) + MAPPED_ASSOCIATIONS
    );
  }

  unMapAssociationsFromParishYear(
    parishYearId: string,
    associationIds: ParishYearAssociationRequest
  ): Observable<ParishYearAssociation[]> {
    return this.apiService.delete<ParishYearAssociation[]>(
      PARISH_YEAR_BY_ID(parishYearId) + MAPPED_ASSOCIATIONS,
      associationIds
    );
  }
}
