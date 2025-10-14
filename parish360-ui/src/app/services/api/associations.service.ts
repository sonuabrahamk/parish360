import { Observable } from 'rxjs';
import {
  ASSOCIATES,
  ASSOCIATION_BY_ID,
  ASSOCIATIONS,
  COMMITTEE,
  COMMITTEE_MEMBER_BY_ID,
  MAPPED_ASSOCIATION_BY_ID,
} from './api.constants';
import { ApiService } from './api.service';
import { Injectable } from '@angular/core';
import { Association, Committee } from '../interfaces/associations.interface';

@Injectable({ providedIn: 'root' })
export class AssociationService {
  constructor(private apiService: ApiService) {}

  getAssociations(): Observable<Association[]> {
    return this.apiService.get<Association[]>(ASSOCIATIONS);
  }
  getAssociation(associationId: string): Observable<Association> {
    return this.apiService.get<Association>(ASSOCIATION_BY_ID(associationId));
  }

  createAssociation(association: Association): Observable<Association> {
    return this.apiService.post<Association>(ASSOCIATIONS, association);
  }

  updateAssociation(
    associationId: string,
    association: Association
  ): Observable<Association> {
    return this.apiService.patch<Association>(
      ASSOCIATION_BY_ID(associationId),
      association
    );
  }

  deleteAssociation(associationId: string): Observable<void> {
    return this.apiService.delete<void>(ASSOCIATION_BY_ID(associationId));
  }

  // Committee members related API's
  getAssociationCommitteList(pyAssociationId: string): Observable<Committee[]> {
    return this.apiService.get<Committee[]>(
      MAPPED_ASSOCIATION_BY_ID(pyAssociationId) + COMMITTEE
    );
  }

  createCommitteeMember(
    pyAssociationId: string,
    committeeMember: Committee
  ): Observable<Committee> {
    return this.apiService.post<Committee>(
      MAPPED_ASSOCIATION_BY_ID(pyAssociationId) + COMMITTEE,
      committeeMember
    );
  }

  updateCommitteeMember(
    pyAssociationId: string,
    committeeMemberId: string,
    committeeMember: Committee
  ): Observable<Committee> {
    return this.apiService.patch<Committee>(
      MAPPED_ASSOCIATION_BY_ID(pyAssociationId) +
        COMMITTEE_MEMBER_BY_ID(committeeMemberId),
      committeeMember
    );
  }

  deleteCommitteeMember(
    pyAssociationId: string,
    committeeMemberId: string
  ): Observable<void> {
    return this.apiService.delete<void>(
      MAPPED_ASSOCIATION_BY_ID(pyAssociationId) +
        COMMITTEE_MEMBER_BY_ID(committeeMemberId)
    );
  }

  // Associates related API's
  getAssociationAssociates(pyAssociationId: string): Observable<any> {
    return this.apiService.get<any>(
      MAPPED_ASSOCIATION_BY_ID(pyAssociationId) + ASSOCIATES
    );
  }

  mapAssociates(
    pyAssociationId: string,
    associates: string[]
  ): Observable<void> {
    return this.apiService.post<void>(
      MAPPED_ASSOCIATION_BY_ID(pyAssociationId) + ASSOCIATES,
      { associates: associates }
    );
  }

  unMapAssociates(
    pyAssociationId: string,
    associates: string[]
  ): Observable<void> {
    return this.apiService.delete<void>(
      MAPPED_ASSOCIATION_BY_ID(pyAssociationId) + ASSOCIATES,
      { associates: associates }
    );
  }
}
