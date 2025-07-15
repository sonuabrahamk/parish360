export interface FamilyRecord {
    id: string;
}

export interface FamilyRecordResponse {
    "family_records": FamilyRecord[];
}

export interface FamilyRecordSubscription {
    year: string;
    month: string;
    paid: boolean;
    amount: number;
}

export interface FamilyRecordSubscriptionResponse {
    "subscriptions": FamilyRecordSubscription[];
}