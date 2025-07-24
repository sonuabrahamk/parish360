import { Observable } from 'rxjs';
import { ASSOCIATIONS, EXTENSION } from './api.constants';
import { ApiService } from './api.service';
import { Injectable } from '@angular/core';
import { Bookings } from '../interfaces/bookings.interface';
import { Association } from '../interfaces/associations.interface';

@Injectable({ providedIn: 'root' })
export class AssociationService {
  constructor(private apiService: ApiService) {}

  getAssociations(): Observable<Association[]> {
    return this.apiService.get<Association[]>(ASSOCIATIONS + EXTENSION);
  }
}
