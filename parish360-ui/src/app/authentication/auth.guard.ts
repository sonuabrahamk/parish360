import { Injectable } from '@angular/core';
import {
  CanActivate,
  Router,
  ActivatedRouteSnapshot,
  RouterStateSnapshot,
} from '@angular/router';
import { AuthService } from './auth.service';
import { PERMISSIONS_KEY } from '../services/common/common.constants';
import { Permissions } from '../services/interfaces/permissions.interface';

@Injectable({ providedIn: 'root' })
export class AuthGuard implements CanActivate {
  constructor(private authService: AuthService, private router: Router) {}

  canActivate(
    route: ActivatedRouteSnapshot,
    state?: RouterStateSnapshot
  ): boolean {
    if (!this.authService.isAuthenticated()) {
      this.router.navigate(['/login']);
      return false;
    }

    const requiredRoles = route.data['module'] as string | undefined;
    const permissionsString = localStorage.getItem(PERMISSIONS_KEY);
    const permissions: Permissions | null = permissionsString
      ? JSON.parse(permissionsString)
      : null;
    const userRoles: string[] = permissions?.modules['view'] ?? [];

    // for users redirected to dashboard due to incorrect URL
    if (
      requiredRoles === 'dashboard' &&
      !userRoles.includes(requiredRoles) &&
      userRoles.length > 0
    ) {
      this.router.navigate(['/', userRoles[0]]);
      return false;
    }

    if (requiredRoles && !userRoles.includes(requiredRoles)) {
      // Optional: redirect to unauthorized page
      this.router.navigate(['/unauthorized']);
      return false;
    }

    return true;
  }
}
