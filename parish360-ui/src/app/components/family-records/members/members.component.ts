import { ChangeDetectorRef, Component, Input, OnInit } from '@angular/core';
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

@Component({
  selector: 'app-members',
  standalone: true,
  imports: [
    CommonModule,
    TabsComponent,
    PersonalSectionComponent,
    FooterComponent,
    LoaderComponent,
    ReactiveFormsModule,
    FormsModule,
    SacramentsSectionComponent,
    AddDocumentComponent,
    DocumentViewComponent,
    CanEditDirective,
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
  memberForm!: FormGroup;
  documentArray!: FormArray;

  isEditMode: boolean = false; // Edit mode for the component

  sideTab: string[] = [
    'Personel Details',
    'Sacrament Details',
    'Documents',
    'Migration Details',
  ];
  activeSideTab: number = 0;

  constructor(
    private fb: FormBuilder,
    private loader: LoaderService,
    private memberService: MemberService,
    private cdr: ChangeDetectorRef,
    private permissionsService: PermissionsService
  ) {}

  ngOnInit(): void {
    this.loader.show();
    this.memberService.getMembers(this.recordId).subscribe((response) => {
      this.members = response.members;
      console.log(this.members);
      this.membersTabs = this.members.map((member: Member): Tab => {
        return {
          label: member.first_name + ' ' + member.last_name,
          data: member,
        };
      });
      this.membersTabs = this.permissionsService.hasPermission(
        this.screen,
        CREATE
      )
        ? [
            ...this.membersTabs,
            { label: 'Add Member', data: null, icon: faPlus },
          ]
        : [...this.membersTabs];
      this.activeMember = this.members[0]; // Set the first member as active by default

      this.loadMemberFormGroup(); // Loads active member data to form group

      this.cdr.detectChanges();
    });
    this.loader.hide();
  }

  onTabChange(selectedMember: Member) {
    if (selectedMember === null) {
      this.isEditMode = true; // Set edit mode when "Add Member" tab is selected
      this.memberForm.reset();
      (this.memberForm.get('sacraments_details') as FormArray).clear();
      this.documentArray?.clear();
    } else {
      this.memberForm.patchValue(selectedMember);
    }
    this.activeMember = selectedMember;
    this.activeSideTab = 0; // Reset to the first side tab
  }

  onModeUpdated(event: {
    isEditMode: boolean;
    isSaveTriggered: boolean;
    isCancelTriggered: boolean;
  }) {
    if (this.isEditMode) {
      this.ngOnInit(); // Reload members data when exiting edit mode
    }
    if (event.isSaveTriggered) {
      this.onSubmit();
    }
    this.isEditMode = event.isEditMode;
  }

  selectTab(index: number) {
    this.activeSideTab = index;
  }

  onSubmit() {
    console.log('Form submitted:', this.memberForm.value);
  }

  createSacramentGroup(sacrament: any = {}): FormGroup {
    return this.fb.group({
      type: [sacrament.type || ''],
      date: [sacrament.date || ''],
      parish: [sacrament.parish || ''],
      priest: [sacrament.priest || ''],
      place: [sacrament.place || ''],
      god_father: [sacrament.god_father || ''],
      god_mother: [sacrament.god_mother || ''],
      spouse: [sacrament.spouse || ''],
    });
  }

  createDocumentGroup(document: any = {}): FormGroup {
    return this.fb.group({
      id: [document.id || ''],
      name: [document.name || ''],
    });
  }

  loadMemberFormGroup(): void {
    if (this.activeMember) {
      this.memberForm = this.fb.group({
        first_name: [this.activeMember.first_name || ''],
        last_name: [this.activeMember.last_name || ''],
        dob: [this.activeMember.dob || ''],
        birth_place: [this.activeMember.birth_place || ''],
        father: [this.activeMember.father || ''],
        mother: [this.activeMember.mother || ''],
        address: [this.activeMember.address || ''],
        phone: [this.activeMember.phone || ''],
        email: [this.activeMember.email || ''],
        gender: [this.activeMember.gender || ''],
        age: [this.activeMember.age || ''],
        relationship: [this.activeMember.relationship || ''],
        qualification: [this.activeMember.qualification || ''],
        occupation: [this.activeMember.occupation || ''],
        sacraments_details: this.fb.array([]),
        documents: this.fb.array([]),
      });
      if (this.activeMember?.sacraments_details?.length) {
        this.activeMember.sacraments_details.forEach((sacrament: any) => {
          const sacramentsArray = this.memberForm.get(
            'sacraments_details'
          ) as FormArray;
          if (sacramentsArray) {
            sacramentsArray.push(this.createSacramentGroup(sacrament));
          }
        });
      }
      if (this.activeMember?.documents?.length) {
        this.activeMember.documents.forEach((document: any) => {
          this.documentArray = this.memberForm.get('documents') as FormArray;
          if (this.documentArray) {
            this.documentArray.push(this.createDocumentGroup(document));
          }
        });
      }
    }
  }
}
