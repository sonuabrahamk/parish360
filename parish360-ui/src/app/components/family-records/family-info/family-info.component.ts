import { Component, Input } from '@angular/core';
import { FooterComponent } from '../footer/footer.component';
import { FamilyRecords } from '../../../services/api/family-records.service';
import { FormBuilder, FormGroup, ReactiveFormsModule } from '@angular/forms';
import { CommonModule } from '@angular/common';
import { CanEditDirective } from '../../../directives/can-edit.directive';
import { SCREENS } from '../../../services/common/common.constants';
import { FooterEvent } from '../../../services/interfaces/permissions.interface';
import { Router } from '@angular/router';
import { ToastService } from '../../../services/common/toast.service';
import { FamilyRecord } from '../../../services/interfaces/family-record.interface';

@Component({
  selector: 'app-family-info',
  imports: [
    ReactiveFormsModule,
    CommonModule,
    FooterComponent,
    CanEditDirective,
  ],
  templateUrl: './family-info.component.html',
  styleUrl: './family-info.component.css',
})
export class FamilyInfoComponent {
  @Input() recordId!: string;

  screen: string = SCREENS.FAMILY_RECORD;
  isEditMode: boolean = false;
  familyInfoForm!: FormGroup;
  familyInfo!: FamilyRecord;

  constructor(
    private familyRecordsService: FamilyRecords,
    private fb: FormBuilder,
    private router: Router,
    private toast: ToastService
  ) {}

  ngOnInit() {
    if (this.recordId === 'new') {
      this.familyInfoForm = this.loadFamilyInfoForm();
      this.isEditMode = true;
      return;
    }
    this.familyRecordsService.getFamilyRecordInfo(this.recordId).subscribe({
      next: (familyRecord: FamilyRecord) => {
        this.familyInfo = familyRecord;
        this.familyInfoForm = this.loadFamilyInfoForm();
        this.isEditMode
          ? this.familyInfoForm.enable()
          : this.familyInfoForm.disable();
      },
      error: (err: any) => {
        this.toast.error('Data load from backend failed: ' + err.message);
      },
    });
  }

  onModeUpdated(event: FooterEvent) {
    if (event.isSaveTriggered) {
      this.onSave();
    }
    if (event.isCancelTriggered) {
      this.ngOnInit();
    }
    if (event.isDeleteTriggered) {
      this.toast.info('Delete functionality not implemented yet');
    }
    if( event.isEditMode) {
      this.isEditMode = true;
      this.familyInfoForm.enable();
    }
  }

  onSave() {
    if (this.familyInfoForm.valid) {
      this.toast
        .confirm('Are you sure you want to save the changes?')
        .then((confirmed) => {
          if (confirmed) {
            if (this.recordId === 'new') {
              this.familyRecordsService
                .createFamilyRecordInfo(this.familyInfoForm.getRawValue())
                .subscribe({
                  next: (response) => {
                    this.router.navigate([`/family-records/${response.id}`]);
                  },
                  error: (err) => {
                    this.toast.error(
                      'Error creating new family record: ' + err.message
                    );
                  },
                });
            } else {
              this.familyRecordsService
                .updateFamilyRecordInfo(
                  this.recordId,
                  this.familyInfoForm.getRawValue()
                )
                .subscribe({
                  next: (response) => {
                    this.toast.success('Family record updated successfully!');
                    this.isEditMode = false;
                    this.familyInfoForm.disable();
                  },
                  error: (err) => {
                    this.toast.error(
                      'Error updating family record: ' + err.message
                    );
                  },
                });
            }
          } else {
            this.isEditMode = true;
            this.familyInfoForm.enable();
          }
        });
    } else {
      this.toast.warn('Please validate all required fields before saving');
      this.isEditMode = true;
      this.familyInfoForm.enable();
    }
  }

  loadFamilyInfoForm(): FormGroup {
    // This method can be used to load or reload the form if needed
    return (this.familyInfoForm = this.fb.group({
      family_code: [this.familyInfo?.family_code || ''],
      head_of_family: [this.familyInfo?.head_of_family || ''],
      family_name: [this.familyInfo?.family_name || ''],
      parish: [this.familyInfo?.parish || ''],
      unit: [this.familyInfo?.unit || ''],
      contact: [this.familyInfo?.contact || ''],
      address: [this.familyInfo?.address || ''],
      joined_date: [
        this.familyInfo?.joined_date ||
          new Date().toISOString().split('T')[0] ||
          '',
      ],
    }));
  }
}
