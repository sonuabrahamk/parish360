import { Observable } from 'rxjs';
import { BASE_URL } from './api.constants';
import { ApiService } from './api.service';
import { Injectable } from '@angular/core';
import { Member } from '../interfaces/member.interface';

@Injectable({ providedIn: 'root' })
export class MemberService {
  constructor(private apiService: ApiService) {}

  getMembers(recordId: string): Observable<Member[]> {
    return this.apiService.get<Member[]>(
        BASE_URL.FAMILY_RECORDS_BY_ID(recordId) +
        BASE_URL.MEMBERS_LIST
    );
  }

  createMember(recordId: string, member: Member): Observable<Member> {
    return this.apiService.post<Member>(
        BASE_URL.FAMILY_RECORDS_BY_ID(recordId) +
        BASE_URL.MEMBERS_LIST,
        member
    );
  }

  updateMember(recordId: string, memberId: string, member: Member): Observable<Member> {
    return this.apiService.patch<Member>(
        BASE_URL.FAMILY_RECORDS_BY_ID(recordId) +
        BASE_URL.MEMBER_BY_ID(memberId),
        member
    );
  }
}
