import { Routes } from '@angular/router';
import { DashboardComponent } from './pages/dashboard/dashboard.component';
import { RecordsListComponent } from './pages/records-list/records-list.component';
import { RecordsViewComponent } from './pages/records-view/records-view.component';

export const routes: Routes = [
    {
        path: '',
        component: DashboardComponent
    },
    {
        path: 'family-records',
        component: RecordsListComponent
    },
    {
        path: 'family-records/:id',
        component: RecordsViewComponent
    }
];
