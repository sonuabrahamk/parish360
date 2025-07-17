import { Component, Input } from '@angular/core';
import { FooterComponent } from '../footer/footer.component';
import { FamilyRecords } from '../../../services/api/family-records.service';
import { FormBuilder, FormGroup, ReactiveFormsModule } from '@angular/forms';
import { CommonModule } from '@angular/common';
import { LoaderService } from '../../../services/common/loader.service';
import { LoaderComponent } from '../../common/loader/loader.component';
import { CanEditDirective } from '../../../directives/can-edit.directive';
import { SCREENS } from '../../../services/common/common.constants';

@Component({
  selector: 'app-family-info',
  imports: [
    ReactiveFormsModule,
    CommonModule,
    LoaderComponent,
    FooterComponent,
    CanEditDirective
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
    private loader: LoaderService,
    private familyRecordsService: FamilyRecords,
    private fb: FormBuilder
  ) {}

  ngOnInit() {
    this.loader.show();
    this.familyRecordsService.getFamilyRecordInfo(this.recordId).subscribe({
      next: (familyRecord: any) => {
        this.familyInfoForm = this.fb.group({
          book_no: [familyRecord.book_no || ''],
          head_of_family: [familyRecord.head_of_family || ''],
          family_name: [familyRecord.family_name || ''],
          parish: [familyRecord.parish || ''],
          unit: [familyRecord.unit || ''],
          mobile: [familyRecord.mobile || ''],
          address: [familyRecord.address || ''],
          created_date: [familyRecord.created_date || ''],
        });
        this.isEditMode
          ? this.familyInfoForm.enable()
          : this.familyInfoForm.disable();
      },
      error: (err: any) => {
        console.error('Data load from backend failed: ', err);
      },
    });
    this.loader.hide();
  }

  onModeUpdated(event: {
    isEditMode: boolean;
    isSaveTriggerred: boolean;
    isCancelTriggerred: boolean;
  }) {
    this.isEditMode = event.isEditMode;
    this.isEditMode
      ? this.familyInfoForm.enable()
      : this.familyInfoForm.disable();
    if (event.isSaveTriggerred) {
      console.log();
    }
    if (event.isCancelTriggerred) {
      this.ngOnInit();
    }
  }
}
