import { Observable } from 'rxjs';
import { BOOKINGS, EXTENSION, SERVICES, SERVICES_BY_ID } from './api.constants';
import { ApiService } from './api.service';
import { Injectable } from '@angular/core';
import { Bookings } from '../interfaces/bookings.interface';
import { Services } from '../interfaces/services.interface';

@Injectable({ providedIn: 'root' })
export class LiturgyService {
  constructor(private apiService: ApiService) {}

  getServices(): Observable<Services[]> {
    return this.apiService.get<Services[]>(SERVICES);
  }

  deleteService(serviceId: string): Observable<void> {
    return this.apiService.delete<void>(SERVICES_BY_ID(serviceId));
  }
}
