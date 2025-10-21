import { Component, Input } from '@angular/core';
import { Summary } from '../../../services/interfaces/dashboard.interface';

@Component({
  selector: 'app-summary',
  standalone: true,
  imports: [],
  templateUrl: './summary.component.html',
  styleUrl: './summary.component.css'
})
export class SummaryComponent {
  @Input() summary!: Summary;
}
