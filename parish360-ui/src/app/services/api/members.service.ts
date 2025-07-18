import { Observable } from 'rxjs';
import { MembersResponse } from '../interfaces/member.interface';
import { BASE_URL, EXTENSION } from './api.constants';
import { ApiService } from './api.service';
import { Injectable } from '@angular/core';

@Injectable({ providedIn: 'root' })
export class MemberService {
  constructor(private apiService: ApiService) {}

  getMembers(recordId: string): Observable<MembersResponse> {
    return this.apiService.get<MembersResponse>(
        BASE_URL.FAMILY_RECORDS_BY_ID(recordId) +
        BASE_URL.MEMBERS_LIST +
        EXTENSION
    );
  }
}
