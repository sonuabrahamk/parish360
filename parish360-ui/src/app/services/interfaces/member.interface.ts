import { Place } from "./ceremonys.interface";

export interface Member {
  id: string;
  first_name: string;
  last_name: string;
  father: string;
  mother: string;
  email: string;
  contact: string;
  address: string;
  dob: string;
  occupation: string;
  qualification: string;
  birth_place: Place;
  relationship: string;
  gender: string;
  sacraments_details: Sacrament[];
  documents: Document[];
  migration_details: MigrationDetails[];
}

export interface Sacrament {
  id: string;
  type: string;
  place: string;
  parish: string;
  date: string;
  priest: string;
  god_father: string;
  god_mother: string;
  spouse: string;
}

export interface Document {
  id: string;
  file_name: string;
  type: string;
  description: string;
  upload_date: string;
  uploaded_by: string;
}

export interface MigrationDetails {
  id: string;
  date_of_migration: string;
  place_of_migration: string;
  reason: string;
  current_residence: string;
  contact: string;
  parish: string;
  return_date: string;
}

export interface MembersResponse {
  members: Member[];
}
