import { Component, inject } from '@angular/core';
import { Router } from '@angular/router';
import { AuthService } from '../../authentication/auth.service';
import { PermissionsService } from '../../services/common/permissions.service';
import { CommonModule } from '@angular/common';

@Component({
  selector: 'app-login',
  standalone: true,
  imports: [CommonModule],
  templateUrl: './login.component.html',
  styleUrl: './login.component.css',
})
export class LoginComponent {
  errorMessage: string = '';

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
    if(u === ''){
      this.errorMessage = 'Please enter a username';
      return;
    }
    if(p === ''){
      this.errorMessage = 'Please enter password';
      return;
    }
    this.auth.loginInternal(u, p).subscribe({
      next: () => {
        this.router.navigate(['/']);
      },
      error: (error) => {
        switch (error.status) {
          case 404:
            this.errorMessage =
              'User not found with above credentials! Please check username and retry';
            break;
          case 403:
            this.errorMessage =
              'Password is invalid! Please re-try with the correct password!';
            break;
          default:
            this.errorMessage = 'Please check the credentials and retry';
        }
      },
    });
  }

  onChange(){
    this.errorMessage = '';
  }
}
