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
import { CeremonyViewComponent } from './pages/ceremony-register/ceremony-view/ceremony-view.component';
import { PaymentsViewComponent } from './pages/payments-register/payments-view/payments-view.component';
import { ExpenseViewComponent } from './pages/expense-register/expense-view/expense-view.component';
import { AssociationViewComponent } from './pages/pious-associations/association-view/association-view.component';
import { UserViewComponent } from './pages/users-management/user-view/user-view.component';
import { ConfigurationViewComponent } from './pages/configurations/configuration-view/configuration-view.component';
import { ParishYearListComponent } from './pages/parish-year/parish-year-list/parish-year-list.component';
import { ParishYearViewComponent } from './pages/parish-year/parish-year-view/parish-year-view.component';

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
    path: 'family-records/:id/:section',
    component: RecordsViewComponent,
    canActivate: [AuthGuard],
  },
  {
    path: 'family-records/:id/:section/:sectionId',
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
    path: 'ceremonies',
    component: CeremonyListComponent,
    canActivate: [AuthGuard],
  },
  {
    path: 'ceremonies/:id',
    component: CeremonyViewComponent,
    canActivate: [AuthGuard],
  },
  {
    path: 'associations',
    component: AssociationsListComponent,
    canActivate: [AuthGuard],
  },
  {
    path: 'associations/view/:associationId',
    component: AssociationViewComponent,
    canActivate: [AuthGuard],
  },
  {
    path: 'payments',
    component: PaymentsListComponent,
    canActivate: [AuthGuard],
  },
  {
    path: 'payments/view/:paymentId',
    component: PaymentsViewComponent,
    canActivate: [AuthGuard],
  },
  {
    path: 'payments/create',
    component: PaymentsViewComponent,
    canActivate: [AuthGuard],
  },
  {
    path: 'expenses',
    component: ExpensesListComponent,
    canActivate: [AuthGuard],
  },
  {
    path: 'expenses/create',
    component: ExpenseViewComponent,
    canActivate: [AuthGuard],
  },
  {
    path: 'expenses/view/:expenseId',
    component: ExpenseViewComponent,
    canActivate: [AuthGuard],
  },
  {
    path: 'users',
    component: UsersListComponent,
    canActivate: [AuthGuard],
  },
  {
    path: 'users/create',
    component: UserViewComponent,
    canActivate: [AuthGuard],
  },
  {
    path: 'users/view/:userId',
    component: UserViewComponent,
    canActivate: [AuthGuard],
  },
  {
    path: 'configurations',
    component: ConfigurationViewComponent,
    canActivate: [AuthGuard],
  },
  {
    path: 'configurations/:section',
    component: ConfigurationViewComponent,
    canActivate: [AuthGuard],
  },
  {
    path: 'configurations/:section/:sectionId',
    component: ConfigurationViewComponent,
    canActivate: [AuthGuard],
  },
  {
    path: 'parish-year',
    component: ParishYearListComponent,
    canActivate: [AuthGuard],
  },
  {
    path: 'parish-year/:parishYearId',
    component: ParishYearViewComponent,
    canActivate: [AuthGuard],
  },
  { path: '**', redirectTo: '/dashboard' },
];
