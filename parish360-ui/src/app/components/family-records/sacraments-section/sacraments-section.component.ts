import { CommonModule } from '@angular/common';
import { Component, Input, signal, SimpleChanges } from '@angular/core';
import {
  FormArray,
  FormBuilder,
  FormGroup,
  ReactiveFormsModule,
} from '@angular/forms';
import { AccordionComponent } from '../../common/accordion/accordion.component';
import { IconService } from '../../../services/common/icon.service';
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
    private permissionService: PermissionsService
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
                  god_father: [sacrament.god_father || ''],
                  god_mother: [sacrament.god_mother || ''],
                  spouse: [sacrament.spouse || ''],
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
          console.error('Error fetching sacraments:', err);
        },
      });
  }

  removeSacrament(id: string, index: number) {
    if (id === 'new') {
      this.sacramentFormArray.removeAt(index);
      return;
    }
    this.sacramentService.deleteSacrament(this.recordId, this.memberId, id).subscribe({
      next: () => {
        alert('Sacrament deleted successfully!');
        this.sacraments = this.sacraments.filter((_, i) => i !== index);
        this.sacramentFormArray.removeAt(index);
      },
      error: (err) => {
        console.error('Error deleting sacrament:', err);
        alert('Failed to delete sacrament. Please try again.');
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
    if(this.sacraments){
      return this.sacraments[index]?.id || 'new';
    }
    return 'new';
  }

  addSacrament() {
    if(this.sacraments){
      if(this.sacraments?.length < this.sacramentFormArray?.length){
        alert('There is an unsaved sacrament entry already. Please save it before adding a new one.');
        return;
      }
    } else {
      if(this.sacramentFormArray?.length === 1){
        alert('There is an unsaved sacrament entry already. Please save it before adding a new one.');
        return;
      }
    }
    this.sacramentFormArray.push(
      this.fb.group({
        type: [''],
        date: [''],
        parish: [''],
        priest: [''],
        place: this.fb.group({
          city: [''],
          state: [''],
          country: [''],
        }),
        god_father: [''],
        god_mother: [''],
        spouse: [''],
      })
    );
    this.sacramentForm = this.fb.group({
              sacrament_details: this.sacramentFormArray as FormArray,
    });
  }

  save(id: string, index: number) {
    if (confirm('Are you sure you want to save the changes?')) {
      if (id === 'new') {
        const newSacrament: Sacrament =
          this.sacramentFormArray.at(index)?.value;
        this.sacramentService
          .createSacrament(this.recordId, this.memberId, newSacrament)
          .subscribe({
            next: (createdSacrament) => {
              alert('Sacrament created successfully!');
              // Update the local sacraments array and form array with the new ID
              this.sacraments.push(createdSacrament);
              this.sacramentFormArray.at(index)?.patchValue(createdSacrament);
            },
            error: (err) => {
              console.error('Error creating sacrament:', err);
              alert('Failed to create sacrament. Please try again.');
            },
          });
      } else {
        const updatedSacrament: Sacrament =
          this.sacramentFormArray.at(index)?.value;
        this.sacramentService
          .updateSacrament(this.recordId, this.memberId, id, updatedSacrament)
          .subscribe({
            next: (sacrament) => {
              alert('Sacrament updated successfully!');
              // Update the local sacraments array
              this.sacraments[index] = sacrament;
            },
            error: (err) => {
              console.error('Error updating sacrament:', err);
              alert('Failed to update sacrament. Please try again.');
            },
          });
      }
    }
  }
}
