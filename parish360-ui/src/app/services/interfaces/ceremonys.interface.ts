export interface Ceremony {
  id: string;
  type: string;
  date: Date;
  minister: {
    priest: string;
    title: string;
  };
  name: string;
  is_parishioner: boolean;
  baptism_name: string;
  dob: Date;
  birth_place: Place;
  marital_status: string;
  father: string;
  mother: string;
  god_father: GodParent;
  god_mother: GodParent;
  church: Parish;
  witness1: Witness;
  witness2: Witness;
  spouse: {
    spouse_name: string;
    spouse_baptism_name: string;
    spouse_dob: Date;
    spouse_birth_place: Place;
    spouse_marital_status: string;
    spouse_father: string;
    spouse_mother: string;
    spouse_god_father: GodParent;
    spouse_god_mother: GodParent;
  };
  ordination: {
    religious_order: string;
    seminary_name: string;
    seminary_address: Place;
    previous_ordination_type: string;
    previous_ordination_date: Date;
    previous_ordination_place: Place;
  };
  afterlife: {
    dod: Date;
    place_of_death: Place;
    cemetry: string;
    cemetry_place: Place;
  };
  remarks: string;
}

export interface Place {
  location: string;
  city: string;
  state: string;
  country: string;
}

export interface GodParent {
  name: string;
  parish: string;
  baptism_name: string;
  contact: string;
}

export interface Parish {
  family_code: string;
  church: string;
  diocese: string;
  church_location: Place;
}

export interface Witness {
  name: string;
  relation: string;
  parish: string;
  contact: number;
}
