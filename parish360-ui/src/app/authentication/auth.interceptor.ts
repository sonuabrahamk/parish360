import {
  HttpErrorResponse,
  HttpInterceptorFn,
} from '@angular/common/http';
import { inject } from '@angular/core';
import { DIOCESE, FORANE, PARISH, PERMISSIONS_KEY } from '../services/common/common.constants';
import { catchError, throwError } from 'rxjs';
import { Router } from '@angular/router';

export const authInterceptor: HttpInterceptorFn = (req, next) => {
  const router = inject(Router);

  const authReq = req.clone({
    withCredentials: true,
  });
  return next(authReq).pipe(
    catchError((error: HttpErrorResponse) => {
      if (error.status === 401) {
        localStorage.removeItem(PERMISSIONS_KEY);
        localStorage.removeItem(PARISH);
        localStorage.removeItem(FORANE);
        localStorage.removeItem(DIOCESE);
    
        localStorage.removeItem('auth-token');
        router.navigate(['/login']);
      }
      return throwError(() => error);
    })
  );
};
