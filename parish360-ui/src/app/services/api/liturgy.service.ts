import { Observable } from 'rxjs';
import { BOOKINGS, EXTENSION, SERVICES } from './api.constants';
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
}
