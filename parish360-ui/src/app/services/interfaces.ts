export interface Member {
  id: string;
  first_name: string;
  last_name: string;
  father: string;
  mother: string;
  email: string;
  phone: string;
  address: string;
  dob: string;
  occupation: string;
  qualification: string;
  birth_place: string;
  relationship: string;
  gender: string;
  age: number;
  sacrament_details: {
    baptism: {
      date: string;
      place: string;
      parish: string;
    };
    confirmation: {
      date: string;
      place: string;
      priest: string;
      parish: string;
    };
    holy_communion: {
      date: string;
      place: string;
      priest: string;
      parish: string;
    };
    marriage: {
      date: string;
      place: string;
      priest: string;
      parish: string;
    };
    holy_ordination: {
      date: string;
      place: string;
      bishop: string;
      parish: string;
    };
    anointing_of_the_sick: {
      date: string;
      place: string;
      priest: string;
      parish: string;
    };
  };
  documents: Document[];
  migration_details: MigrationDetails[];
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
