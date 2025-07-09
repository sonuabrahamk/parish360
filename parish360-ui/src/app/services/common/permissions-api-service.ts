import { Injectable } from '@angular/core';
import { ApiService } from '../api/api.service';
import { Observable } from 'rxjs';
import { Permissions } from '../interfaces/permissions.interface';
import { ApiConstants } from '../api/api.constants';
import { CREATE, DELETE, EDIT, VIEW } from './common.constants';

@Injectable({ providedIn: 'root' })
export class PermissionsService {
  private permissions: Permissions | null = null;

  constructor(private apiService: ApiService) {}

  getPermissions(userId: string): Observable<Permissions> {
    return this.apiService.get<Permissions>(ApiConstants.PERMISSIONS(userId));
  }

  setPermissions(userId: string) {
    this.getPermissions(userId).subscribe((permissions) => {
      this.permissions = permissions;
      localStorage.setItem(
        ApiConstants.PERMISSIONS_KEY,
        JSON.stringify(permissions)
      );
    });
  }

  hasPermission(screen: string, permission: string): boolean {
    if(!this.permissions){
      this.loadFromLocalStorage()
    }
    return (
      this.permissions?.screen?.[screen]?.includes(permission.toUpperCase()) ??
      false
    );
  }

  loadFromLocalStorage (){
    if (localStorage.getItem(ApiConstants.PERMISSIONS_KEY)){
      this.permissions = JSON.parse(localStorage.getItem(ApiConstants.PERMISSIONS_KEY)??'')
    }
  }

  canEdit(screen: string):boolean{
    if(!this.permissions){
      this.loadFromLocalStorage()
    }
    return (
      this.permissions?.screen?.[screen]?.includes(EDIT) ??
      false
    );
  }

  canCreate(screen: string):boolean{
    if(!this.permissions){
      this.loadFromLocalStorage()
    }
    return (
      this.permissions?.screen?.[screen]?.includes(CREATE) ??
      false
    );
  }

  canDelete(screen: string):boolean{
    if(!this.permissions){
      this.loadFromLocalStorage()
    }
    return (
      this.permissions?.screen?.[screen]?.includes(DELETE) ??
      false
    );
  }

  canView(screen: string):boolean{
    if(!this.permissions){
      this.loadFromLocalStorage()
    }
    return (
      this.permissions?.screen?.[screen]?.includes(VIEW) ??
      false
    );
  }
}
