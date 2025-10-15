import { ApplicationConfig } from '@angular/core';
import { provideRouter } from '@angular/router';

import { routes } from './app.routes';
import { provideHttpClient, withInterceptors } from '@angular/common/http';
import { provideAuth } from 'angular-auth-oidc-client';
import { authInterceptor } from './authentication/auth.interceptor';

export const appConfig: ApplicationConfig = {
  providers: [
    provideRouter(routes),
    provideHttpClient(withInterceptors([authInterceptor])),
    provideAuth({
      config: {
        authority: 'https://your-idp.com',
        clientId: 'client-id',
        redirectUrl: window.location.origin,
        postLogoutRedirectUri: window.location.origin,
        responseType: 'code',
        scope: 'openid profile email',
      },
    }),
  ],
};
