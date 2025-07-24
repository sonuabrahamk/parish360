export interface Expense {
  id: string;
  date: Date;
  category: string;
  amount: number;
  currency: string;
  paid_to: string;
  payment_method: string;
  remarks: string;
}
