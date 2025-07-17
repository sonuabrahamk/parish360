import { Observable } from 'rxjs';
import { DIOCESE, FORANE, PARISH } from '../common/common.constants';
import {
  BlessingRecord,
  FamilyPayments,
  FamilyRecord,
  FamilyRecordResponse,
  FamilyRecordSubscriptionResponse,
  MiscellaneousRecord,
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

  dioceseId: string = JSON.parse(localStorage.getItem(DIOCESE) ?? '');
  foraneId: string = JSON.parse(localStorage.getItem(FORANE) ?? '');
  parishId: string = JSON.parse(localStorage.getItem(PARISH) ?? '');
  baseUrl: string =
    BASE_URL.DIOCESE_BY_ID(this.dioceseId) +
    BASE_URL.FORANE_BY_ID(this.foraneId) +
    BASE_URL.PARISH_BY_ID(this.parishId);

  getFamilyRecords(): Observable<FamilyRecordResponse> {
    return this.apiService.get<FamilyRecordResponse>(
      this.baseUrl + BASE_URL.FAMILY_RECORDS_LIST + EXTENSION
    );
  }

  getFamilyRecordInfo(recordId: string): Observable<FamilyRecord> {
    return this.apiService.get<FamilyRecord>(
      this.baseUrl + BASE_URL.FAMILY_RECORDS_BY_ID(recordId) + EXTENSION
    );
  }

  getFamilyRecordSubscriptions(
    recordId: string
  ): Observable<FamilyRecordSubscriptionResponse> {
    return this.apiService.get<FamilyRecordSubscriptionResponse>(
      this.baseUrl +
        BASE_URL.FAMILY_RECORDS_BY_ID(recordId) +
        SUBSCRIPTIONS +
        EXTENSION
    );
  }

  getBlessingsRecords(recordId: string): Observable<BlessingRecord[]> {
    return this.apiService.get<BlessingRecord[]>(
      this.baseUrl +
        BASE_URL.FAMILY_RECORDS_BY_ID(recordId) +
        BLESSINGS +
        EXTENSION
    );
  }

  getPaymentsList(recordId: string): Observable<FamilyPayments[]> {
    return this.apiService.get<FamilyPayments[]>(
      this.baseUrl +
        BASE_URL.FAMILY_RECORDS_BY_ID(recordId) +
        PAYMENTS +
        EXTENSION
    );
  }

  getMiscellaneousList(recordId: string): Observable<MiscellaneousRecord[]> {
    return this.apiService.get<MiscellaneousRecord[]>(
      this.baseUrl +
        BASE_URL.FAMILY_RECORDS_BY_ID(recordId) +
        MISCELLANOUS +
        EXTENSION
    );
  }
}
