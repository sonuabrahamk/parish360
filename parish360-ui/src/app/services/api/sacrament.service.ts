import { Observable } from 'rxjs';
import { BASE_URL } from './api.constants';
import { ApiService } from './api.service';
import { Injectable } from '@angular/core';
import { Member, Sacrament } from '../interfaces/member.interface';

@Injectable({ providedIn: 'root' })
export class SacramentService {
  constructor(private apiService: ApiService) {}

  getSacraments(recordId: string, memberId: string): Observable<Sacrament[]> {
    return this.apiService.get<Sacrament[]>(
        BASE_URL.FAMILY_RECORDS_BY_ID(recordId) +
        BASE_URL.MEMBER_BY_ID(memberId) +
        BASE_URL.SACRAMENTS_LIST
    );
  }

  createSacrament(recordId: string, memberId: string, sacrament: Sacrament): Observable<Sacrament> {
    return this.apiService.post<Sacrament>(
        BASE_URL.FAMILY_RECORDS_BY_ID(recordId) +
        BASE_URL.MEMBER_BY_ID(memberId) +
        BASE_URL.SACRAMENTS_LIST,
        sacrament
    );
  }

  updateSacrament(recordId: string, memberId: string, sacramentId: string, sacrament: Sacrament): Observable<Sacrament> {
    return this.apiService.patch<Sacrament>(
        BASE_URL.FAMILY_RECORDS_BY_ID(recordId) +
        BASE_URL.MEMBER_BY_ID(memberId) +
        BASE_URL.SACRAMENT_BY_ID(sacramentId),
        sacrament
    );
  }

  deleteSacrament(recordId: string, memberId: string, sacramentId: string): Observable<void> {
    return this.apiService.delete<void>(
        BASE_URL.FAMILY_RECORDS_BY_ID(recordId) +
        BASE_URL.MEMBER_BY_ID(memberId) +
        BASE_URL.SACRAMENT_BY_ID(sacramentId)
    );
  }
}
