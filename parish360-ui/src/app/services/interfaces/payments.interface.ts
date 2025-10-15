export interface Payment {
  id: string;
  created_at: Date;
  type: string;
  received_by: string;
  payee: string;
  description: string;
  account: string;
  amount: number;
  currency: string;
  conversion_rate: string;
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
