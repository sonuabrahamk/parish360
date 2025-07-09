import { Routes } from '@angular/router';
import { DashboardComponent } from './pages/dashboard/dashboard.component';
import { RecordsListComponent } from './pages/records-list/records-list.component';
import { RecordsViewComponent } from './pages/records-view/records-view.component';
import { AuthGuard } from './authentication/auth.guard';
import { LoginComponent } from './pages/login/login.component';

export const routes: Routes = [
  {
    path: '',
    component: DashboardComponent,
    canActivate: [AuthGuard],
  },
  {
    path: 'login',
    component: LoginComponent
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
  { path: '**', redirectTo: '' },
];
