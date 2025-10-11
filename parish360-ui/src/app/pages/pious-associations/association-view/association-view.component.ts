import { ChangeDetectorRef, Component, TemplateRef, ViewChild } from '@angular/core';
import { SCREENS } from '../../../services/common/common.constants';
import { ActivatedRoute } from '@angular/router';
import { AssociationService } from '../../../services/api/associations.service';
import {
  Association,
  Member,
} from '../../../services/interfaces/associations.interface';
import { CommonModule } from '@angular/common';
import {
  FormBuilder,
  FormGroup,
  FormsModule,
  ReactiveFormsModule,
} from '@angular/forms';
import { Tab, TabsComponent } from '../../../components/common/tabs/tabs.component';
import { faHouse, faUsers, faPrayingHands, faCalendarCheck, faIndianRupee, faBox } from '@fortawesome/free-solid-svg-icons';
import { FooterComponent } from "../../../components/family-records/footer/footer.component";
import { FooterEvent } from '../../../services/interfaces/permissions.interface';
import { AssociationCommitteeComponent } from "../../../components/associations/association-committee/association-committee.component";
import { AssociationMembersComponent } from "../../../components/associations/association-members/association-members.component";

@Component({
  selector: 'app-association-view',
  imports: [CommonModule, FormsModule, TabsComponent, ReactiveFormsModule, FooterComponent, AssociationCommitteeComponent, AssociationMembersComponent],
  templateUrl: './association-view.component.html',
  styleUrl: './association-view.component.css',
})
export class AssociationViewComponent {
  @ViewChild('associationInfo') associationInfo!: TemplateRef<any>;
  @ViewChild('associationCommitteeInfo') associationCommitteeInfo!: TemplateRef<any>;
  @ViewChild('associationMembersInfo') associationMembersInfo!: TemplateRef<any>;

  screen: string = SCREENS.ASSOCIATIONS;

  associationId!: string;
  parishYear: string | null = null;

  parishYearList: string[] = [
    'JAN2022-DEC2022',
    'JAN2025-DEC2025',
    'JAN2024-DEC2024',
    'JAN2023-DEC2023',
  ];
  associationTabs: Tab[] = [];

  association!: Association;
  associationForm!: FormGroup;

  constructor(
    private cdr: ChangeDetectorRef,
    private route: ActivatedRoute,
    private associationService: AssociationService,
    private fb: FormBuilder,
  ) {}

  ngOnInit() {
    this.associationId =
      this.route.snapshot.paramMap.get('associationId') || '';
    this.parishYear =
      this.route.snapshot.queryParamMap.get('parish_year') || '';

    // Get association details
    this.getAssociation();
    
    this.loadAssociationForm();
  }

  ngAfterViewInit(): void {
    Promise.resolve().then(() => {
      this.associationTabs = [
        {
          label: 'Association Info',
          content: this.associationInfo,
          icon: faHouse,
        },
        {
          label: 'Comittee Members',
          content: this.associationCommitteeInfo,
          icon: faPrayingHands,
        },
        {
          label: 'Members',
          content: this.associationMembersInfo,
          icon: faCalendarCheck,
        },
      ];
      this.cdr.detectChanges();
    });
  }

  getAssociation() {
    console.log('Update parish year: ' + this.parishYear);
  }

  loadAssociationForm() {
    this.associationForm = this.fb.group({
      name: [this.association?.name || ''],
      founded_on: [this.association?.founded_date || ''],
      status: [this.association?.active || ''],
      description: [this.association?.description || ''],
    })
  }

  onParishYearUpdate() {
    this.getAssociation();
  }

  onModeUpdate(event: FooterEvent){
    console.log(event);
  }
}
