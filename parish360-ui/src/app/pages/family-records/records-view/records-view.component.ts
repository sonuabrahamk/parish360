import { Component } from '@angular/core';
import { CommonModule } from '@angular/common';
import {
  TabsComponent,
  Tab,
} from '../../../components/common/tabs/tabs.component';
import { MembersComponent } from '../../../components/family-records/members/members.component';
import {
  faHouse,
  faUsers,
  faPrayingHands,
  faCalendarCheck,
  faIndianRupee,
  faBox,
} from '@fortawesome/free-solid-svg-icons';
import { ActivatedRoute } from '@angular/router';
import { BlessingsSectionComponent } from '../../../components/family-records/blessings-section/blessings-section.component';
import { FamilyInfoComponent } from '../../../components/family-records/family-info/family-info.component';
import { SubscriptionsComponent } from '../../../components/family-records/subscriptions/subscriptions.component';
import { PaymentsComponent } from '../../../components/family-records/payments/payments.component';
import { MiscellenousComponent } from '../../../components/family-records/miscellenous/miscellenous.component';

@Component({
  selector: 'app-records-view',
  standalone: true,
  imports: [
    CommonModule,
    TabsComponent,
    MembersComponent,
    BlessingsSectionComponent,
    FamilyInfoComponent,
    SubscriptionsComponent,
    PaymentsComponent,
    MiscellenousComponent,
  ],
  templateUrl: './records-view.component.html',
  styleUrl: './records-view.component.css',
})
export class RecordsViewComponent {
  familyTabs: Tab[] = [];
  recordId!: string;
  section: string | null = null;
  activeTabIndex = 0;
  newFamilyRecord?: boolean = false;

  constructor(private route: ActivatedRoute) {}

  ngOnInit(): void {
    this.route.paramMap.subscribe((params) => {
      this.recordId = params.get('id') ?? '';
      if (this.recordId === 'new') {
        this.newFamilyRecord = true;
        this.familyTabs = [
          {
            label: 'Family Info',
            icon: faHouse,
            url: `/family-records/${this.recordId}`,
          },
        ];
      } else {
        this.section = params.get('section');
        switch (this.section) {
          case 'members':
            this.activeTabIndex = 1;
            break;
          case 'blessings':
            this.activeTabIndex = 2;
            break;
          case 'subscriptions':
            this.activeTabIndex = 3;
            break;
          case 'payments':
            this.activeTabIndex = 4;
            break;
          case 'miscellaneous':
            this.activeTabIndex = 5;
            break;
          default:
            this.activeTabIndex = 0;
        }
        this.familyTabs = [
          {
            label: 'Family Info',
            icon: faHouse,
            url: `/family-records/${this.recordId}`,
          },
          {
            label: 'Members',
            icon: faUsers,
            url: `/family-records/${this.recordId}/members`,
          },
          {
            label: 'Blessings',
            icon: faPrayingHands,
            url: `/family-records/${this.recordId}/blessings`,
          },
          {
            label: 'Subscriptions',
            icon: faCalendarCheck,
            url: `/family-records/${this.recordId}/subscriptions`,
          },
          {
            label: 'Payments',
            icon: faIndianRupee,
            url: `/family-records/${this.recordId}/payments`,
          },
          {
            label: 'Miscellaneous',
            icon: faBox,
            url: `/family-records/${this.recordId}/miscellaneous`,
          },
        ];
      }
    });
  }
}
