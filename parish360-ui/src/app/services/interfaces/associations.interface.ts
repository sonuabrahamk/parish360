export interface Association {
  id: string;
  name: string;
  description: string;
  type: string;
  director: string;
  founded_date: Date;
  patron: string;
  scope: string;
  active: boolean;
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
export interface Committee {
  id: string;
  designation: string;
  position: string;
  name: string;
  contact: string;
  email: string;
}
