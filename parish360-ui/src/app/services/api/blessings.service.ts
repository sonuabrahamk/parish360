import { Observable } from 'rxjs';
import {
  BlessingRecord,
} from '../interfaces/family-record.interface';
import {
  BASE_URL,
  BLESSING_BY_ID,
  BLESSINGS
} from './api.constants';
import { ApiService } from './api.service';
import { Injectable } from '@angular/core';

@Injectable({ providedIn: 'root' })
export class BlessingService {
  constructor(private apiService: ApiService) {}

  getBlessingsRecords(recordId: string): Observable<BlessingRecord[]> {
    return this.apiService.get<BlessingRecord[]>(
      BASE_URL.FAMILY_RECORDS_BY_ID(recordId) + BLESSINGS
    );
  }

  createBlessingsRecord(recordId: string, blessing: BlessingRecord): Observable<BlessingRecord> {
    return this.apiService.post<BlessingRecord>(
      BASE_URL.FAMILY_RECORDS_BY_ID(recordId) + BLESSINGS,
      blessing
    );
  }

  updateBlessingsRecord(recordId: string, blessingId: string, blessing: BlessingRecord): Observable<BlessingRecord> {
    return this.apiService.patch<BlessingRecord>(
      BASE_URL.FAMILY_RECORDS_BY_ID(recordId) + BLESSING_BY_ID(blessingId),
      blessing
    );
  }

  deleteBlessingsRecord(recordId: string, blessingId: string): Observable<void> {
    return this.apiService.delete<void>(
      BASE_URL.FAMILY_RECORDS_BY_ID(recordId) + BLESSING_BY_ID(blessingId)
    );
  }
}
