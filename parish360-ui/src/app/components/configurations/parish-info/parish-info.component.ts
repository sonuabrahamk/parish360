import { CommonModule } from '@angular/common';
import { Component, ViewChild } from '@angular/core';
import {
  FormBuilder,
  FormGroup,
  ReactiveFormsModule,
  Validators,
} from '@angular/forms';
import { FooterComponent } from '../../family-records/footer/footer.component';
import { CanEditDirective } from '../../../directives/can-edit.directive';
import {
  COUNTRY_DIAL_CODES,
  CURRENCIES,
  SCREENS,
  TIMEZONES,
} from '../../../services/common/common.constants';
import { FooterEvent } from '../../../services/interfaces/permissions.interface';
import { ToastService } from '../../../services/common/toast.service';
import { Parish } from '../../../services/interfaces/parish.interface';
import { ParishInfoService } from '../../../services/api/parish-info.service';
import { SectionFormComponent } from '../../common/section-form/section-form.component';

@Component({
  selector: 'app-parish-info',
  standalone: true,
  imports: [
    CommonModule,
    ReactiveFormsModule,
    FooterComponent,
    CanEditDirective,
    SectionFormComponent,
  ],
  templateUrl: './parish-info.component.html',
  styleUrl: './parish-info.component.css',
})
export class ParishInfoComponent {
  screen: string = SCREENS.CONFIGURATIONS;
  @ViewChild(FooterComponent) footerComponent!: FooterComponent;

  timezones = TIMEZONES;
  currencies = CURRENCIES;
  countryCodes = COUNTRY_DIAL_CODES;

  isEditMode: boolean = false;
  parishInfoForm!: FormGroup;
  parishInfo!: Parish;

  hover = false;
  profileImageUrl: string = 'img/parish_logo.png';

  constructor(
    private fb: FormBuilder,
    private toast: ToastService,
    private parishService: ParishInfoService
  ) {}

  ngOnInit() {
    this.parishService.getParishInfo().subscribe({
      next: (parish) => {
        this.parishInfo = parish;
        this.loadParishInfoForm();
      },
      error: (error) => {
        this.toast.error('Error loading parish information: ' + error.message);
      },
    });
    this.loadParishInfoForm();
  }

  onModeUpdated(event: FooterEvent) {
    if (event.isEditMode) {
      this.parishInfoForm.enable();
    }
    if (event.isCancelTriggered) {
      this.parishInfoForm.disable();
    }
    if (event.isSaveTriggered) {
      this.onSave();
    }
    this.isEditMode = event.isEditMode;
  }

  onFileSelected(event: Event) {
    const file = (event.target as HTMLInputElement).files?.[0];
    if (!file) return;

    const reader = new FileReader();
    reader.onload = () => {
      const arrayBuffer = reader.result as ArrayBuffer;
      const byteArray = Array.from(new Uint8Array(arrayBuffer)); // convert to byte[]

      this.uploadImage(byteArray);

      // Update UI preview
      this.profileImageUrl = URL.createObjectURL(file);
    };
    reader.readAsArrayBuffer(file);
  }

  uploadImage(byteArray: number[]) {
    this.toast.info('Backend update to be implemented!');
  }

  loadParishInfoForm() {
    this.parishInfoForm = this.fb.group({
      name: [this.parishInfo?.name || '', Validators.required],
      denomination: [this.parishInfo?.denomination || ''],
      patron: [this.parishInfo?.patron || ''],
      dial_code: [this.parishInfo?.dial_code || '+91'],
      contact: [
        this.parishInfo?.contact || '',
        [Validators.required, Validators.pattern(/^[0-9]{10}$/)],
      ],
      email: [this.parishInfo?.email || '', Validators.required],
      founded_date: [this.parishInfo?.founded_date || ''],
      timezone: [this.parishInfo?.timezone || 'Asia/Kolkata'],
      currency: [this.parishInfo?.currency || 'INR'],
      place: this.fb.group({
        location: [this.parishInfo?.place?.location || ''],
        city: [this.parishInfo?.place?.city || ''],
        state: [this.parishInfo?.place?.state || ''],
        country: [this.parishInfo?.place?.country || ''],
      }),
    });
    this.parishInfoForm.disable();
  }

  onSave() {
    if (this.parishInfoForm.invalid) {
      this.toast.warn('Please validate all fields before update!');
      return;
    }
    this.toast
      .confirm('Are you sure you want to save the changes?')
      .then((confirmed) => {
        if (confirmed) {
          this.parishService
            .updateParishInfo(this.parishInfoForm.getRawValue())
            .subscribe({
              next: (parish) => {
                this.parishInfo = parish;
                this.loadParishInfoForm();
                this.toast.success('Parish information updated successfully!');
              },
              error: (error) => {
                this.toast.error(
                  'Error updating parish information: ' + error.message
                );
              },
            });
          return;
        }
        this.footerComponent.edit();
      });
  }

  // Utility getter for template
  isInvalid(controlName: string): boolean {
    const control = this.parishInfoForm.get(controlName);
    return !!(control && control.invalid && (control.dirty || control.touched));
  }
}
