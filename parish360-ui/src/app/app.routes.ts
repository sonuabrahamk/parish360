import { Routes } from '@angular/router';
import { DashboardComponent } from './pages/dashboard/dashboard.component';
import { RecordsListComponent } from './pages/records-list/records-list.component';
import { RecordsViewComponent } from './pages/records-view/records-view.component';
import { AuthGuard } from './authentication/auth.guard';
import { LoginComponent } from './pages/login/login.component';
import { UnauthorizedComponent } from './pages/unauthorized/unauthorized.component';
import { LogoutComponent } from './pages/logout/logout.component';
import { BookingsListComponent } from './pages/bookings-list/bookings-list.component';
import { BookingsCreateComponent } from './pages/bookings-create/bookings-create.component';

export const routes: Routes = [
  {
    path: 'login',
    component: LoginComponent,
  },
  {
    path: 'logout',
    component: LogoutComponent,
  },
  {
    path: 'unauthorised',
    component: UnauthorizedComponent,
  },
  {
    path: 'dashboard',
    component: DashboardComponent,
    canActivate: [AuthGuard],
  },
  {
    path: 'family-records',
    component: RecordsListComponent,
    canActivate: [AuthGuard],
  },
  {
    path: 'family-records/:id',
    component: RecordsViewComponent,
    canActivate: [AuthGuard],
  },
  {
    path: 'bookings',
    component: BookingsListComponent,
    canActivate: [AuthGuard],
  },
  {
    path: 'bookings/create',
    component: BookingsCreateComponent,
    canActivate: [AuthGuard],
  },
  { path: '**', redirectTo: '/dashboard' },
];
