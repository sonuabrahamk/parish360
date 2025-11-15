import { Component, Input } from '@angular/core';
import { SCREENS } from '../../../services/common/common.constants';
import {
  FormArray,
  FormBuilder,
  FormGroup,
  ReactiveFormsModule,
  Validators,
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
import { ToastService } from '../../../services/common/toast.service';

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
    private permissionService: PermissionsService,
    private toast: ToastService
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
                  migrated_on: [
                    migration.migrated_on || '',
                    Validators.required,
                  ],
                  comment: [migration.comment || '', Validators.required],
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
          this.toast.error('Error fetching migrations: ' + err.message);
        },
      });
  }

  removeMigration(id: string, index: number) {
    if (id === 'new') {
      this.migrationFormArray.removeAt(index);
      return;
    }
    this.toast
      .confirm('Are you sure you want to delete this migration record?')
      .then((confirmed) => {
        if (confirmed) {
          this.migrationService
            .deleteMigration(this.recordId, this.memberId, id)
            .subscribe({
              next: () => {
                this.migrations = this.migrations.filter((_, i) => i !== index);
                this.migrationFormArray.removeAt(index);
                this.toast.success('Migration record deleted successfully!');
              },
              error: (err) => {
                this.toast.error('Failed to delete migration: ' + err.message);
              },
            });
        }
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
        this.toast.warn(
          'There is an unsaved migration entry already. Please save it before adding a new one.'
        );
        return;
      }
    } else {
      if (this.migrationFormArray?.length === 1) {
        this.toast.warn(
          'There is an unsaved migration entry already. Please save it before adding a new one.'
        );
        return;
      }
    }
    this.migrationFormArray.push(
      this.fb.group({
        migrated_on: ['', Validators.required],
        comment: ['', Validators.required],
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
    if (this.migrationFormArray.at(index)?.invalid) {
      this.migrationFormArray.at(index)?.markAllAsTouched();
      return;
    }
    this.toast
      .confirm('Are you sure you want to save the changes?')
      .then((confirmed) => {
        if (confirmed) {
          if (id === 'new') {
            const newMigration: MigrationDetails = this.migrationFormArray
              .at(index)
              ?.getRawValue();
            this.migrationService
              .createMigration(this.recordId, this.memberId, newMigration)
              .subscribe({
                next: (createdMigration) => {
                  // Update the local migration array and form array with the new ID
                  this.ngOnInit();
                  this.toast.success('Migration created successfully!');
                },
                error: (err) => {
                  this.toast.error(
                    'Failed to create migration: ' + err.message
                  );
                },
              });
          } else {
            const updatedMigration: MigrationDetails = this.migrationFormArray
              .at(index)
              ?.getRawValue();
            this.migrationService
              .updateMigration(
                this.recordId,
                this.memberId,
                id,
                updatedMigration
              )
              .subscribe({
                next: (migration) => {
                  // Update the local migration array
                  this.migrations[index] = migration;
                  this.toast.success('Migration updated successfully!');
                },
                error: (err) => {
                  this.toast.error(
                    'Failed to update migration: ' + err.message
                  );
                },
              });
          }
        }
      });
  }

  // Utility getter for template
  isInvalid(controlName: string, index: number): boolean {
    const control = this.migrationFormArray.at(index)?.get(controlName);
    return !!(control && control.invalid && (control.dirty || control.touched));
  }
}
