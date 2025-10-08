import { Observable } from 'rxjs';
import { ASSOCIATION_BY_YEAR, ASSOCIATIONS, COMMITTEE, EXTENSION, MEMBERS } from './api.constants';
import { ApiService } from './api.service';
import { Injectable } from '@angular/core';
import { Bookings } from '../interfaces/bookings.interface';
import { Association, Member } from '../interfaces/associations.interface';

@Injectable({ providedIn: 'root' })
export class AssociationService {
  constructor(private apiService: ApiService) {}

  getAssociations(): Observable<Association[]> {
    return this.apiService.get<Association[]>(ASSOCIATIONS);
  }

  getAssociation(associationId: string, parishYear?: string): Observable<Association> {
    if (!parishYear){
      parishYear = 'JAN2025-DEC2025';
    }
    return this.apiService.get<Association>(ASSOCIATION_BY_YEAR(associationId, parishYear) + `/${associationId}`)
  }

  getAssociationCommitteeMembers(associationId: string, parishYear?: string): Observable<Member[]> {
    if (!parishYear){
      parishYear = 'JAN2025-DEC2025';
    }
    return this.apiService.get<Member[]>(ASSOCIATION_BY_YEAR(associationId, parishYear) + COMMITTEE)
  }

  getAssociationMembers(associationId: string, parishYear?: string): Observable<Member[]> {
    if (!parishYear){
      parishYear = 'JAN2025-DEC2025';
    }
    return this.apiService.get<Member[]>(ASSOCIATION_BY_YEAR(associationId, parishYear) + MEMBERS)
  }
}
