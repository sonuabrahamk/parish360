import { Observable } from 'rxjs';
import {
  BOOKING_BY_CODE,
  BOOKING_BY_ID,
  BOOKINGS,
  BOOKINGS_BY_TYPE,
  BOOKINGS_BY_TYPE_AND_RANGE,
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

  getBookingsByTypeAndRange(
    type: string,
    startDate: string,
    endDate: string
  ): Observable<Bookings[]> {
    return this.apiService.get<Bookings[]>(
      BOOKINGS_BY_TYPE_AND_RANGE(type, startDate, endDate)
    );
  }

  findFromAndToDate(type: string): { from: string; to: string } {
    let today = new Date();
    let from: Date;
    let to: Date;
    let diffToMonday: number;
    switch (type) {
      case 'week':
        diffToMonday = today.getDay() === 0 ? -6 : 1 - today.getDay();
        from = new Date(today);
        from.setDate(today.getDate() + diffToMonday);
        to = new Date(today);
        to.setDate(today.getDate() + (diffToMonday + 6));
        return {
          from: this.formatLocalDate(from),
          to: this.formatLocalDate(to),
        };
      case 'today':
        const todayStr = today.toISOString().split('T')[0];
        return { from: todayStr, to: todayStr };
      case 'month':
        from = new Date(today.getFullYear(), today.getMonth(), 1);
        to = new Date(today.getFullYear(), today.getMonth() + 1, 0);
        return {
          from: this.formatLocalDate(from),
          to: this.formatLocalDate(to),
        };
      case 'year':
        from = new Date(today.getFullYear(), 0, 1);
        to = new Date(today.getFullYear(), 11, 31);
        return {
          from: this.formatLocalDate(from),
          to: this.formatLocalDate(to),
        };
      default:
        return { from: '', to: '' };
    }
  }

  formatLocalDate(d: Date) {
    const year = d.getFullYear();
    const month = (d.getMonth() + 1).toString().padStart(2, '0');
    const day = d.getDate().toString().padStart(2, '0');
    return `${year}-${month}-${day}`;
  }
}
