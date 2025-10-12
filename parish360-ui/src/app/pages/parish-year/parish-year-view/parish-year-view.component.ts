import { Component } from '@angular/core';
import {
  Tab,
  TabsComponent,
} from '../../../components/common/tabs/tabs.component';
import {
  faCalendarAlt,
  faPeopleGroup,
} from '@fortawesome/free-solid-svg-icons';
import { ActivatedRoute } from '@angular/router';
import { ParishYearAssociationsComponent } from '../../../components/parish-year/parish-year-associations/parish-year-associations.component';
import { ParishYearInfoComponent } from '../../../components/parish-year/parish-year-info/parish-year-info.component';
import { CommonModule } from '@angular/common';

@Component({
  selector: 'app-parish-year-view',
  standalone: true,
  imports: [
    TabsComponent,
    ParishYearInfoComponent,
    ParishYearAssociationsComponent,
    CommonModule,
  ],
  templateUrl: './parish-year-view.component.html',
  styleUrl: './parish-year-view.component.css',
})
export class ParishYearViewComponent {
  parishYearId: string = '';
  parishYearTabs: Tab[] = [];
  activeTabIndex = 0;

  constructor(private route: ActivatedRoute) {}

  ngOnInit() {
    this.route.paramMap.subscribe((params) => {
      this.parishYearId = params.get('parishYearId') || '';
      this.parishYearTabs = [
        {
          label: 'Parish Year Info',
          icon: faCalendarAlt,
          url: `/parish-year/${this.parishYearId}/general`,
        },
      ];
      if (this.parishYearId != 'new' && this.parishYearId != '') {
        this.parishYearTabs = [
          ...this.parishYearTabs,
          {
            label: 'Associations',
            icon: faPeopleGroup,
            url: `/parish-year/${this.parishYearId}/associations`,
          },
        ];
      }
      const tab = params.get('section');
      const index = this.parishYearTabs.findIndex((t) =>
        t.url?.endsWith(tab || '')
      );
      this.activeTabIndex = index !== -1 ? index : 0;
    });
  }
}
