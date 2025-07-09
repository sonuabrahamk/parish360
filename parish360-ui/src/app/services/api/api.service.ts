import { HttpClient, HttpHeaders } from '@angular/common/http';
import { inject, Injectable } from '@angular/core';
import { Observable, catchError, throwError } from 'rxjs';
import { AuthService } from '../../authentication/auth.service';

@Injectable({ providedIn: 'root' })
export class ApiService {
  private http = inject(HttpClient);
  private auth = inject(AuthService);
  private baseUrl = 'https://api.example.com'; // 🔁 Replace with your base URL

  private headers(): HttpHeaders {
    const token = this.auth.getToken();
    return new HttpHeaders({
      'Content-Type': 'application/json',
      ...(token ? { Authorization: `Bearer ${token}` } : {})
    });
  }

  get<T>(url: string): Observable<T> {
    return this.http.get<T>(`${this.baseUrl}${url}`, { headers: this.headers() }).pipe(
      catchError(this.handleError)
    );
  }

  post<T>(url: string, data: any): Observable<T> {
    return this.http.post<T>(`${this.baseUrl}${url}`, data, { headers: this.headers() }).pipe(
      catchError(this.handleError)
    );
  }

  put<T>(url: string, data: any): Observable<T> {
    return this.http.put<T>(`${this.baseUrl}${url}`, data, { headers: this.headers() }).pipe(
      catchError(this.handleError)
    );
  }

  delete<T>(url: string): Observable<T> {
    return this.http.delete<T>(`${this.baseUrl}${url}`, { headers: this.headers() }).pipe(
      catchError(this.handleError)
    );
  }

  private handleError(error: any) {
    // You can handle different status codes here
    console.error('API error:', error);
    return throwError(() => new Error(error?.message || 'Server Error'));
  }
}
