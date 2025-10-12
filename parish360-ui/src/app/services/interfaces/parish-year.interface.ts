import { Association } from './associations.interface';

export interface ParishYear {
  id: string;
  name: string;
  start_date: Date;
  end_date: Date;
  status: string;
  locked: boolean;
  comment: string;
}

export interface ParishYearAssociation {
  id: string;
  parish_year: ParishYear;
  association: Association;
}

export interface ParishYearAssociationRequest {
  associations: string[];
}
