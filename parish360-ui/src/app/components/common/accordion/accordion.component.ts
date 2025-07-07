import { CommonModule } from '@angular/common';
import { Component, EventEmitter, Input, Output, signal } from '@angular/core';
import { faTrash } from '@fortawesome/free-solid-svg-icons';
import { IconService } from '../../../services/icon.service';
import { FontAwesomeModule } from '@fortawesome/angular-fontawesome';

@Component({
  selector: 'app-accordion',
  standalone: true,
  imports: [CommonModule, FontAwesomeModule],
  templateUrl: './accordion.component.html',
  styleUrl: './accordion.component.css',
})
export class AccordionComponent {
  @Input() title: string = '';
  @Input() deleteEnabled: boolean = true;
  @Output() remove = new EventEmitter<void>();

  faDelete = faTrash

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
