import { CommonModule } from '@angular/common';
import { Component, EventEmitter, Input, Output, signal } from '@angular/core';
import { faTrash } from '@fortawesome/free-solid-svg-icons';
import { IconService } from '../../../services/common/icon.service';
import { FontAwesomeModule } from '@fortawesome/angular-fontawesome';
import { SCREENS } from '../../../services/common/common.constants';
import { CanDeleteDirective } from '../../../directives/can-delete.directive';

@Component({
  selector: 'app-accordion',
  standalone: true,
  imports: [CommonModule, FontAwesomeModule, CanDeleteDirective],
  templateUrl: './accordion.component.html',
  styleUrl: './accordion.component.css',
})
export class AccordionComponent {
  @Input() title: string = '';
  @Input() isEditMode: boolean = false;
  @Output() remove = new EventEmitter<void>();

  screen: string = SCREENS.FAMILY_RECORD;
  faDelete = faTrash;

  constructor(private icon:IconService){}
  private open = signal(false);
  toggle() {
    this.open.update((v) => !v);
  }
  isOpen() {
    return this.open();
  }

  onDelete(event: MouseEvent){
    event.stopPropagation();
    this.remove.emit();
  }
}
