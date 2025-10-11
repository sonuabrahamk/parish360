import { Component } from '@angular/core';
import {
  Tab,
  TabsComponent,
} from '../../../components/common/tabs/tabs.component';
import { faHouse } from '@fortawesome/free-solid-svg-icons';
import { ActivatedRoute } from '@angular/router';
import { ParishInfoComponent } from '../../../components/configurations/parish-info/parish-info.component';
import { CommonModule } from '@angular/common';
import { ServicesComponent } from '../../../components/configurations/services/services.component';
import { ResourcesComponent } from '../../../components/configurations/resources/resources.component';
import { AssociationsComponent } from '../../../components/configurations/associations/associations.component';
import { AccountsComponent } from "../../../components/configurations/accounts/accounts.component";

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
    AccountsComponent
],
  templateUrl: './configuration-view.component.html',
  styleUrl: './configuration-view.component.css',
})
export class ConfigurationViewComponent {
  configurationTabs: Tab[] = [
    { label: 'Parish Info', icon: faHouse, url: '/configurations/general' },
    { label: 'Services', icon: faHouse, url: '/configurations/services' },
    { label: 'Resources', icon: faHouse, url: '/configurations/resources' },
    { label: 'Accounts', icon: faHouse, url: '/configurations/accounts' },
    {
      label: 'Associstions',
      icon: faHouse,
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
