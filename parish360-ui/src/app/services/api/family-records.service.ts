import { Observable } from 'rxjs';
import {
  BlessingRecord,
  FamilyPayments,
  FamilyRecord,
  FamilyRecordSubscription,
} from '../interfaces/family-record.interface';
import {
  BASE_URL,
  BLESSINGS,
  PAYMENTS,
  SUBSCRIPTIONS,
} from './api.constants';
import { ApiService } from './api.service';
import { Injectable } from '@angular/core';

@Injectable({ providedIn: 'root' })
export class FamilyRecords {
  constructor(private apiService: ApiService) {}

  getFamilyRecords(): Observable<FamilyRecord[]> {
    return this.apiService.get<FamilyRecord[]>(BASE_URL.FAMILY_RECORDS_LIST);
  }

  getFamilyRecordInfo(recordId: string): Observable<FamilyRecord> {
    return this.apiService.get<FamilyRecord>(
      BASE_URL.FAMILY_RECORDS_BY_ID(recordId)
    );
  }

  getFamilyRecordSubscriptions(
    recordId: string
  ): Observable<FamilyRecordSubscription[]> {
    return this.apiService.get<FamilyRecordSubscription[]>(
      BASE_URL.FAMILY_RECORDS_BY_ID(recordId) + SUBSCRIPTIONS
    );
  }

  createFamilyRecordInfo(
    familyRecord: FamilyRecord
  ): Observable<FamilyRecord> {
    return this.apiService.post<FamilyRecord>(
      BASE_URL.FAMILY_RECORDS_LIST,
      familyRecord
    );
  }

  updateFamilyRecordInfo(
    recordId: string,
    familyRecord: FamilyRecord
  ): Observable<FamilyRecord> {
    return this.apiService.patch<FamilyRecord>(
      BASE_URL.FAMILY_RECORDS_BY_ID(recordId),
      familyRecord
    );
  }
}
