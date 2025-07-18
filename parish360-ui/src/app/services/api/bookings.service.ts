import { Observable } from 'rxjs';
import { BOOKINGS, EXTENSION } from './api.constants';
import { ApiService } from './api.service';
import { Injectable } from '@angular/core';
import { Bookings } from '../interfaces/bookings.interface';

@Injectable({ providedIn: 'root' })
export class BookingService {
  constructor(private apiService: ApiService) {}

  getBookings(): Observable<Bookings[]> {
    return this.apiService.get<Bookings[]>(BOOKINGS + EXTENSION);
  }
}
