export interface member {
  id: string;
  first_name: string;
  last_name: string;
  email: string;
  phone: string;
  address: string;
  dob: string;
}

export interface MembersResponse {
  members: member[];
}
