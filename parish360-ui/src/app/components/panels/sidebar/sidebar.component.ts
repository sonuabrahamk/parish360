import { CommonModule } from '@angular/common';
import { Component } from '@angular/core';
import { RouterModule } from '@angular/router';
import { FontAwesomeModule } from '@fortawesome/angular-fontawesome';
import {
  faBook,
  faCalendarCheck,
  faFileInvoiceDollar,
  faLayerGroup,
  faMoneyBillWave,
  faPeopleGroup,
  faPeopleRoof,
  faUsersCog,
} from '@fortawesome/free-solid-svg-icons';

@Component({
  selector: 'app-sidebar',
  standalone: true,
  imports: [CommonModule, RouterModule, FontAwesomeModule],
  templateUrl: './sidebar.component.html',
  styleUrl: './sidebar.component.css',
})
export class SidebarComponent {
  navItems = [
    { label: 'Parish Dashboard', icon: faLayerGroup, route: 'dashboard' },
    { label: 'Family Records', icon: faPeopleRoof, route: 'family-records' },
    { label: 'Bookings', icon: faCalendarCheck, route: 'bookings' },
    { label: 'Ceremony Register', icon: faBook, route: 'ceremonys' },
    { label: 'Pious Associations', icon: faPeopleGroup, route: 'associations' },
    { label: 'Payment Register', icon: faFileInvoiceDollar, route: 'payments' },
    { label: 'Expense Register', icon: faMoneyBillWave, route: 'expenses' },
    { label: 'Users', icon: faUsersCog, route: 'users' },
  ];
}
