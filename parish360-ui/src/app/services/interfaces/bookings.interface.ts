import { Payment } from './payments.interface';

export interface Bookings {
  id: string;
  booking_code: string;
  booked_by: string;
  contact: string;
  family_code: string;
  event: string;
  description: string;
  booking_type: string;
  booked_from: Date;
  booked_to: Date;
  status: string;
}

export interface BookingRequest {
  id: string;
  booking_code: string;
  booked_by: string;
  contact: number;
  family_code: string;
  event: string;
  description: string;
  booking_type: string;
  booked_from: Date;
  booked_to: Date;
  items: string[];
  payment: Payment;
}

export interface BookingResponse {
  id: string;
  booking_code: string;
  booked_by: string;
  contact: number;
  family_code: string;
  event: string;
  description: string;
  booking_type: string;
  booked_from: Date;
  booked_to: Date;
  status: string;
  items: any;
  payment: Payment[];
}
