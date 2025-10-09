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

  private dioceseId!: string;
  private foraneId!: string;
  private parishId!: string;
  private baseUrl!: string;

  private loadBaseUrl() {
    // if (!this.dioceseId) {
    //   let diocese = localStorage.getItem(DIOCESE);
    //   this.dioceseId = diocese ? JSON.parse(diocese) : 'dioceseId1';
    // }
    // if (!this.foraneId) {
    //   let forane = localStorage.getItem(FORANE);
    //   this.foraneId = forane ? JSON.parse(forane) : 'foraneId1';
    // }
    if (!this.parishId) {
      let parish = localStorage.getItem(PARISH);
      this.parishId = parish ? JSON.parse(parish) : 'parishId1';
    }
    if (!this.baseUrl) {
      this.baseUrl =
        'http://localhost:8080' +
        BASE_URL.PARISH_BY_ID(this.parishId);
    }
    return this.baseUrl;
  }

  private headers(): HttpHeaders {
    const token = this.auth.getToken();
    return new HttpHeaders({
      'Content-Type': 'application/json',
    });
  }

  get<T>(url: string): Observable<T> {
    return this.http
      .get<T>(`${this.loadBaseUrl()}${url}`, { headers: this.headers() })
      .pipe(catchError(this.handleError));
  }

  post<T>(url: string, data: any): Observable<T> {
    return this.http
      .post<T>(`${this.loadBaseUrl()}${url}`, data, { headers: this.headers() })
      .pipe(catchError(this.handleError));
  }

  patch<T>(url: string, data: any): Observable<T> {
    return this.http
      .patch<T>(`${this.loadBaseUrl()}${url}`, data, { headers: this.headers() })
      .pipe(catchError(this.handleError));
  }

  put<T>(url: string, data: any): Observable<T> {
    return this.http
      .put<T>(`${this.loadBaseUrl()}${url}`, data, { headers: this.headers() })
      .pipe(catchError(this.handleError));
  }

  delete<T>(url: string): Observable<T> {
    return this.http
      .delete<T>(`${this.loadBaseUrl()}${url}`, { headers: this.headers() })
      .pipe(catchError(this.handleError));
  }

  private handleError(error: any) {
    // You can handle different status codes here
    console.error('API error:', error);
    return throwError(() => new Error(error?.message || 'Server Error'));
  }
}
