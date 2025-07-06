import { Component, Input, SimpleChanges } from '@angular/core';
import { CommonModule } from '@angular/common';
import { FormGroup, ReactiveFormsModule } from '@angular/forms';

@Component({
  selector: 'app-personal-section',
  standalone: true,
  imports: [CommonModule, ReactiveFormsModule],
  templateUrl: './personal-section.component.html',
  styleUrl: './personal-section.component.css',
})
export class PersonalSectionComponent {
  @Input() isEditMode: boolean = false;
  @Input() memberForm!: FormGroup;

  ngOnInit() {
    if (this.memberForm) {
      if (!this.isEditMode) {
        this.memberForm.disable();
      }
    }
  }

  ngOnChanges(changes: SimpleChanges): void {
    if (changes['isEditMode'] && this.memberForm) {
      if (this.isEditMode) {
        this.memberForm.enable();
      } else {
        this.memberForm.disable();
      }
    }
  }
}
