import { ChangeDetectorRef, Component, Input, OnInit } from '@angular/core';
import { Tab, TabsComponent } from '../../common/tabs/tabs.component';
import { Member, MembersResponse } from '../../../services/interfaces';
import { HttpClient } from '@angular/common/http';
import { PersonalSectionComponent } from '../personal-section/personal-section.component';
import { FooterComponent } from '../footer/footer.component';
import { CommonModule } from '@angular/common';
import { faPlus, faTimes } from '@fortawesome/free-solid-svg-icons';
import { LoaderService } from '../../../services/loader.service';
import { LoaderComponent } from '../../common/loader/loader.component';
import { SacramentsSectionComponent } from '../sacraments-section/sacraments-section.component';
import {
  FormGroup,
  FormBuilder,
  ReactiveFormsModule,
  FormsModule,
  FormArray,
} from '@angular/forms';

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
  ],
  templateUrl: './members.component.html',
  styleUrl: './members.component.css',
})
export class MembersComponent implements OnInit {
  @Input() recordId: string | null = null;

  members: Member[] = [];
  membersTabs: Tab[] = [];
  activeMember: Member | null = null;
  initialMemberValues: Member | null = null;
  memberForm!: FormGroup;

  isEditMode: boolean = false; // Edit mode for the component

  sideTab: string[] = [
    'Personel Details',
    'Sacrament Details',
    'Documents',
    'Migration Details',
  ];
  activeSideTab: number = 0;

  constructor(
    private cdr: ChangeDetectorRef,
    private http: HttpClient,
    private loader: LoaderService,
    private fb: FormBuilder
  ) {}

  ngOnInit(): void {
    this.loader.show();
    this.http
      .get<MembersResponse>('data/members.json')
      .subscribe((data: MembersResponse) => {
        this.members = data.members;
        this.membersTabs = this.members.map((member: Member): Tab => {
          return {
            label: member.first_name + ' ' + member.last_name,
            data: member,
          };
        });
        this.membersTabs = [
          ...this.membersTabs,
          { label: 'Add Member', data: null, icon: faPlus },
        ];
        this.activeMember = this.members[0]; // Set the first member as active by default
        this.initialMemberValues = this.members[0]; // Store initial values for the active member
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
        this.cdr.detectChanges();
      });
    this.loader.hide();
  }

  onTabChange(selectedMember: Member) {
    if (selectedMember === null) {
      this.isEditMode = true; // Set edit mode when "Add Member" tab is selected
      this.memberForm.reset();
      (this.memberForm.get('sacraments_details') as FormArray).clear();
    } else {
      this.memberForm.patchValue(selectedMember);
    }
    this.activeMember = selectedMember;
    this.initialMemberValues = selectedMember; // Store initial values for the active member
    this.activeSideTab = 0; // Reset to the first side tab
  }

  onModeUpdated(event: {
    isEditMode: boolean;
    isSaveTriggerred: boolean;
    isCancelTriggerred: boolean;
  }) {
    if (this.isEditMode) {
      this.ngOnInit(); // Reload members data when exiting edit mode
    }
    if (event.isSaveTriggerred) {
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
}
