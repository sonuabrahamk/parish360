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
  EXTENSION,
  MISCELLANOUS,
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

  getBlessingsRecords(recordId: string): Observable<BlessingRecord[]> {
    return this.apiService.get<BlessingRecord[]>(
      BASE_URL.FAMILY_RECORDS_BY_ID(recordId) + BLESSINGS
    );
  }

  getPaymentsList(recordId: string): Observable<FamilyPayments[]> {
    return this.apiService.get<FamilyPayments[]>(
      BASE_URL.FAMILY_RECORDS_BY_ID(recordId) + PAYMENTS
    );
  }
}
