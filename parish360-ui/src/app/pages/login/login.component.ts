import { Component, inject } from '@angular/core';
import { Router } from '@angular/router';
import { AuthService } from '../../authentication/auth.service';
import { PermissionsService } from '../../services/common/permissions.service';

@Component({
  selector: 'app-login',
  standalone: true,
  imports: [],
  templateUrl: './login.component.html',
  styleUrl: './login.component.css',
})
export class LoginComponent {
  constructor(
    public auth: AuthService,
    private router: Router,
    private permissions: PermissionsService
  ) {}

  ngOnInit(): void {
    // if user is authenticated, redirect to home page
    if (this.auth.isAuthenticated()) {
      this.router.navigate(['/']);
    }
  }

  loginInternal(u: string, p: string, e: Event) {
    e.preventDefault();
    this.auth.loginInternal(u, p).subscribe({
      next: () => {
        this.router.navigate(['/']);
      }
    });
  }
}
