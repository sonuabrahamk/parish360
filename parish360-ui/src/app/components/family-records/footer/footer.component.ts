import { Component, EventEmitter, Input, Output } from '@angular/core';
import { FontAwesomeModule } from '@fortawesome/angular-fontawesome';
import { CommonModule } from '@angular/common';
import {
  faPlus,
  faTimes,
  faTrash,
  faPencil,
  faFloppyDisk,
} from '@fortawesome/free-solid-svg-icons';
import { FooterEvent } from '../../../services/interfaces/permissions.interface';

@Component({
  selector: 'app-footer',
  standalone: true,
  imports: [CommonModule, FontAwesomeModule],
  templateUrl: './footer.component.html',
  styleUrl: './footer.component.css',
})
export class FooterComponent {
  @Output() modeUpdated = new EventEmitter<FooterEvent>();
  @Input() isEditMode: boolean = false;

  icons = {
    faPlus,
    faTimes,
    faTrash,
    faPencil,
    faFloppyDisk,
  };
  isLoading: boolean = false;

  delete() {
    this.isLoading = true;
    alert('Arey you sure you want to delete this member?');
    this.isEditMode = false;
    this.modeUpdated.emit({
      isEditMode: this.isEditMode,
      isCancelTriggered: false,
      isSaveTriggered: false,
    });
    this.isLoading = false;
  }

  edit() {
    this.isLoading = true;
    alert('Are you sure you want to edit this member?');
    this.isEditMode = true;
    this.modeUpdated.emit({
      isEditMode: this.isEditMode,
      isCancelTriggered: false,
      isSaveTriggered: false,
    });
    this.isLoading = false;
  }

  save() {
    this.isLoading = true;
    this.isEditMode = false;
    this.modeUpdated.emit({
      isEditMode: this.isEditMode,
      isSaveTriggered: true,
      isCancelTriggered: false,
    });
    this.isLoading = false;
  }

  cancelEdit() {
    this.isLoading = false;
    alert('Are you sure you want to cancel? All changes will be lost.');
    this.isEditMode = false;
    this.modeUpdated.emit({
      isEditMode: this.isEditMode,
      isSaveTriggered: false,
      isCancelTriggered: true,
    });
    this.isLoading = false;
  }
}
