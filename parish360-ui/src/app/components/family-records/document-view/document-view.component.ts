import { CommonModule } from '@angular/common';
import { Component, EventEmitter, Input, Output } from '@angular/core';
import { FontAwesomeModule } from '@fortawesome/angular-fontawesome';
import { faDownload, faTrash } from '@fortawesome/free-solid-svg-icons';

@Component({
  selector: 'app-document-view',
  standalone: true,
  imports: [CommonModule, FontAwesomeModule],
  templateUrl: './document-view.component.html',
  styleUrl: './document-view.component.css',
})
export class DocumentViewComponent {
  @Input() isEditMode: boolean = false;
  @Input() documentName: string = '';
  @Input() documentId: string = '';

  faDownload = faDownload;
  faTrash = faTrash;

  onDocumentDelete(id: string){
    console.log(id);
  }

  onDocumentDownload(id: string){
    console.log(id);
  }
}
