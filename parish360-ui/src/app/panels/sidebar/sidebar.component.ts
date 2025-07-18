import { CommonModule } from '@angular/common';
import { Component } from '@angular/core';
import { RouterModule } from '@angular/router';

@Component({
  selector: 'app-sidebar',
  standalone: true,
  imports: [CommonModule, RouterModule],
  templateUrl: './sidebar.component.html',
  styleUrl: './sidebar.component.css',
})
export class SidebarComponent {
  navItems = [
    { label: 'Parish Dashboard', icon: 'view_grid', route: 'dashboard' },
    { label: 'Family Records', icon: 'person', route: 'family-records' },
    { label: 'Bookings', icon: 'settings', route: 'bookings' },
  ];
}
