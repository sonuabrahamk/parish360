export interface Ceremony {
  id: string;
  type: string;
  date: Date;
  minister: {
    name: string;
    title: string;
  };
  name: string;
  parishioner: boolean;
  details: {
    baptism_name: string;
    dob: Date;
    place_of_birth: Place;
    marital_status: string;
    father: string;
    mother: string;
    god_parents: GodParents;
    parish: Parish;
  };
  witness: Witness[];
  spouse_details: {
    name: string;
    baptism_name: string;
    dob: Date;
    place_of_birth: Place;
    marital_status: string;
    father: string;
    mother: string;
    god_parents: GodParents;
    parish: Parish;
  };
  ordination_details: {
    religious_order: string;
    seminary: {
      name: string;
      location: Place;
    };
    previous_ordination: {
      type: string;
      date: Date;
      place: Place;
      bishop: string;
    };
  };
  afterlife_details: {
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

export interface GodParents {
  father: {
    name: string;
    parish: string;
    baptism_name: string;
    contact: number;
  };
  mother: {
    name: string;
    parish: string;
    baptism_name: string;
    contact: number;
  };
}

export interface Parish {
  book_id: string;
  name: string;
  place: Place;
  diocese: string;
}

export interface Witness {
  name: string;
  relation: string;
  parish: string;
  contact: number;
}
