export interface Summary {
  number_of_units: number;
  number_of_associations: number;
  number_of_families: number;
  number_of_members: number;
}

export interface AccountStatement {
  account_name: string;
  date: Date;
  type: string;
  party: string;
  description: string;
  payment: number;
  currency: string;
}
