import { Routes } from '@angular/router';
import { DashboardComponent } from './pages/dashboard/dashboard.component';
import { RecordsListComponent } from './pages/records-list/records-list.component';

export const routes: Routes = [
    {
        path: '',
        component: DashboardComponent
    },
    {
        path: 'family-records',
        component: RecordsListComponent
    }
];
