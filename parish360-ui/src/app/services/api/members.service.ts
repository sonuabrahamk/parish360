import { Observable } from 'rxjs';
import { MembersResponse } from '../interfaces/member.interface';
import { BASE_URL, EXTENSION } from './api.constants';
import { ApiService } from './api.service';
import { DIOCESE, FORANE, PARISH } from '../common/common.constants';
import { Injectable } from '@angular/core';

@Injectable({ providedIn: 'root' })
export class MemberService {
  constructor(private apiService: ApiService) {}

  dioceseId: string = localStorage.getItem(DIOCESE) ?? '';
  foraneId: string = localStorage.getItem(FORANE) ?? '';
  parishId: string = localStorage.getItem(PARISH) ?? '';
  baseUrl: string =
    BASE_URL.DIOCESE_BY_ID(this.dioceseId) +
    BASE_URL.FORANE_BY_ID(this.foraneId) +
    BASE_URL.PARISH_BY_ID(this.parishId);

  getMembers(recordId: string): Observable<MembersResponse> {
    return this.apiService.get<MembersResponse>(
      this.baseUrl +
        BASE_URL.FAMILY_RECORDS_BY_ID(recordId) +
        BASE_URL.MEMBERS_LIST +
        EXTENSION
    );
  }
}
