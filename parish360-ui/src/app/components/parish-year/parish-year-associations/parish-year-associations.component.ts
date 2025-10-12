import { Component, Input } from '@angular/core';

@Component({
  selector: 'app-parish-year-associations',
  standalone: true,
  imports: [],
  templateUrl: './parish-year-associations.component.html',
  styleUrl: './parish-year-associations.component.css',
})
export class ParishYearAssociationsComponent {
  @Input() parishYearId: string = '';
}
