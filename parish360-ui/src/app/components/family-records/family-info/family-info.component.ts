import { Component, Input } from '@angular/core';
import { FooterComponent } from '../footer/footer.component';
import { FamilyRecords } from '../../../services/api/family-records.service';
import { FormBuilder, FormGroup, ReactiveFormsModule } from '@angular/forms';
import { CommonModule } from '@angular/common';
import { LoaderService } from '../../../services/common/loader.service';
import { LoaderComponent } from '../../common/loader/loader.component';
import { CanEditDirective } from '../../../directives/can-edit.directive';
import { SCREENS } from '../../../services/common/common.constants';
import { FooterEvent } from '../../../services/interfaces/permissions.interface';
import { Router } from '@angular/router';

@Component({
  selector: 'app-family-info',
  imports: [
    ReactiveFormsModule,
    CommonModule,
    LoaderComponent,
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

  constructor(
    private familyRecordsService: FamilyRecords,
    private fb: FormBuilder,
    private router: Router,
  ) {}

  ngOnInit() {
    if (this.recordId === 'new') {
      this.familyInfoForm = this.fb.group({
          family_code: [''],
          head_of_family: [''],
          family_name: [''],
          parish: [''],
          unit: [''],
          contact: [''],
          address: [''],
          joined_date: [''],
        });
        this.isEditMode = true;
        return;
    }
    this.familyRecordsService.getFamilyRecordInfo(this.recordId).subscribe({
      next: (familyRecord: any) => {
        this.familyInfoForm = this.fb.group({
          family_code: [familyRecord.family_code || ''],
          head_of_family: [familyRecord.head_of_family || ''],
          family_name: [familyRecord.family_name || ''],
          parish: [familyRecord.parish || ''],
          unit: [familyRecord.unit || ''],
          contact: [familyRecord.contact || ''],
          address: [familyRecord.address || ''],
          joined_date: [familyRecord.joined_date || ''],
        });
        this.isEditMode
          ? this.familyInfoForm.enable()
          : this.familyInfoForm.disable();
      },
      error: (err: any) => {
        console.error('Data load from backend failed: ', err);
      },
    });
  }

  onModeUpdated(event: FooterEvent) {
    this.isEditMode = event.isEditMode;
    this.isEditMode
      ? this.familyInfoForm.enable()
      : this.familyInfoForm.disable();
    if (event.isSaveTriggered) {
      this.onSave();
    }
    if (event.isCancelTriggered) {
      this.ngOnInit();
    }
  }

  onSave() {
    this.familyInfoForm.enable();
    if (this.familyInfoForm.valid) {
      confirm('Are you sure you want to save the changes?') &&
        (this.recordId === 'new'
          ? this.familyRecordsService.createFamilyRecordInfo(this.familyInfoForm.getRawValue()).subscribe({
              next: (response) => {
                window.location.href = `/family-records/${response.id}`;
              },
              error: (err) => {
                console.error('Error creating new family record', err);
              },
            })
          : this.familyRecordsService.updateFamilyRecordInfo(this.recordId, this.familyInfoForm.getRawValue()).subscribe({
              next: (response) => {
                console.log('Family record updated successfully', response);
                this.isEditMode = false;
                this.familyInfoForm.disable();
              },
              error: (err) => {
                console.error('Error updating family record', err);
              },
            })  
        );
    } else {
      console.warn('Please validate all required fields before saving.');
    }
  }
}
