export interface Payment {
  id: string;
  created_at: Date;
  type: string;
  paid_to: string;
  payee: string;
  description: string;
  account_id: string;
  amount: number;
  currency: string;
  payment_mode: string;
  conversion_rate: string;
  booking_code: string;
  reference_id: string;
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
