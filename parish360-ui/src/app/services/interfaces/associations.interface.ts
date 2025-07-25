export interface Association {
  id: string;
  parish_id: string;
  parish_year: string;
  name: string;
  description: string;
  president: string;
  p_contact: string;
  vice_president: string;
  vp_contact: string;
  members_count: number;
  founded_on: Date;
  status: boolean;
}

export interface Member {
  member_id: string;
  book_no: string;
  name: string;
  role: string;
  contact: string;
  email: string;
  joined: Date;
  status: string;
}