import { CommonModule } from '@angular/common';
import { Component, Input } from '@angular/core';
import {
  FormArray,
  FormBuilder,
  FormGroup,
  ReactiveFormsModule,
  Validators,
} from '@angular/forms';
import { AccordionComponent } from '../../common/accordion/accordion.component';
import {
  faFloppyDisk,
  faPlus,
  faTimes,
} from '@fortawesome/free-solid-svg-icons';
import { FontAwesomeModule } from '@fortawesome/angular-fontawesome';
import { CanCreateDirective } from '../../../directives/can-create.directive';
import { SCREENS } from '../../../services/common/common.constants';
import { SacramentService } from '../../../services/api/sacrament.service';
import { SectionFormComponent } from '../../common/section-form/section-form.component';
import { Sacrament } from '../../../services/interfaces/member.interface';
import { PermissionsService } from '../../../services/common/permissions.service';
import { CanEditDirective } from '../../../directives/can-edit.directive';
import { ToastService } from '../../../services/common/toast.service';

@Component({
  selector: 'app-sacraments-section',
  standalone: true,
  imports: [
    CommonModule,
    ReactiveFormsModule,
    AccordionComponent,
    FontAwesomeModule,
    CanEditDirective,
    CanCreateDirective,
    SectionFormComponent,
  ],
  templateUrl: './sacraments-section.component.html',
  styleUrl: './sacraments-section.component.css',
})
export class SacramentsSectionComponent {
  @Input() memberId!: string;
  @Input() recordId!: string;

  screen: string = SCREENS.FAMILY_RECORD;
  sacramentForm!: FormGroup;
  sacramentFormArray!: FormArray;
  sacraments!: Sacrament[];

  faPlus = faPlus;
  faTimes = faTimes;
  faFloppyDisk = faFloppyDisk;

  sacramentTypes = [
    { id: 'baptism', name: 'Baptism' },
    { id: 'holy_communion', name: 'Holy Communion' },
    { id: 'confirmation', name: 'Holy Confirmation' },
    { id: 'matrimony', name: 'Holy Matrimony' },
    { id: 'anointing_the_sick', name: 'Anointing the Sick' },
    { id: 'holy_ordination', name: 'Holy Ordination' },
  ];

  constructor(
    private fb: FormBuilder,
    private sacramentService: SacramentService,
    private permissionService: PermissionsService,
    private toast: ToastService
  ) {}

  ngOnInit() {
    this.sacramentFormArray = this.fb.array([]);
    this.sacramentService
      .getSacraments(this.recordId, this.memberId)
      .subscribe({
        next: (sacraments) => {
          if (sacraments.length) {
            this.sacraments = sacraments;
            sacraments.forEach((sacrament) => {
              this.sacramentFormArray.push(
                this.fb.group({
                  type: [sacrament.type || ''],
                  date: [sacrament.date || ''],
                  parish: [sacrament.parish || ''],
                  priest: [sacrament.priest || ''],
                  place: this.fb.group({
                    city: [sacrament.place?.city || ''],
                    state: [sacrament.place?.state || ''],
                    country: [sacrament.place?.country || ''],
                  }),
                })
              );
            });
            if (!this.permissionService.canEdit(this.screen)) {
              this.sacramentFormArray.disable();
            }
            this.sacramentForm = this.fb.group({
              sacrament_details: this.sacramentFormArray,
            });
          }
        },
        error: (err) => {
          this.toast.error('Error fetching sacraments:', err.message);
        },
      });
  }

  removeSacrament(id: string, index: number) {
    if (id === 'new') {
      this.sacramentFormArray.removeAt(index);
      return;
    }
    this.sacramentService
      .deleteSacrament(this.recordId, this.memberId, id)
      .subscribe({
        next: () => {
          this.sacraments = this.sacraments.filter((_, i) => i !== index);
          this.sacramentFormArray.removeAt(index);
          this.toast.success('Sacrament deleted successfully!');
        },
        error: (err) => {
          this.toast.error('Failed to delete sacrament: ' + err.message);
        },
      });
  }

  getSacramentTypeName(index: number): string {
    return (
      this.sacramentTypes.find(
        (type) =>
          type.id === this.sacramentFormArray.at(index)?.get('type')?.value
      )?.name ?? 'Click to Add Details'
    );
  }

  getSacramentId(index: number): string {
    if (this.sacraments) {
      return this.sacraments[index]?.id || 'new';
    }
    return 'new';
  }

  addSacrament() {
    if (this.sacraments) {
      if (this.sacraments?.length < this.sacramentFormArray?.length) {
        this.toast.warn(
          'There is an unsaved sacrament entry already. Please save it before adding a new one.'
        );
        return;
      }
    } else {
      if (this.sacramentFormArray?.length === 1) {
        this.toast.warn(
          'There is an unsaved sacrament entry already. Please save it before adding a new one.'
        );
        return;
      }
    }
    this.sacramentFormArray.push(
      this.fb.group({
        type: ['', Validators.required],
        date: ['', Validators.required],
        parish: ['', Validators.required],
        priest: [''],
        place: this.fb.group({
          city: [''],
          state: [''],
          country: [''],
        }),
      })
    );
    this.sacramentForm = this.fb.group({
      sacrament_details: this.sacramentFormArray as FormArray,
    });
  }

  save(id: string, index: number) {
    if (this.sacramentFormArray.at(index)?.invalid) {
      this.sacramentFormArray.at(index)?.markAllAsTouched();
      return;
    }
    this.toast
      .confirm('Are you sure you want to save the changes?')
      .then((confirmed) => {
        if (confirmed) {
          if (id === 'new') {
            const newSacrament: Sacrament =
              this.sacramentFormArray.at(index)?.value;
            this.sacramentService
              .createSacrament(this.recordId, this.memberId, newSacrament)
              .subscribe({
                next: (createdSacrament) => {
                  // Update the local sacraments array and form array with the new ID
                  this.ngOnInit();
                  this.toast.success('Sacrament created successfully!');
                },
                error: (err) => {
                  this.toast.error(
                    'Failed to create sacrament: ' + err.message
                  );
                },
              });
          } else {
            const updatedSacrament: Sacrament =
              this.sacramentFormArray.at(index)?.value;
            this.sacramentService
              .updateSacrament(
                this.recordId,
                this.memberId,
                id,
                updatedSacrament
              )
              .subscribe({
                next: (sacrament) => {
                  // Update the local sacraments array
                  this.sacraments[index] = sacrament;
                  this.toast.success('Sacrament updated successfully!');
                },
                error: (err) => {
                  this.toast.error(
                    'Failed to update sacrament: ' + err.message
                  );
                },
              });
          }
        }
      });
  }

  // Utility getter for template
  isInvalid(controlName: string, index: number): boolean {
    const control = this.sacramentFormArray.at(index)?.get(controlName);
    return !!(control && control.invalid && (control.dirty || control.touched));
  }
}
