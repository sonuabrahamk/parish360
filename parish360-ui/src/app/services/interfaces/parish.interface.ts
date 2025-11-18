import { Place } from '../common/interfaces';

export interface Parish {
  id: string;
  created_at: Date;
  created_by: string;
  updated_at: Date;
  updated_by: string;
  name: string;
  denomination: string;
  patron: string;
  dial_code: string;
  contact: string;
  email: string;
  founded_date: Date;
  is_active: boolean;
  locale: string;
  timezone: string;
  currency: string;
  place: Place;
}
