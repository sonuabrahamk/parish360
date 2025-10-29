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
    this.isEditMode = false;
    this.modeUpdated.emit({
      isEditMode: this.isEditMode,
      isSaveTriggered: false,
      isCancelTriggered: false,
      isDeleteTriggered: true,
    });
  }

  edit() {
    this.isLoading = true;
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
    this.isEditMode = false;
    this.modeUpdated.emit({
      isEditMode: this.isEditMode,
      isSaveTriggered: false,
      isCancelTriggered: true,
    });
  }
}
