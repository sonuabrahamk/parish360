export interface Resource {
  id: string;
  name: string;
  description: string;
  amount: number;
  currency: string;
  capacity: number;
  booking_amount: number;
  mass_compatible: boolean;
  active: boolean;
}
