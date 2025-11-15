import { Component } from '@angular/core';
import { SummaryComponent } from '../../components/dashboard/summary/summary.component';
import { DashboardService } from '../../services/api/dashboard.service';
import { Summary } from '../../services/interfaces/dashboard.interface';
import { CommonModule } from '@angular/common';
import { ToastService } from '../../services/common/toast.service';
import { ServiceIntentionsComponent } from '../../components/dashboard/service-intentions/service-intentions.component';
import { BookingsSummaryComponent } from '../../components/dashboard/bookings-summary/bookings-summary.component';
import {
  Tab,
  TabsComponent,
} from '../../components/common/tabs/tabs.component';
import {
  faCalendarCheck,
  faDollar,
  faFileInvoiceDollar,
  faHandsPraying,
  faMoneyBillWave,
  faPeopleGroup,
  faPersonBurst,
  faUsers,
} from '@fortawesome/free-solid-svg-icons';
import { ActivatedRoute } from '@angular/router';
import { SCREENS } from '../../services/common/common.constants';
import { MembersListComponent } from '../../components/dashboard/members-list/members-list.component';
import { AccountStatementComponent } from '../../components/dashboard/account-statement/account-statement.component';
import { PermissionsService } from '../../services/common/permissions.service';

@Component({
  selector: 'app-dashboard',
  imports: [
    CommonModule,
    SummaryComponent,
    ServiceIntentionsComponent,
    BookingsSummaryComponent,
    TabsComponent,
    MembersListComponent,
    AccountStatementComponent,
  ],
  templateUrl: './dashboard.component.html',
  styleUrl: './dashboard.component.css',
})
export class DashboardComponent {
  summary!: Summary;
  summaryTabs: Tab[] = [];
  summarySection!: string;
  activeTabIndex: number = 0;

  constructor(
    public dashboardService: DashboardService,
    private toastService: ToastService,
    private route: ActivatedRoute,
    private permissionService: PermissionsService
  ) {}

  ngOnInit() {
    this.dashboardService.getParishReport().subscribe({
      next: (summary) => {
        this.summary = summary;
      },
      error: () => {
        this.toastService.error('error loading parish report');
      },
    });

    this.route.paramMap.subscribe((params) => {
      this.summaryTabs.length === 0 ? this.createSummaryTabs() : null;
      this.summarySection =
        params.get('section') || this.summaryTabs[0].data || '';
      this.activeTabIndex = this.summaryTabs.findIndex(
        (tab) => tab.data === this.summarySection
      );
    });
  }

  private createSummaryTabs() {
    // add members list if allowed
    this.permissionService.canView(SCREENS.FAMILY_RECORD)
      ? this.summaryTabs.push({
          label: 'Members List',
          icon: faUsers,
          data: 'members',
          url: `/dashboard/members`,
        })
      : null;

    // add service intentions if allowed
    this.permissionService.canView(SCREENS.BOOKINGS)
      ? this.summaryTabs.push({
          label: 'Service-Intentions Summary',
          icon: faHandsPraying,
          data: 'service-intentions',
          url: `/dashboard/service-intentions`,
        })
      : null;

    // add bookings summary if allowed
    this.permissionService.canView(SCREENS.BOOKINGS)
      ? this.summaryTabs.push({
          label: 'Bookings Summary',
          icon: faCalendarCheck,
          data: 'bookings',
          url: `/dashboard/bookings`,
        })
      : null;

    // add account statement if allowed
    this.permissionService.canView(SCREENS.PAYMENTS) &&
    this.permissionService.canView(SCREENS.EXPENSES)
      ? this.summaryTabs.push({
          label: 'Account Statement',
          icon: faFileInvoiceDollar,
          data: 'accounts',
          url: `/dashboard/accounts`,
        })
      : null;
  }
}
