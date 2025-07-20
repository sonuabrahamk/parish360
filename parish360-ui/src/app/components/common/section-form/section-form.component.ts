import { CommonModule } from '@angular/common';
import { Component, Input } from '@angular/core';

@Component({
  selector: 'app-section-form',
  standalone: true,
  imports: [CommonModule],
  templateUrl: './section-form.component.html',
  styleUrl: './section-form.component.css'
})
export class SectionFormComponent {
  @Input() title: string = '';

}
