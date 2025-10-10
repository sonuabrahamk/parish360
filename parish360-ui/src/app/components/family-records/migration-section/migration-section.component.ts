import { Component, Input } from '@angular/core';
import { SCREENS } from '../../../services/common/common.constants';
import {
  FormArray,
  FormBuilder,
  FormGroup,
  ReactiveFormsModule,
} from '@angular/forms';
import { MigrationDetails } from '../../../services/interfaces/member.interface';
import {
  faFloppyDisk,
  faPlus,
  faTimes,
} from '@fortawesome/free-solid-svg-icons';
import { PermissionsService } from '../../../services/common/permissions.service';
import { MigrationService } from '../../../services/api/migration.service';
import { CommonModule } from '@angular/common';
import { CanEditDirective } from '../../../directives/can-edit.directive';
import { CanCreateDirective } from '../../../directives/can-create.directive';
import { AccordionComponent } from '../../common/accordion/accordion.component';
import { SectionFormComponent } from '../../common/section-form/section-form.component';
import { FontAwesomeModule } from '@fortawesome/angular-fontawesome';

@Component({
  selector: 'app-migration-section',
  standalone: true,
  imports: [
    CommonModule,
    CanEditDirective,
    CanCreateDirective,
    ReactiveFormsModule,
    AccordionComponent,
    SectionFormComponent,
    FontAwesomeModule,
  ],
  templateUrl: './migration-section.component.html',
  styleUrl: './migration-section.component.css',
})
export class MigrationSectionComponent {
  @Input() memberId!: string;
  @Input() recordId!: string;

  screen: string = SCREENS.FAMILY_RECORD;
  migrationForm!: FormGroup;
  migrationFormArray!: FormArray;
  migrations!: MigrationDetails[];

  faPlus = faPlus;
  faTimes = faTimes;
  faFloppyDisk = faFloppyDisk;

  constructor(
    private fb: FormBuilder,
    private migrationService: MigrationService,
    private permissionService: PermissionsService
  ) {}

  ngOnInit() {
    this.migrationFormArray = this.fb.array([]);
    this.migrationService
      .getMigrations(this.recordId, this.memberId)
      .subscribe({
        next: (migrations) => {
          if (migrations.length) {
            this.migrations = migrations;
            migrations.forEach((migration) => {
              this.migrationFormArray.push(
                this.fb.group({
                  migrated_on: [migration.migrated_on || ''],
                  comment: [migration.comment || ''],
                  parish: [migration.parish || ''],
                  address: [migration.address || ''],
                  place: this.fb.group({
                    city: [migration.place?.city || ''],
                    state: [migration.place?.state || ''],
                    country: [migration.place?.country || ''],
                  }),
                  return_date: [migration.return_date || ''],
                })
              );
            });
            if (!this.permissionService.canEdit(this.screen)) {
              this.migrationFormArray.disable();
            }
            this.migrationForm = this.fb.group({
              migration_details: this.migrationFormArray,
            });
          }
        },
        error: (err) => {
          console.error('Error fetching migrations:', err);
        },
      });
  }

  removeMigration(id: string, index: number) {
    if (id === 'new') {
      this.migrationFormArray.removeAt(index);
      return;
    }
    this.migrationService
      .deleteMigration(this.recordId, this.memberId, id)
      .subscribe({
        next: () => {
          alert('Migration deleted successfully!');
          this.migrations = this.migrations.filter((_, i) => i !== index);
          this.migrationFormArray.removeAt(index);
        },
        error: (err) => {
          console.error('Error deleting migration:', err);
          alert('Failed to delete migration. Please try again.');
        },
      });
  }

  getMigrationName(index: number): string {
    return (
      'Migration on ' +
        this.migrationFormArray.at(index)?.get('migrated_on')?.value ||
      'Click to add details'
    );
  }

  getMigrationId(index: number): string {
    if (this.migrations) {
      return this.migrations[index]?.id || 'new';
    }
    return 'new';
  }

  addMigration() {
    if (this.migrations) {
      if (this.migrations?.length < this.migrationFormArray?.length) {
        alert(
          'There is an unsaved migration entry already. Please save it before adding a new one.'
        );
        return;
      }
    } else {
      if (this.migrationFormArray?.length === 1) {
        alert(
          'There is an unsaved migration entry already. Please save it before adding a new one.'
        );
        return;
      }
    }
    this.migrationFormArray.push(
      this.fb.group({
        migrated_on: [''],
        comment: [''],
        parish: [''],
        address: [''],
        place: this.fb.group({
          city: [''],
          state: [''],
          country: [''],
        }),
        return_date: [''],
      })
    );
    this.migrationForm = this.fb.group({
      migration_details: this.migrationFormArray as FormArray,
    });
  }

  save(id: string, index: number) {
    if (confirm('Are you sure you want to save the changes?')) {
      if (id === 'new') {
        const newMigration: MigrationDetails =
          this.migrationFormArray.at(index)?.value;
        this.migrationService
          .createMigration(this.recordId, this.memberId, newMigration)
          .subscribe({
            next: (createdMigration) => {
              alert('Migration created successfully!');
              // Update the local migration array and form array with the new ID
              this.migrations.push(createdMigration);
              this.migrationFormArray.at(index)?.patchValue(createdMigration);
            },
            error: (err) => {
              console.error('Error creating migration:', err);
              alert('Failed to create migration. Please try again.');
            },
          });
      } else {
        const updatedMigration: MigrationDetails =
          this.migrationFormArray.at(index)?.value;
        this.migrationService
          .updateMigration(this.recordId, this.memberId, id, updatedMigration)
          .subscribe({
            next: (migration) => {
              alert('Migration updated successfully!');
              // Update the local migration array
              this.migrations[index] = migration;
            },
            error: (err) => {
              console.error('Error updating migrations:', err);
              alert('Failed to update migration. Please try again.');
            },
          });
      }
    }
  }
}
