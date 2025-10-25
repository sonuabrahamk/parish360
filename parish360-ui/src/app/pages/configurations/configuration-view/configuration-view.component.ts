import { Component } from '@angular/core';
import {
  Tab,
  TabsComponent,
} from '../../../components/common/tabs/tabs.component';
import {
  faBank,
  faBuildingShield,
  faChurch,
  faHandsPraying,
  faHouse,
  faPeopleGroup,
  faPersonPraying,
  faPersonRays,
  faPrayingHands,
} from '@fortawesome/free-solid-svg-icons';
import { ActivatedRoute } from '@angular/router';
import { ParishInfoComponent } from '../../../components/configurations/parish-info/parish-info.component';
import { CommonModule } from '@angular/common';
import { ServicesComponent } from '../../../components/configurations/services/services.component';
import { ResourcesComponent } from '../../../components/configurations/resources/resources.component';
import { AssociationsComponent } from '../../../components/configurations/associations/associations.component';
import { AccountsComponent } from '../../../components/configurations/accounts/accounts.component';

@Component({
  selector: 'app-configuration-view',
  standalone: true,
  imports: [
    TabsComponent,
    ParishInfoComponent,
    CommonModule,
    ServicesComponent,
    ResourcesComponent,
    AssociationsComponent,
    AccountsComponent,
  ],
  templateUrl: './configuration-view.component.html',
  styleUrl: './configuration-view.component.css',
})
export class ConfigurationViewComponent {
  configurationTabs: Tab[] = [
    { label: 'Parish Info', icon: faChurch, url: '/configurations/general' },
    {
      label: 'Services',
      icon: faPersonPraying,
      url: '/configurations/services',
    },
    {
      label: 'Resources',
      icon: faBuildingShield,
      url: '/configurations/resources',
    },
    { label: 'Accounts', icon: faBank, url: '/configurations/accounts' },
    {
      label: 'Associstions',
      icon: faPeopleGroup,
      url: '/configurations/associations',
    },
  ];
  activeTabIndex = 0;

  constructor(private route: ActivatedRoute) {}

  ngOnInit() {
    this.route.paramMap.subscribe((params) => {
      const tab = params.get('section');
      const index = this.configurationTabs.findIndex((t) =>
        t.url?.endsWith(tab || '')
      );
      this.activeTabIndex = index !== -1 ? index : 0;
    });
  }
}
