import { CommonModule } from '@angular/common';
import { Component } from '@angular/core';
import {
  SCREENS,
  CEREMONY_TYPE,
} from '../../../services/common/common.constants';
import { CeremoniesService } from '../../../services/api/ceremonies.service';
import { ActivatedRoute, Router, RouterModule } from '@angular/router';
import {
  FormArray,
  FormBuilder,
  FormControl,
  FormGroup,
  ReactiveFormsModule,
} from '@angular/forms';
import { FontAwesomeModule } from '@fortawesome/angular-fontawesome';
import { faArrowLeft } from '@fortawesome/free-solid-svg-icons';
import { FooterComponent } from '../../../components/family-records/footer/footer.component';
import { SectionFormComponent } from '../../../components/common/section-form/section-form.component';
import { CeremonyFormBuilder } from './ceremony-form.builder';
import { Ceremony } from '../../../services/interfaces/ceremonys.interface';
import { ToastService } from '../../../services/common/toast.service';

@Component({
  selector: 'app-ceremony-view',
  standalone: true,
  imports: [
    CommonModule,
    ReactiveFormsModule,
    FontAwesomeModule,
    FooterComponent,
    SectionFormComponent,
  ],
  templateUrl: './ceremony-view.component.html',
  styleUrl: './ceremony-view.component.css',
})
export class CeremonyViewComponent {
  screen: string = SCREENS.CEREMONIES;
  ceremonyType = CEREMONY_TYPE;
  isEditMode: boolean = true;
  ceremonyId!: string;
  ceremony!: Ceremony;
  ceremonyForm!: FormGroup;

  //Icons declaration
  faArrowLeft = faArrowLeft;

  ceremonyList = [
    CEREMONY_TYPE.BAPTISM,
    CEREMONY_TYPE.HOLY_COMMUNION,
    CEREMONY_TYPE.HOLY_CONFIRMATION,
    CEREMONY_TYPE.MARRIAGE,
    CEREMONY_TYPE.ORDINATION,
    CEREMONY_TYPE.REQUIEM,
  ];

  constructor(
    private route: ActivatedRoute,
    private router: Router,
    private fb: FormBuilder,
    private ceremonyService: CeremoniesService,
    private toast: ToastService
  ) {}

  ngOnInit() {
    // get ceremony Id from url
    this.route.paramMap.subscribe((params) => {
      this.ceremonyId = params.get('id') ?? '';

      //load ceremony data if ceremonyId is in url
      if (this.ceremonyId && this.ceremonyId !== 'create') {
        this.ceremonyService
          .getCeremony(this.ceremonyId)
          .subscribe((ceremony) => {
            this.ceremony = ceremony;
            this.loadCeremonyForm();
            this.ceremonyForm.disable();
            this.isEditMode = false;
            this.ceremonyForm?.get('type')?.disable();
          });
      }
    });
    this.loadCeremonyForm();
  }

  loadCeremonyForm() {
    const ceremonyFormBuilder = new CeremonyFormBuilder(this.fb);
    this.ceremonyForm = ceremonyFormBuilder.buildForm(this.ceremony);
  }

  onBackClick() {
    this.router.navigate(['/ceremonies']);
  }

  onModeUpdated(event: any) {
    this.isEditMode = event.isEditMode;
    if (this.isEditMode) {
      this.ceremonyForm.enable();
      this.ceremonyId !== 'create'
        ? this.ceremonyForm?.get('type')?.disable()
        : null;
    } else this.ceremonyForm.disable();
    event.isSaveTriggered ? this.onSave() : null;
  }

  onSave() {
    if (this.ceremonyId && this.ceremonyId !== 'create') {
      this.ceremonyService
        .updateCeremony(this.ceremonyId, this.ceremonyForm.getRawValue())
        .subscribe({
          next: (ceremony) => {
            this.ceremony = ceremony;
            this.toast.success('Ceremony record updated successfully!');
          },
          error: (error) => {
            this.toast.error(
              'Error updating ceremony register: ' + error.message
            );
          },
        });
    } else {
      this.ceremonyService.createCeremony(this.ceremonyForm.getRawValue()).subscribe({
        next: (ceremony) => {
          this.ceremony = ceremony;
          this.toast.success('Ceremony record created successfully!');
          this.router.navigate(['/ceremonies']);
        },
        error: (error) => {
          this.toast.error(
            'Error creating a ceremony register: ' + error.message
          );
        },
      });
    }
  }

  get name(): FormControl {
    return this.ceremonyForm.get('name') as FormControl;
  }

  get type(): string {
    return this.ceremonyForm.get('type')?.value as string;
  }

  get witnessFormArray(): FormArray {
    return this.ceremonyForm.get('witness') as FormArray;
  }
}
