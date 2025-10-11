import { Observable } from 'rxjs';
import { MiscellaneousRecord } from '../interfaces/family-record.interface';
import { BASE_URL, MISCELLANOUS, MISCELLANOUS_BY_ID } from './api.constants';
import { ApiService } from './api.service';
import { Injectable } from '@angular/core';

@Injectable({ providedIn: 'root' })
export class MiscellenousService {
  constructor(private apiService: ApiService) {}

  getMiscellaneousList(recordId: string): Observable<MiscellaneousRecord[]> {
    return this.apiService.get<MiscellaneousRecord[]>(
      BASE_URL.FAMILY_RECORDS_BY_ID(recordId) + MISCELLANOUS
    );
  }

  createMiscellaneousRecord(
    recordId: string,
    miscellenous: MiscellaneousRecord
  ): Observable<MiscellaneousRecord> {
    return this.apiService.post<MiscellaneousRecord>(
      BASE_URL.FAMILY_RECORDS_BY_ID(recordId) + MISCELLANOUS,
      miscellenous
    );
  }

  updateMiscellaneousRecord(
    recordId: string,
    miscellenousId: string,
    miscellenous: MiscellaneousRecord
  ): Observable<MiscellaneousRecord> {
    return this.apiService.patch<MiscellaneousRecord>(
      BASE_URL.FAMILY_RECORDS_BY_ID(recordId) +
        MISCELLANOUS_BY_ID(miscellenousId),
      miscellenous
    );
  }

  deleteMiscellaneousRecord(
    recordId: string,
    miscellenousId: string
  ): Observable<void> {
    return this.apiService.delete<void>(
      BASE_URL.FAMILY_RECORDS_BY_ID(recordId) +
        MISCELLANOUS_BY_ID(miscellenousId)
    );
  }
}
