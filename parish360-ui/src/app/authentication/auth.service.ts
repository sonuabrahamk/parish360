import { Injectable } from "@angular/core";
import { JwtAuthService } from "./jwt-auth.service";
import { OidcAuthService } from "./oidc-auth.service";

@Injectable({ providedIn: 'root' })
export class AuthService {
  constructor(
    private jwtAuth: JwtAuthService,
    private oidcAuth: OidcAuthService
  ) {}

  loginInternal(username: string, password: string) {
    return this.jwtAuth.login(username, password);
  }

  loginOIDC() {
    this.oidcAuth.login();
  }

  logout() {
    this.jwtAuth.logout();
    this.oidcAuth.logout();
  }

  getToken() {
    return this.jwtAuth.getToken() || this.oidcAuth.getToken();
  }

  isAuthenticated(): boolean {
    return this.jwtAuth.isLoggedIn(); // You can extend this to handle both flows
  }
}
