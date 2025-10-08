import { Injectable } from '@angular/core';
import { Observable } from 'rxjs';
import { ApiService } from './api.service';
import { User } from '../interfaces/permissions.interface';
import { EXTENSION, USER_BY_ID, USERS } from './api.constants';

@Injectable({ providedIn: 'root' })
export class UserService {
  constructor(private api: ApiService) {}

  getUsers(): Observable<User[]> {
    return this.api.get<User[]>(USERS);
  }

  getUser(id: string): Observable<User> {
    return this.api.get<User>(USER_BY_ID(id));
  }

  createUser(data: Partial<User>): Observable<User> {
    return this.api.post<User>(USERS, data);
  }

  updateUser(id: string, data: Partial<User>): Observable<User> {
    return this.api.put<User>(USER_BY_ID(id), data);
  }

  deleteUser(id: string): Observable<void> {
    return this.api.delete<void>(USER_BY_ID(id));
  }
}
