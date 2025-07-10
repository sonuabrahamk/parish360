import { Injectable } from '@angular/core';
import { ApiService } from '../api/api.service';
import { Observable } from 'rxjs';
import { Permissions } from '../interfaces/permissions.interface';
import { BASE_URL } from '../api/api.constants';
import {
  CREATE,
  DELETE,
  DIOCESE,
  EDIT,
  FORANE,
  PARISH,
  PERMISSIONS_KEY,
  VIEW,
} from './common.constants';

@Injectable({ providedIn: 'root' })
export class PermissionsService {
  private permissions: Permissions | null = null;

  constructor(private apiService: ApiService) {}

  getPermissions(userId: string): Observable<Permissions> {
    return this.apiService.get<Permissions>(BASE_URL.PERMISSIONS(userId));
  }

  setPermissions(userId: string) {
    this.getPermissions(userId).subscribe((permissions) => {
      this.permissions = permissions;
      localStorage.setItem(PERMISSIONS_KEY, JSON.stringify(permissions));
      localStorage.setItem(
        DIOCESE,
        JSON.stringify(permissions?.data?.[DIOCESE][0])
      );
      localStorage.setItem(
        FORANE,
        JSON.stringify(permissions?.data?.[FORANE][0])
      );
      localStorage.setItem(
        PARISH,
        JSON.stringify(permissions?.data?.[PARISH][0])
      );
    });
  }

  removePermissions() {
    this.permissions = null;
    localStorage.removeItem(PARISH);
    localStorage.removeItem(FORANE);
    localStorage.removeItem(DIOCESE);
    localStorage.removeItem(PERMISSIONS_KEY);
  }

  loadFromLocalStorage() {
    if (localStorage.getItem(PERMISSIONS_KEY)) {
      this.permissions = JSON.parse(
        localStorage.getItem(PERMISSIONS_KEY) ?? ''
      );
    }
  }

  hasPermission(screen: string, permission: string): boolean {
    if (!this.permissions) {
      this.loadFromLocalStorage();
    }
    return (
      this.permissions?.screen?.[screen]?.includes(permission.toUpperCase()) ??
      false
    );
  }

  canEdit(screen: string): boolean {
    if (!this.permissions) {
      this.loadFromLocalStorage();
    }
    return this.permissions?.screen?.[screen]?.includes(EDIT) ?? false;
  }

  canCreate(screen: string): boolean {
    if (!this.permissions) {
      this.loadFromLocalStorage();
    }
    return this.permissions?.screen?.[screen]?.includes(CREATE) ?? false;
  }

  canDelete(screen: string): boolean {
    if (!this.permissions) {
      this.loadFromLocalStorage();
    }
    return this.permissions?.screen?.[screen]?.includes(DELETE) ?? false;
  }

  canView(screen: string): boolean {
    if (!this.permissions) {
      this.loadFromLocalStorage();
    }
    return this.permissions?.screen?.[screen]?.includes(VIEW) ?? false;
  }
}
