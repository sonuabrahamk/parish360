import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { tap } from 'rxjs/operators';
import {
  DIOCESE,
  FORANE,
  PARISH,
  PERMISSIONS_KEY,
} from '../services/common/common.constants';
import { Permissions } from '../services/interfaces/permissions.interface';

@Injectable({ providedIn: 'root' })
export class JwtAuthService {
  private readonly TOKEN_KEY = 'auth-token';

  constructor(private http: HttpClient) {}

  login(username: string, password: string) {
    return this.http
      .post<{ accessToken: string; permissions: Permissions }>(
        'http://localhost:8080/auth/login',
        { username, password },
        { withCredentials: true }
      )
      .pipe(
        tap((response) => {
          localStorage.setItem(this.TOKEN_KEY, response.accessToken);
          localStorage.setItem(
            PERMISSIONS_KEY,
            JSON.stringify(response.permissions)
          );
          localStorage.setItem(
            DIOCESE,
            JSON.stringify(response.permissions?.data_owner?.[DIOCESE][0])
          );
          localStorage.setItem(
            FORANE,
            JSON.stringify(response.permissions?.data_owner?.[FORANE][0])
          );
          localStorage.setItem(
            PARISH,
            JSON.stringify(response.permissions?.data_owner?.[PARISH][0])
          );
        })
      );
  }

  logout() {
    // remove permissions and token from local storage
    localStorage.removeItem(PERMISSIONS_KEY);
    localStorage.removeItem(PARISH);
    localStorage.removeItem(FORANE);
    localStorage.removeItem(DIOCESE);

    localStorage.removeItem(this.TOKEN_KEY);
  }

  getToken(): string | null {
    return localStorage.getItem(this.TOKEN_KEY);
  }

  isLoggedIn(): boolean {
    return !!this.getToken();
  }
}
