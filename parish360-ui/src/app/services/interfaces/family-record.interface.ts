export interface FamilyRecord {
  id: string;
  created_at: Date;
  created_by: string;
  updated_at: Date;
  updated_by: string;
  family_code: string;
  family_name: string;
  contact: string;
  address: string;
  contact_verified: boolean;
  joined_date: Date;
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

export interface FamilyPayments {
  id: string;
  receipt_no: string;
  date: Date;
  payment_by: string;
  reason: string;
  amount: number;
  currency: string;
}

export interface MiscellaneousRecord {
  id: string;
  date: Date;
  commented_by: string;
  comment: string;
}
