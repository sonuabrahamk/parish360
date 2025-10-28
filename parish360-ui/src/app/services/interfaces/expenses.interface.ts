export interface Expense {
  id: string;
  created_at: Date;
  date: Date;
  paid_to: string;
  paid_by: string;
  amount: number;
  currency: string;
  payment_method: string;
  description: string;
  account_id: string;
}
