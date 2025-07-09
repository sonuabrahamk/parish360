import { Component } from '@angular/core';
import { AuthService } from '../../authentication/auth.service';
import { Observable } from 'rxjs';
import { CommonModule } from '@angular/common';

@Component({
  selector: 'app-dashboard',
  imports: [CommonModule],
  templateUrl: './dashboard.component.html',
  styleUrl: './dashboard.component.css'
})
export class DashboardComponent {
  token: string | Observable<string> = '';

  constructor(public auth: AuthService) {}

  ngInit() {
   this.token = this.auth.getToken();
  }

}
