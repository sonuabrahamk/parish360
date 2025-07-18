import { HttpClient, HttpHeaders } from '@angular/common/http';
import { inject, Injectable } from '@angular/core';
import { Observable, catchError, throwError } from 'rxjs';
import { AuthService } from '../../authentication/auth.service';
import { DIOCESE, FORANE, PARISH } from '../common/common.constants';
import { BASE_URL } from './api.constants';

@Injectable({ providedIn: 'root' })
export class ApiService {
  private http = inject(HttpClient);
  private auth = inject(AuthService);

  dioceseId: string = JSON.parse(localStorage.getItem(DIOCESE) ?? '');
  foraneId: string = JSON.parse(localStorage.getItem(FORANE) ?? '');
  parishId: string = JSON.parse(localStorage.getItem(PARISH) ?? '');
  private baseUrl: string = 'data' +
    BASE_URL.DIOCESE_BY_ID(this.dioceseId) +
    BASE_URL.FORANE_BY_ID(this.foraneId) +
    BASE_URL.PARISH_BY_ID(this.parishId);

  private headers(): HttpHeaders {
    const token = this.auth.getToken();
    return new HttpHeaders({
      'Content-Type': 'application/json',
      ...(token ? { Authorization: `Bearer ${token}` } : {}),
    });
  }

  get<T>(url: string): Observable<T> {
    return this.http
      .get<T>(`${this.baseUrl}${url}`, { headers: this.headers() })
      .pipe(catchError(this.handleError));
  }

  post<T>(url: string, data: any): Observable<T> {
    return this.http
      .post<T>(`${this.baseUrl}${url}`, data, { headers: this.headers() })
      .pipe(catchError(this.handleError));
  }

  put<T>(url: string, data: any): Observable<T> {
    return this.http
      .put<T>(`${this.baseUrl}${url}`, data, { headers: this.headers() })
      .pipe(catchError(this.handleError));
  }

  delete<T>(url: string): Observable<T> {
    return this.http
      .delete<T>(`${this.baseUrl}${url}`, { headers: this.headers() })
      .pipe(catchError(this.handleError));
  }

  private handleError(error: any) {
    // You can handle different status codes here
    console.error('API error:', error);
    return throwError(() => new Error(error?.message || 'Server Error'));
  }
}
