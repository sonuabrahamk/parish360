import { FormArray, FormBuilder, FormGroup } from '@angular/forms';
import {
  Ceremony,
  GodParent,
  Parish,
  Place,
  Witness,
} from '../../../services/interfaces/ceremonys.interface';
import { CEREMONY_TYPE } from '../../../services/common/common.constants';

export class CeremonyFormBuilder {
  constructor(private fb: FormBuilder) {}

  buildForm(ceremony?: Ceremony): FormGroup {
    return this.fb.group({
      type: [ceremony?.type || CEREMONY_TYPE.BAPTISM],
      date: [ceremony?.date || new Date().toISOString().substring(0, 10)],
      is_parishioner: [ceremony?.is_parishioner || false],
      name: [ceremony?.name || ''],
      baptism_name: [ceremony?.baptism_name || ''],
      dob: [ceremony?.dob || ''],
      marital_status: [ceremony?.marital_status || ''],
      father: [ceremony?.father || ''],
      mother: [ceremony?.mother || ''],
      birth_place: this.setPlace(ceremony?.birth_place),
      church: this.setParish(ceremony?.church),
      god_father: this.setGodParent(ceremony?.god_father),
      god_mother: this.setGodParent(ceremony?.god_mother),
      minister: this.setMinister(ceremony),
      ordination: this.setOrdinationDetails(ceremony),
      afterlife: this.setAfterlifeDetails(ceremony),
      spouse: this.setSpouseDetails(ceremony?.spouse),
      witness1: this.setWitness(ceremony?.witness1),
      witness2: this.setWitness(ceremony?.witness2),
    });
  }

  private setMinister(ceremony?: Ceremony) {
    return this.fb.group({
      priest: [ceremony?.minister?.priest || ''],
      title: [ceremony?.minister?.title || ''],
    });
  }

  private setSpouseDetails(spouse?: any) {
    return this.fb.group({
      spouse_name: [spouse?.spouse_name || ''],
      spouse_baptism_name: [spouse?.spouse_baptism_name || ''],
      spouse_dob: [spouse?.spouse_dob || ''],
      spouse_marital_status: [spouse?.spouse_marital_status || ''],
      spouse_father: [spouse?.spouse_father || ''],
      spouse_mother: [spouse?.spouse_mother || ''],
      spouse_birth_place: this.setPlace(spouse?.spouse_birth_place),
      spouse_god_father: this.setGodParent(spouse?.spouse_god_father),
      spouse_god_mother: this.setGodParent(spouse?.spouse_god_mother),
    });
  }

  private setParish(parish?: Parish) {
    return this.fb.group({
      family_code: [parish?.family_code || ''],
      church: [parish?.church || ''],
      diocese: [parish?.diocese || ''],
      church_location: this.setPlace(parish?.church_location),
    });
  }

  private setPlace(place?: Place) {
    return this.fb.group({
      location: [place?.location || ''],
      city: [place?.city || ''],
      state: [place?.state || ''],
      country: [place?.country || ''],
    });
  }

  private setGodParent(godParent?: GodParent) {
    return this.fb.group({
      name: [godParent?.name || ''],
      parish: [godParent?.parish || ''],
      baptism_name: [godParent?.baptism_name || ''],
      contact: [godParent?.contact || ''],
    });
  }

  private setOrdinationDetails(ceremony?: Ceremony) {
    return this.fb.group({
      religious_order: [ceremony?.ordination?.religious_order || ''],
      seminary_name: [ceremony?.ordination?.seminary_name || ''],
      previous_ordination_type: [
        ceremony?.ordination?.previous_ordination_type || '',
      ],
      previous_ordination_date: [
        ceremony?.ordination?.previous_ordination_date || '',
      ],
      seminary_address: this.setPlace(ceremony?.ordination.seminary_address),
      previous_ordination_place: this.setPlace(
        ceremony?.ordination?.previous_ordination_place
      ),
    });
  }

  private setAfterlifeDetails(ceremony?: Ceremony) {
    return this.fb.group({
      dod: [ceremony?.afterlife?.dod || ''],
      place_of_death: this.setPlace(ceremony?.afterlife?.place_of_death),
      cemetry: [ceremony?.afterlife?.cemetry || ''],
      cemetry_place: this.setPlace(ceremony?.afterlife?.cemetry_place),
    });
  }

  private setWitness(witness?: Witness) {
    return this.fb.group({
      name: [witness?.name || ''],
      relation: [witness?.relation || ''],
      parish: [witness?.parish || ''],
      contact: [witness?.contact || ''],
    });
  }
}
