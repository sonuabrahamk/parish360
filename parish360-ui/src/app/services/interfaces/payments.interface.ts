export interface Payment {
  id: string;
  parish_id: string;
  type: string;
  received_by: string;
  payee: string;
  payment_on: Date;
  amount: number;
  currency: string;
  remarks: string;
  subscriptions: Subscription[];
  donations: Donation[];
  bookings: BookingsPayment[];
}

export interface Subscription {
  book_no: string;
  from: Date;
  to: Date;
  note: string;
}

export interface Donation {
  association: string;
  note: string;
}

export interface BookingsPayment {
  booking_id: string;
  type: string;
  note: string;
}
