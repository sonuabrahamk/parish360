export interface Association {
  id: string;
  parish_id: string;
  name: string;
  description: string;
  president: string;
  p_contact: number;
  vice_president: string;
  vp_contact: number;
  members_count: number;
  founded_on: Date;
  status: boolean;
}
