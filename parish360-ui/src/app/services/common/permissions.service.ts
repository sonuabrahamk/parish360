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
import { Router } from '@angular/router';

@Injectable({ providedIn: 'root' })
export class PermissionsService {
  private permissions: Permissions | null = null;

  // constructor(private apiService: ApiService, private router: Router) {}

  // getPermissions(userId: string): Observable<Permissions> {
  //   return this.apiService.get<Permissions>(BASE_URL.PERMISSIONS(userId));
  // }

  // setPermissions(userId: string) {
  //   this.getPermissions(userId).subscribe((permissions) => {
  //     this.permissions = permissions;
  //     localStorage.setItem(PERMISSIONS_KEY, JSON.stringify(permissions));
  //     localStorage.setItem(
  //       DIOCESE,
  //       JSON.stringify(permissions?.data_owner?.[DIOCESE][0])
  //     );
  //     localStorage.setItem(
  //       FORANE,
  //       JSON.stringify(permissions?.data_owner?.[FORANE][0])
  //     );
  //     localStorage.setItem(
  //       PARISH,
  //       JSON.stringify(permissions?.data_owner?.[PARISH][0])
  //     );
  //     this.router.navigate(['/']);
  //   });
  // }

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
      this.permissions?.modules?.[permission.toUpperCase()]?.includes(screen.toLowerCase()) ??
      false
    );
  }

  canEdit(screen: string): boolean {
    if (!this.permissions) {
      this.loadFromLocalStorage();
    }
    debugger;
    return this.permissions?.modules?.[EDIT]?.includes(screen.toLowerCase()) ?? false;
  }

  canCreate(screen: string): boolean {
    if (!this.permissions) {
      this.loadFromLocalStorage();
    }
    return this.permissions?.modules?.[CREATE]?.includes(screen.toLowerCase()) ?? false;
  }

  canDelete(screen: string): boolean {
    if (!this.permissions) {
      this.loadFromLocalStorage();
    }
    return this.permissions?.modules?.[DELETE]?.includes(screen.toLowerCase()) ?? false;
  }

  canView(screen: string): boolean {
    if (!this.permissions) {
      this.loadFromLocalStorage();
    }
    return this.permissions?.modules?.[VIEW]?.includes(screen.toLowerCase()) ?? false;
  }
}
