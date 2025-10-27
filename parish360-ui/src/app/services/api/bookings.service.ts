import { Observable } from 'rxjs';
import {
  BOOKING_BY_CODE,
  BOOKING_BY_ID,
  BOOKINGS,
  BOOKINGS_BY_TYPE,
  CANCEL_BOOKING_BY_ID,
  EXTENSION,
} from './api.constants';
import { ApiService } from './api.service';
import { Injectable } from '@angular/core';
import {
  BookingRequest,
  BookingResponse,
  Bookings,
} from '../interfaces/bookings.interface';

@Injectable({ providedIn: 'root' })
export class BookingService {
  constructor(private apiService: ApiService) {}

  getBookings(): Observable<Bookings[]> {
    return this.apiService.get<Bookings[]>(BOOKINGS);
  }

  getBookingsByType(type: string): Observable<Bookings[]> {
    return this.apiService.get<Bookings[]>(BOOKINGS_BY_TYPE(type));
  }

  getBookingByCode(code: string): Observable<BookingResponse> {
    return this.apiService.get<BookingResponse>(BOOKING_BY_CODE(code));
  }

  getBookingById(id: string): Observable<Bookings> {
    return this.apiService.get<Bookings>(BOOKING_BY_ID(id));
  }

  createBookings(booking: BookingRequest): Observable<Bookings> {
    return this.apiService.post<Bookings>(BOOKINGS, booking);
  }

  updateBookings(bookingId: string, booking: Bookings): Observable<Bookings> {
    return this.apiService.patch<Bookings>(BOOKING_BY_ID(bookingId), booking);
  }

  deleteBooking(id: string): Observable<Bookings> {
    return this.apiService.delete<Bookings>(BOOKING_BY_ID(id));
  }

  cancelBooking(bookingId: string): Observable<Bookings> {
    return this.apiService.patch<Bookings>(CANCEL_BOOKING_BY_ID(bookingId));
  }
}
