import { Component, Input } from '@angular/core';
import { Summary } from '../../../services/interfaces/dashboard.interface';
import { FaIconComponent } from '@fortawesome/angular-fontawesome';
import {
  faPeopleGroup,
  faPeopleRoof,
  faUsers,
  faUsersRectangle,
} from '@fortawesome/free-solid-svg-icons';

@Component({
  selector: 'app-summary',
  standalone: true,
  imports: [FaIconComponent],
  templateUrl: './summary.component.html',
  styleUrl: './summary.component.css',
})
export class SummaryComponent {
  @Input() summary!: Summary;

  faPeopleGroup = faPeopleGroup;
  faUsersRectangle = faUsersRectangle;
  faPeopleRoof = faPeopleRoof;
  faUsers = faUsers;
}
