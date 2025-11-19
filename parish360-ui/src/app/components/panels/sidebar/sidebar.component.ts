import { CommonModule } from '@angular/common';
import { Component } from '@angular/core';
import { RouterModule } from '@angular/router';
import { FontAwesomeModule } from '@fortawesome/angular-fontawesome';
import {
  faBook,
  faCalendarAlt,
  faCalendarCheck,
  faFileInvoiceDollar,
  faGear,
  faLayerGroup,
  faMoneyBillWave,
  faPeopleGroup,
  faPeopleRoof,
  faUsersCog,
} from '@fortawesome/free-solid-svg-icons';
import { PERMISSIONS_KEY } from '../../../services/common/common.constants';
import { Permissions } from '../../../services/interfaces/permissions.interface';
import { Tab } from '../../common/tabs/tabs.component';
import { NavItems } from '../../../services/common/interfaces';

@Component({
  selector: 'app-sidebar',
  standalone: true,
  imports: [CommonModule, RouterModule, FontAwesomeModule],
  templateUrl: './sidebar.component.html',
  styleUrl: './sidebar.component.css',
})
export class SidebarComponent {
  navItems: NavItems[] = [];

  ngOnInit() {
    const permissionString: string | null =
      localStorage.getItem(PERMISSIONS_KEY) || null;
    const permissions: Permissions = permissionString
      ? JSON.parse(permissionString)
      : null;
    if (permissions && permissions.modules['view'].length > 0) {
      permissions.modules['view'].forEach((module) => {
        switch (module) {
          case 'associations':
            this.navItems = [
              ...this.navItems,
              {
                label: 'Pious Associations',
                icon: faPeopleGroup,
                route: 'associations',
                order: 4,
              },
            ];
            break;
          case 'ceremonies':
            this.navItems = [
              ...this.navItems,
              {
                label: 'Ceremony Register',
                icon: faBook,
                route: 'ceremonies',
                order: 3,
              },
            ];
            break;
          case 'configurations':
            this.navItems = [
              ...this.navItems,
              {
                label: 'Configurations',
                icon: faGear,
                route: 'configurations',
                order: 9,
              },
              {
                label: 'Parish Year',
                icon: faCalendarAlt,
                route: 'parish-year',
                order: 8,
              },
            ];
            break;
          case 'payments':
            this.navItems = [
              ...this.navItems,
              {
                label: 'Payment Register',
                icon: faFileInvoiceDollar,
                route: 'payments',
                order: 7,
              },
            ];
            break;
          case 'bookings':
            this.navItems = [
              ...this.navItems,
              {
                label: 'Bookings',
                icon: faCalendarCheck,
                route: 'bookings',
                order: 5,
              },
            ];
            break;
          case 'family-records':
            this.navItems = [
              ...this.navItems,
              {
                label: 'Family Records',
                icon: faPeopleRoof,
                route: 'family-records',
                order: 2,
              },
            ];
            break;
          case 'dashboard':
            this.navItems = [
              ...this.navItems,
              {
                label: 'Dashboard',
                icon: faLayerGroup,
                route: 'dashboard',
                order: 1,
              },
            ];
            break;
          case 'users':
            this.navItems = [
              ...this.navItems,
              { label: 'Users', icon: faUsersCog, route: 'users', order: 10 },
            ];
            break;
          case 'expenses':
            this.navItems = [
              ...this.navItems,
              {
                label: 'Expense Register',
                icon: faMoneyBillWave,
                route: 'expenses',
                order: 6,
              },
            ];
            break;
        }
      });
      this.navItems.sort((a, b) => a.order - b.order);
    }
  }
}
