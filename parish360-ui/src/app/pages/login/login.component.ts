import { Component } from '@angular/core';
import { Router } from '@angular/router';
import { AuthService } from '../../authentication/auth.service';

@Component({
  selector: 'app-login',
  standalone: true,
  imports: [],
  templateUrl: './login.component.html',
  styleUrl: './login.component.css'
})
export class LoginComponent {
  constructor(public auth: AuthService, private router: Router) {}

  ngOnInit(): void {
    if (this.auth.isAuthenticated()) {
      console.log('User already logged in, redirecting...');
      this.router.navigate(['/']);
    }
  }

  loginInternal(u: string, p: string, e: Event) {
    e.preventDefault();
    this.auth.loginInternal(u, p).subscribe(() => this.router.navigate(['/']));
  }

}
