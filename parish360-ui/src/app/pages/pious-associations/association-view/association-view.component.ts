import { Component } from '@angular/core';
import { SCREENS } from '../../../services/common/common.constants';
import { ActivatedRoute } from '@angular/router';
import { Association } from '../../../services/interfaces/associations.interface';
import { CommonModule } from '@angular/common';
import { FormBuilder, FormGroup, ReactiveFormsModule } from '@angular/forms';
import {
  Tab,
  TabsComponent,
} from '../../../components/common/tabs/tabs.component';
import { faPeopleGroup, faPeopleLine } from '@fortawesome/free-solid-svg-icons';
import { AssociationCommitteeComponent } from '../../../components/associations/association-committee/association-committee.component';
import { AssociationMembersComponent } from '../../../components/associations/association-members/association-members.component';
import { ParishYearService } from '../../../services/api/parish-year.service';
import { ParishYearAssociation } from '../../../services/interfaces/parish-year.interface';

@Component({
  selector: 'app-association-view',
  standalone: true,
  imports: [
    CommonModule,
    TabsComponent,
    AssociationCommitteeComponent,
    AssociationMembersComponent,
    ReactiveFormsModule,
  ],
  templateUrl: './association-view.component.html',
  styleUrl: './association-view.component.css',
})
export class AssociationViewComponent {
  screen: string = SCREENS.ASSOCIATIONS;
  parishYearId: string = '';
  pyAssociationId: string = '';
  section!: string;

  associationTabs: Tab[] = [];
  activeTab = 0;

  association!: Association;
  pyAssociation!: ParishYearAssociation;
  associationForm!: FormGroup;

  constructor(
    private fb: FormBuilder,
    private route: ActivatedRoute,
    private parishYearService: ParishYearService
  ) {}

  ngOnInit() {
    this.route.paramMap.subscribe((params) => {
      const section = params.get('section');
      this.parishYearId = params.get('parishYearId') || '';
      this.pyAssociationId = params.get('pyAssociationId') || '';

      this.associationTabs = [
        {
          label: 'Committee Members',
          icon: faPeopleLine,
          url: `associations/${this.parishYearId}/${this.pyAssociationId}/committee`,
        },
        {
          label: 'Associates',
          icon: faPeopleGroup,
          url: `associations/${this.parishYearId}/${this.pyAssociationId}/associates`,
        },
      ];

      const index = this.associationTabs.findIndex((t) =>
        t.url?.endsWith(section || '')
      );
      this.activeTab = index !== -1 ? index : 0;

      this.parishYearService
        .getParishYearAssociation(this.parishYearId, this.pyAssociationId)
        .subscribe({
          next: (pyAssociation) => {
            this.pyAssociation = pyAssociation;
            this.association = pyAssociation.association;
            this.associationForm = this.fb.group({
              name: [this.association.name || ''],
              description: [this.association?.description || ''],
              patron: [this.association?.patron || ''],
              founded_date: [this.association.founded_date || ''],
              active: [this.association.active || ''],
            });
            this.associationForm.disable();
          },
          error: () => {
            console.log('error fetching parish year association information!');
          },
        });
    });
    this.associationForm = this.fb.group({
      name: [this.association?.name || ''],
      description: [this.association?.description || ''],
      patron: [this.association?.patron || ''],
      founded_date: [this.association?.founded_date || ''],
      active: [this.association?.active || ''],
    });
  }
}
