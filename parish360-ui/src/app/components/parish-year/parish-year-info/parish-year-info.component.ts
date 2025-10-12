import { Component, Input } from '@angular/core';

@Component({
  selector: 'app-parish-year-info',
  standalone: true,
  imports: [],
  templateUrl: './parish-year-info.component.html',
  styleUrl: './parish-year-info.component.css',
})
export class ParishYearInfoComponent {
  @Input() parishYearId: string = '';
}
