import { Observable } from 'rxjs';
import { ASSOCIATION_BY_ID, ASSOCIATIONS } from './api.constants';
import { ApiService } from './api.service';
import { Injectable } from '@angular/core';
import { Association } from '../interfaces/associations.interface';

@Injectable({ providedIn: 'root' })
export class AssociationService {
  constructor(private apiService: ApiService) {}

  getAssociations(): Observable<Association[]> {
    return this.apiService.get<Association[]>(ASSOCIATIONS);
  }

  createAssociation(association: Association):Observable<Association>{
    return this.apiService.post<Association>(ASSOCIATIONS, association);
  }

  updateAssociation(associationId: string, association: Association):Observable<Association>{
    return this.apiService.patch<Association>(ASSOCIATION_BY_ID(associationId), association);
  }

  deleteAssociation(associationId: string):Observable<void>{
    return this.apiService.delete<void>(ASSOCIATION_BY_ID(associationId));
  }
}
