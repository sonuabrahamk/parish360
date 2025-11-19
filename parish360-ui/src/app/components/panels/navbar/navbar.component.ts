import { Component } from '@angular/core';
import { FontAwesomeModule } from '@fortawesome/angular-fontawesome';
import {
  faBars,
  faBell,
  faRightFromBracket,
  faUserPen,
} from '@fortawesome/free-solid-svg-icons';
import { AuthService } from '../../../authentication/auth.service';
import { Router, RouterModule } from '@angular/router';
import { CommonModule } from '@angular/common';
import { User } from '../../../services/interfaces/permissions.interface';
import { USER_INFO_KEY } from '../../../services/common/common.constants';

@Component({
  selector: 'app-navbar',
  standalone: true,
  imports: [FontAwesomeModule, RouterModule, CommonModule],
  templateUrl: './navbar.component.html',
  styleUrl: './navbar.component.css',
})
export class NavbarComponent {
  faBars = faBars;
  faBell = faBell;
  faRightFromBracket = faRightFromBracket;
  faUserCircle = faUserPen;

  isOpen: boolean = false;
  user!: User;

  constructor(private auth: AuthService, private router: Router) {}

  userClick() {
    this.isOpen = !this.isOpen;
  }

  profileClick() {
    this.user = JSON.parse(localStorage.getItem(USER_INFO_KEY) || '');
    this.router.navigate(['/users', this.user?.id]);
  }

  logout() {
    this.auth.logout();
    this.router.navigate(['/logout']);
  }
}
