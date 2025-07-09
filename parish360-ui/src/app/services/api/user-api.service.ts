import { Injectable } from '@angular/core';
import { Observable } from 'rxjs';
import { ApiService } from './api.service';

export interface User {
  id: number;
  name: string;
  email: string;
}

@Injectable({ providedIn: 'root' })
export class UserApiService {
  constructor(private api: ApiService) {}

  getUsers(): Observable<User[]> {
    return this.api.get<User[]>('/users');
  }

  getUser(id: number): Observable<User> {
    return this.api.get<User>(`/users/${id}`);
  }

  createUser(data: Partial<User>): Observable<User> {
    return this.api.post<User>('/users', data);
  }

  updateUser(id: number, data: Partial<User>): Observable<User> {
    return this.api.put<User>(`/users/${id}`, data);
  }

  deleteUser(id: number): Observable<void> {
    return this.api.delete<void>(`/users/${id}`);
  }
}
