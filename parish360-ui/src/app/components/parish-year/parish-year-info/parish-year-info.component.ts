import { Component, Input } from '@angular/core';
import { FormBuilder, FormGroup, ReactiveFormsModule } from '@angular/forms';
import { ParishYearService } from '../../../services/api/parish-year.service';
import { CommonModule } from '@angular/common';
import { CanEditDirective } from '../../../directives/can-edit.directive';
import { FooterComponent } from '../../family-records/footer/footer.component';
import { SCREENS } from '../../../services/common/common.constants';
import { FooterEvent } from '../../../services/interfaces/permissions.interface';
import { ParishYear } from '../../../services/interfaces/parish-year.interface';
import { Router } from '@angular/router';
import { ToastService } from '../../../services/common/toast.service';

@Component({
  selector: 'app-parish-year-info',
  standalone: true,
  imports: [
    CommonModule,
    ReactiveFormsModule,
    CanEditDirective,
    FooterComponent,
  ],
  templateUrl: './parish-year-info.component.html',
  styleUrl: './parish-year-info.component.css',
})
export class ParishYearInfoComponent {
  @Input() parishYearId: string = '';

  screen: string = SCREENS.CONFIGURATIONS;
  isEditMode: boolean = false;
  parishYearInfoForm!: FormGroup;

  constructor(
    private router: Router,
    private fb: FormBuilder,
    private parishYearService: ParishYearService,
    private toast: ToastService
  ) {}

  ngOnInit() {
    if (this.parishYearId === 'new' || this.parishYearId === '') {
      // create a null form for creating a new parish year or if parishYearId is null
      this.loadParishYearForm();
      this.isEditMode = true;
    } else {
      // Assign form values for an existing parish year
      this.parishYearService.getParishYearInfo(this.parishYearId).subscribe({
        next: (parishYearInfo) => {
          this.loadParishYearForm(parishYearInfo);
          this.parishYearInfoForm.disable();
        },
        error: (error) => {
          this.toast.error(
            'Could not find parish year related information: ' + error.message
          );
        },
      });
    }
  }

  onModeUpdated(event: FooterEvent) {
    if (event.isEditMode) {
      this.parishYearInfoForm.enable();
    }
    if (event.isCancelTriggered) {
      this.parishYearInfoForm.disable();
    }
    if (event.isSaveTriggered) {
      this.onSave();
    }
    this.isEditMode = event.isEditMode;
  }

  async onSave() {
    (await this.toast.confirm('Are you sure you want to save the changes ?')) &&
    this.parishYearId === 'new'
      ? this.parishYearService
          .createParishYear(this.parishYearInfoForm.value)
          .subscribe({
            next: (parishYear) => {
              this.toast.success(
                'New parish year record created successfully!'
              );
              this.router.navigate([`/parish-year/${parishYear.id}`]);
            },
            error: (error) => {
              this.toast.error(
                'Error in creating a new parish year record: ' + error.message
              );
            },
          })
      : this.parishYearService
          .updateParishYear(this.parishYearId, this.parishYearInfoForm.value)
          .subscribe({
            next: (parishYear) => {
              this.parishYearId = parishYear.id;
              this.isEditMode = false;
              this.toast.success('Parish year record updated successfully!');
              this.ngOnInit();
            },
            error: (error) => {
              this.toast.error(
                'Error in updating parish year record: ' + error.message
              );
            },
          });
  }

  loadParishYearForm(parishYearInfo?: ParishYear) {
    this.parishYearInfoForm = this.fb.group({
      name: [parishYearInfo?.name || ''],
      start_date: [parishYearInfo?.start_date || new Date()],
      end_date: [parishYearInfo?.end_date || new Date()],
      status: [parishYearInfo?.status || 'IN-PROGRESS'],
      locked: [parishYearInfo?.locked || false],
      comment: [parishYearInfo?.comment || ''],
    });
  }
}
