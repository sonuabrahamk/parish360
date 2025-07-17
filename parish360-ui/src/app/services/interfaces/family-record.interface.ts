export interface FamilyRecord {
  id: string;
  book_no: string;
  head_of_family: string;
  family_name: string;
  parish: string;
  unit: string;
  mobile: string;
  address: string;
  created_date: string;
}

export interface FamilyRecordResponse {
  family_records: FamilyRecord[];
}

export interface FamilyRecordSubscription {
  year: string;
  month: string;
  paid: boolean;
  amount: number;
}

export interface FamilyRecordSubscriptionResponse {
  subscriptions: FamilyRecordSubscription[];
}

export interface BlessingRecord {
  id: string;
  priest: string;
  date: Date;
  reason: string;
}
