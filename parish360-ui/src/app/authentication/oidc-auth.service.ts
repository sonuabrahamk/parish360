import { Injectable } from '@angular/core';
import {
  OidcSecurityService,
  OpenIdConfiguration,
  AuthWellKnownEndpoints
} from 'angular-auth-oidc-client';

@Injectable({ providedIn: 'root' })
export class OidcAuthService {
  constructor(public oidcSecurityService: OidcSecurityService) {}

  login() {
    this.oidcSecurityService.authorize();
  }

  logout() {
    this.oidcSecurityService.logoff();
  }

  isAuthenticated() {
    return this.oidcSecurityService.isAuthenticated$;
  }

  getToken() {
    return this.oidcSecurityService.getAccessToken();
  }
}
