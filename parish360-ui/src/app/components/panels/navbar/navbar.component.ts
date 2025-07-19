import { Component } from '@angular/core';
import { FontAwesomeModule } from '@fortawesome/angular-fontawesome';
import { faBars, faBell } from '@fortawesome/free-solid-svg-icons';
import { AuthService } from '../../../authentication/auth.service';
import { PermissionsService } from '../../../services/common/permissions.service';
import { Router } from '@angular/router';

@Component({
  selector: 'app-navbar',
  standalone: true,
  imports: [FontAwesomeModule],
  templateUrl: './navbar.component.html',
  styleUrl: './navbar.component.css',
})
export class NavbarComponent {
  faBars = faBars;
  faBell = faBell;

  constructor(
    private auth: AuthService,
    private permissions: PermissionsService,
    private router: Router
  ) {}

  logout() {
    this.permissions.removePermissions();
    this.auth.logout();
    this.router.navigate(['/logout']);
  }
}
