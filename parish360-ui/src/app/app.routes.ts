import { Routes } from '@angular/router';
import { DashboardComponent } from './pages/dashboard/dashboard.component';
import { RecordsListComponent } from './pages/family-records/records-list/records-list.component';
import { RecordsViewComponent } from './pages/family-records/records-view/records-view.component';
import { AuthGuard } from './authentication/auth.guard';
import { LoginComponent } from './pages/login/login.component';
import { UnauthorizedComponent } from './pages/unauthorized/unauthorized.component';
import { LogoutComponent } from './pages/logout/logout.component';
import { BookingsListComponent } from './pages/bookings/bookings-list/bookings-list.component';
import { BookingsCreateComponent } from './pages/bookings/bookings-create/bookings-create.component';
import { CeremonyListComponent } from './pages/ceremony-register/ceremony-list/ceremony-list.component';
import { AssociationsListComponent } from './pages/pious-associations/associations-list/associations-list.component';
import { PaymentsListComponent } from './pages/payments-register/payments-list/payments-list.component';
import { ExpensesListComponent } from './pages/expense-register/expenses-list/expenses-list.component';
import { UsersListComponent } from './pages/users-management/users-list/users-list.component';

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
  {
    path: 'ceremonys',
    component: CeremonyListComponent,
    canActivate: [AuthGuard],
  },
  {
    path: 'associations',
    component: AssociationsListComponent,
    canActivate: [AuthGuard],
  },
  {
    path: 'payments',
    component: PaymentsListComponent,
    canActivate: [AuthGuard],
  },
  {
    path: 'expenses',
    component: ExpensesListComponent,
    canActivate: [AuthGuard],
  },
  {
    path: 'users',
    component: UsersListComponent,
    canActivate: [AuthGuard],
  },
  { path: '**', redirectTo: '/dashboard' },
];
