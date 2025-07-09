import { Component, inject } from '@angular/core';
import { Router } from '@angular/router';
import { AuthService } from '../../authentication/auth.service';
import { PermissionsService } from '../../services/common/permissions-api-service';
import { Permissions } from '../../services/interfaces/permissions.interface';

@Component({
  selector: 'app-login',
  standalone: true,
  imports: [],
  templateUrl: './login.component.html',
  styleUrl: './login.component.css'
})
export class LoginComponent {
  constructor(public auth: AuthService, private router: Router, private permissions: PermissionsService) {}

  ngOnInit(): void {
    if (this.auth.isAuthenticated()) {
      console.log('User already logged in, redirecting...');
      this.router.navigate(['/']);
    }
  }

  loginInternal(u: string, p: string, e: Event) {
    e.preventDefault();
    this.auth.loginInternal(u, p).subscribe(() => {
      this.permissions.setPermissions(u);
      this.router.navigate(['/']);
    });
  }

}
