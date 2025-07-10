import { Observable } from 'rxjs';
import { DIOCESE, FORANE, PARISH } from '../common/common.constants';
import { FamilyRecordResponse } from '../interfaces/family-record.interface';
import { BASE_URL, EXTENSION } from './api.constants';
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
}
