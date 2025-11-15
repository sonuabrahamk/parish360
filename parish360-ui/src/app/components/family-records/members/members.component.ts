import { ChangeDetectorRef, Component, Input, OnInit } from '@angular/core';
import { Tab, TabsComponent } from '../../common/tabs/tabs.component';
import { Member } from '../../../services/interfaces/member.interface';
import { PersonalSectionComponent } from '../personal-section/personal-section.component';
import { CommonModule } from '@angular/common';
import { faPlus } from '@fortawesome/free-solid-svg-icons';
import { LoaderComponent } from '../../common/loader/loader.component';
import { SacramentsSectionComponent } from '../sacraments-section/sacraments-section.component';
import { ReactiveFormsModule, FormsModule } from '@angular/forms';
import { AddDocumentComponent } from '../add-document/add-document.component';
import { DocumentViewComponent } from '../document-view/document-view.component';
import { CREATE, SCREENS } from '../../../services/common/common.constants';
import { MemberService } from '../../../services/api/members.service';
import { PermissionsService } from '../../../services/common/permissions.service';
import { CanCreateDirective } from '../../../directives/can-create.directive';
import { ActivatedRoute, Router } from '@angular/router';
import { MigrationSectionComponent } from '../migration-section/migration-section.component';
import { ToastService } from '../../../services/common/toast.service';

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
    MigrationSectionComponent,
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

  activeMemberId: string = '';
  sideTab: string[] = [];
  activeSideTab: number = 0;

  constructor(
    private router: Router,
    private route: ActivatedRoute,
    private memberService: MemberService,
    private cdr: ChangeDetectorRef,
    private permissionsService: PermissionsService,
    private toast: ToastService
  ) {}

  ngOnInit(): void {
    this.sideTab = [
      'Personel Details',
      'Sacrament Details',
      'Migration Details',
    ];

    this.route.paramMap.subscribe({
      next: (params) => {
        this.activeMemberId = params.get('sectionId') || '';
        this.memberService.getMembers(this.recordId).subscribe({
          next: (response) => {
            if ((
              response.length === 0 &&
              this.permissionsService.hasPermission(this.screen, CREATE)
            ) || this.activeMemberId === 'add' ){
              this.activeMember = {} as Member;
              this.membersTabs = [];
              this.sideTab = ['Personel Details'];
              return;
            }

            // Populate members and tabs
            this.members = response;
            this.membersTabs = this.members.map((member: Member): Tab => {
              return {
                label: member.first_name + ' ' + member.last_name,
                data: member,
                url:
                  '/family-records/' + this.recordId + '/members/' + member.id,
              };
            });

            // Add 'Add Member' tab if user has CREATE permission
            if (this.permissionsService.hasPermission(this.screen, CREATE)) {
              this.membersTabs.push({
                label: 'Add Member',
                data: null,
                icon: faPlus,
                url: '/family-records/' + this.recordId + '/members/add',
              });
            }

            // Set active member based on route parameter
            if (this.activeMemberId) {
              // Redirect if trying to access 'add' without permission
              if (
                this.activeMemberId === 'add' &&
                !this.permissionsService.hasPermission(this.screen, CREATE)
              ) {
                this.router.navigate(['../'], { relativeTo: this.route });
                return;
              }

              // Find index of member with the given memberId
              const index = this.members.findIndex(
                (member) => member.id === this.activeMemberId
              );
              if (index === -1) {
                this.router.navigate(['../'], { relativeTo: this.route });
                return;
              }
              this.activeMember = this.members[index];
              this.activeMemberTab = index;
            } else {
              this.activeMember = this.members[0];
              this.activeMemberTab = 0;
              this.cdr.detectChanges();
            }
          },
          error: (error) => {
            this.toast.error('Error fetching members: ', error.message);
          },
        });
      },
      error: (error) => {
        this.toast.error('Error loading member: ', error.message);
      },
    });
    this.cdr.detectChanges();
  }

  onTabChange(selectedMember: Member) {
    this.activeMember = selectedMember;
    this.activeSideTab = 0; // Reset to the first side tab
  }

  selectTab(index: number) {
    this.activeSideTab = index;
  }
}
