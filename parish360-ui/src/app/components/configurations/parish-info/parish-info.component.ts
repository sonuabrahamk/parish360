import { CommonModule } from '@angular/common';
import { Component } from '@angular/core';
import { FormBuilder, FormGroup, ReactiveFormsModule } from '@angular/forms';
import { FooterComponent } from '../../family-records/footer/footer.component';
import { CanEditDirective } from '../../../directives/can-edit.directive';
import { SCREENS } from '../../../services/common/common.constants';
import { FooterEvent } from '../../../services/interfaces/permissions.interface';

@Component({
  selector: 'app-parish-info',
  standalone: true,
  imports: [
    CommonModule,
    ReactiveFormsModule,
    FooterComponent,
    CanEditDirective,
  ],
  templateUrl: './parish-info.component.html',
  styleUrl: './parish-info.component.css',
})
export class ParishInfoComponent {
  screen: string = SCREENS.CONFIGURATIONS;
  isEditMode: boolean = false;
  parishInfoForm!: FormGroup;

  constructor(private fb: FormBuilder) {}

  ngOnInit() {
    this.parishInfoForm = this.fb.group({
      name: [''],
      denomination: [''],
      patron: [''],
      contact: [''],
      email: [''],
      founded_date: [''],
    });
    this.parishInfoForm.disable();
  }

  onModeUpdated(event: FooterEvent) {
    if (event.isEditMode) {
      this.parishInfoForm.enable();
    }
    if (event.isCancelTriggered) {
      this.parishInfoForm.disable();
    }
    if (event.isSaveTriggered) {
      this.parishInfoForm.disable();
    }
    this.isEditMode = event.isEditMode;
  }
}
