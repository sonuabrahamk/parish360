import { CommonModule } from '@angular/common';
import { Component } from '@angular/core';
import { FormBuilder, FormGroup, ReactiveFormsModule } from '@angular/forms';

@Component({
  selector: 'app-add-document',
  standalone: true,
  imports: [CommonModule, ReactiveFormsModule],
  templateUrl: './add-document.component.html',
  styleUrl: './add-document.component.css',
})
export class AddDocumentComponent {
  uploadDocumentForm!: FormGroup;
  selectedFile: File | null = null;

  constructor(private fb: FormBuilder) {
    this.uploadDocumentForm = this.fb.group({
      name: [''],
    });
  }

  // Triggered when file input changes
  onFileChange(event: Event): void {
    const input = event.target as HTMLInputElement;
    if (input.files?.length) {
      this.selectedFile = input.files[0];
    }
  }

  // Form submit
  onSubmit(): void {
    if (!this.selectedFile) {
      alert('Please select a file.');
      return;
    }

    const formData = new FormData();
    const username = this.uploadDocumentForm?.value?.username || '';
    formData.append('username', username);
    formData.append('file', this.selectedFile);

    console.log('Upload document form to upload: ' + formData);
  }
}
