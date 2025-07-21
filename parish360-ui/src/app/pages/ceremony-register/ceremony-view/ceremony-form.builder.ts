import { FormBuilder, FormGroup } from '@angular/forms';
import {
  Ceremony,
  Parish,
  Place,
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
      details: this.setDetails(ceremony),
    });
  }

  private setMinister(ceremony?: Ceremony) {
    return this.fb.group({
      name: [ceremony?.minister?.name || ''],
      title: [ceremony?.minister?.title || ''],
    });
  }

  private setDetails(ceremony?: Ceremony) {
    return this.fb.group({
      baptism_name: [ceremony?.details?.baptism_name || ''],
      dob: [ceremony?.details?.dob || new Date()],
      marital_status: [ceremony?.details?.marital_status || ''],
      father: [ceremony?.details?.father || ''],
      mother: [ceremony?.details?.mother || ''],
      place_of_birth: this.setPlace(ceremony?.details?.place_of_birth),
      parish: this.setParish(ceremony?.details?.parish),
    });
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
}
