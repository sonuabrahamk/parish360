import { FormArray, FormBuilder, FormGroup } from '@angular/forms';
import {
  Ceremony,
  GodParents,
  Parish,
  Place,
  Witness,
} from '../../../services/interfaces/ceremonys.interface';

export class CeremonyFormBuilder {
  constructor(private fb: FormBuilder) {}

  buildForm(ceremony?: Ceremony): FormGroup {
    return this.fb.group({
      type: [ceremony?.type || ''],
      date: [ceremony?.date || ''],
      parishioner: [ceremony?.parishioner || false],
      name: [ceremony?.name || ''],
      minister: this.setMinister(ceremony),
      details: this.setDetails(ceremony?.details, false),
      ordination_details: this.setOrdinationDetails(ceremony),
      afterlife_details: this.setAfterlifeDetails(ceremony),
      spouse_details: this.setDetails(ceremony?.spouse_details, true),
      witness: this.setWitness(ceremony?.witness),
    });
  }

  private setMinister(ceremony?: Ceremony) {
    return this.fb.group({
      name: [ceremony?.minister?.name || ''],
      title: [ceremony?.minister?.title || ''],
    });
  }

  private setDetails(details?: any, type?: boolean) {
    const detailsGroup: any = {
      baptism_name: [details?.baptism_name || ''],
      dob: [details?.dob || ''],
      marital_status: [details?.marital_status || ''],
      father: [details?.father || ''],
      mother: [details?.mother || ''],
      place_of_birth: this.setPlace(details?.place_of_birth),
      parish: this.setParish(details?.parish),
      god_parents: this.setGodParents(details?.god_parents),
    };
    if (type) {
      detailsGroup.name = details?.name;
    }
    return this.fb.group(detailsGroup);
  }

  private setParish(parish?: Parish) {
    return this.fb.group({
      book_id: [parish?.book_id || ''],
      name: [parish?.name || ''],
      diocese: [parish?.diocese || ''],
      place: this.setPlace(parish?.place),
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

  private setGodParents(godParents?: GodParents) {
    return this.fb.group({
      father: this.fb.group({
        name: [godParents?.father?.name || ''],
        parish: [godParents?.father?.parish || ''],
        baptism_name: [godParents?.father?.baptism_name || ''],
        contact: [godParents?.father?.contact || ''],
      }),
      mother: this.fb.group({
        name: [godParents?.mother?.name || ''],
        parish: [godParents?.mother?.parish || ''],
        baptism_name: [godParents?.mother?.baptism_name || ''],
        contact: [godParents?.mother?.contact || ''],
      }),
    });
  }

  private setOrdinationDetails(ceremony?: Ceremony) {
    return this.fb.group({
      religious_order: [ceremony?.ordination_details?.religious_order || ''],
      seminary: this.fb.group({
        name: [ceremony?.ordination_details?.seminary?.name || ''],
        location: this.setPlace(
          ceremony?.ordination_details?.seminary?.location
        ),
      }),
      previous_ordination: this.fb.group({
        type: [ceremony?.ordination_details?.previous_ordination?.type || ''],
        date: [ceremony?.ordination_details?.previous_ordination?.date || ''],
        bishop: [
          ceremony?.ordination_details?.previous_ordination?.bishop || '',
        ],
        place: this.setPlace(
          ceremony?.ordination_details?.previous_ordination?.place
        ),
      }),
    });
  }

  private setAfterlifeDetails(ceremony?: Ceremony) {
    return this.fb.group({
      dod: [ceremony?.afterlife_details?.dod || ''],
      place_of_death: this.setPlace(
        ceremony?.afterlife_details?.place_of_death
      ),
      cemetry: [ceremony?.afterlife_details?.cemetry || ''],
      cemetry_place: this.setPlace(ceremony?.afterlife_details?.cemetry_place),
    });
  }

  private setWitness(witness?: Witness[]): FormArray<any> {
    if (witness?.length) {
      return this.fb.array(this.createWitnessForm(witness));
    }
    return this.fb.array([]);
  }

  private createWitnessForm(witness: Witness[]): FormGroup[] {
    return witness.map((person) =>
      this.fb.group({
        name: [person?.name || ''],
        relation: [person?.relation || ''],
        parish: [person?.parish || ''],
        contact: [person?.contact || ''],
      })
    );
  }
}
