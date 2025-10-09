import {
  ChangeDetectorRef,
  Component,
  Input,
  OnInit,
  ViewChild,
} from '@angular/core';
import { Tab, TabsComponent } from '../../common/tabs/tabs.component';
import { Member } from '../../../services/interfaces/member.interface';
import { PersonalSectionComponent } from '../personal-section/personal-section.component';
import { FooterComponent } from '../footer/footer.component';
import { CommonModule } from '@angular/common';
import { faPlus, faTimes } from '@fortawesome/free-solid-svg-icons';
import { LoaderService } from '../../../services/common/loader.service';
import { LoaderComponent } from '../../common/loader/loader.component';
import { SacramentsSectionComponent } from '../sacraments-section/sacraments-section.component';
import {
  FormGroup,
  FormBuilder,
  ReactiveFormsModule,
  FormsModule,
  FormArray,
} from '@angular/forms';
import { AddDocumentComponent } from '../add-document/add-document.component';
import { DocumentViewComponent } from '../document-view/document-view.component';
import { CREATE, SCREENS } from '../../../services/common/common.constants';
import { CanEditDirective } from '../../../directives/can-edit.directive';
import { MemberService } from '../../../services/api/members.service';
import { PermissionsService } from '../../../services/common/permissions.service';
import { CanCreateDirective } from '../../../directives/can-create.directive';
import { FooterEvent } from '../../../services/interfaces/permissions.interface';
import { ActivatedRoute, Router } from '@angular/router';

@Component({
  selector: 'app-members',
  standalone: true,
  imports: [
    CommonModule,
    TabsComponent,
    PersonalSectionComponent,
    LoaderComponent,
    ReactiveFormsModule,
    FormsModule,
    SacramentsSectionComponent,
    AddDocumentComponent,
    DocumentViewComponent,
    CanCreateDirective,
  ],
  templateUrl: './members.component.html',
  styleUrl: './members.component.css',
})
export class MembersComponent implements OnInit {
  @Input() recordId!: string;

  screen: string = SCREENS.FAMILY_RECORD;
  members: Member[] = [];
  membersTabs: Tab[] = [];
  activeMember: Member | null = null;
  activeMemberTab: number = 0;

  sideTab: string[] = [
    'Personel Details',
    'Sacrament Details',
    'Documents',
    'Migration Details',
  ];
  activeSideTab: number = 0;

  constructor(
    private route: ActivatedRoute,
    private memberService: MemberService,
    private cdr: ChangeDetectorRef,
    private permissionsService: PermissionsService
  ) {}

  ngOnInit(): void {
    this.memberService.getMembers(this.recordId).subscribe((response) => {
      this.members = response;
      this.membersTabs = this.members.map((member: Member): Tab => {
        return {
          label: member.first_name + ' ' + member.last_name,
          data: member,
          url: '/family-records/' + this.recordId + '/members/' + member.id,
        };
      });
      this.membersTabs = this.permissionsService.hasPermission(
        this.screen,
        CREATE
      )
        ? [
            ...this.membersTabs,
            { label: 'Add Member', data: null, icon: faPlus, url: '/family-records/' + this.recordId + '/members/add' },
          ]
        : [...this.membersTabs];

      this.route.params.subscribe((params) => {
        const memberId = params['sectionId'];
        if (memberId) {
          const index = this.members.findIndex(member => member.id === memberId);
          if (index !== -1) {
            this.activeMember = this.members[index];
            this.activeMemberTab = index;
            this.sideTab = ['Personel Details', 'Sacrament Details', 'Documents', 'Migration Details'];
          } else {
            this.activeMember = {} as Member;
            this.activeMemberTab = this.membersTabs.length - 1; // 'Add Member' tab
            this.sideTab = ['Personel Details'];
          }
        } else {
          this.activeMember = this.members[0];
          this.activeMemberTab = 0;
        }
      });

      this.cdr.detectChanges();
    });
  }

  onTabChange(selectedMember: Member) {
    this.activeMember = selectedMember;
    this.activeSideTab = 0; // Reset to the first side tab
  }

  selectTab(index: number) {
    this.activeSideTab = index;
  }
}
