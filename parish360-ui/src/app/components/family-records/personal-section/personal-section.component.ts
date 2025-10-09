import { Component, Input, SimpleChanges } from '@angular/core';
import { CommonModule } from '@angular/common';
import { FormBuilder, FormGroup, ReactiveFormsModule } from '@angular/forms';
import { SectionFormComponent } from '../../common/section-form/section-form.component';
import { Member } from '../../../services/interfaces/member.interface';
import { FooterComponent } from '../footer/footer.component';
import { FooterEvent } from '../../../services/interfaces/permissions.interface';
import { SCREENS } from '../../../services/common/common.constants';
import { CanEditDirective } from '../../../directives/can-edit.directive';
import { ActivatedRoute, Router } from '@angular/router';
import { MemberService } from '../../../services/api/members.service';

@Component({
  selector: 'app-personal-section',
  standalone: true,
  imports: [CommonModule, ReactiveFormsModule, SectionFormComponent, FooterComponent, CanEditDirective],
  templateUrl: './personal-section.component.html',
  styleUrl: './personal-section.component.css',
})
export class PersonalSectionComponent {
  @Input() member: Member | null = null;

  memberForm!: FormGroup;
  screen: string = SCREENS.FAMILY_RECORD;
  isEditMode: boolean = false;
  memberId: string = '';
  recordId: string = '';

  constructor(private fb: FormBuilder, private route: ActivatedRoute, private router:Router, private memberService: MemberService) {}

  ngOnInit() {
    this.memberForm = this.fb.group({});
    this.route.params.subscribe(params => {
      this.memberId = params['sectionId'] || '';
      this.recordId = params['id'] || '';
    });
    this.loadMemberFormGroup();
  }

  ngOnChanges(changes: SimpleChanges): void {
    if(changes['member'] && this.memberForm){
      this.loadMemberFormGroup();
    }
  }

  loadMemberFormGroup(): void {
    if (this.member) {
      this.memberForm = this.fb.group({
        first_name: [this.member.first_name || ''],
        last_name: [this.member.last_name || ''],
        dob: [this.member.dob || ''],
        father: [this.member.father || ''],
        mother: [this.member.mother || ''],
        contact: [this.member.contact || ''],
        email: [this.member.email || ''],
        gender: [this.member.gender || ''],
        relationship: [this.member.relationship || ''],
        qualification: [this.member.qualification || ''],
        occupation: [this.member.occupation || ''],
        birth_place: this.fb.group({
          city: [this.member.birth_place?.city || ''],
          state: [this.member.birth_place?.state || ''],
          country: [this.member.birth_place?.country || ''],
        }),
      });
      this.memberForm.disable();
      this.isEditMode = false;
    } 
    if(this.memberId === '' || this.memberId === 'add') {
      this.memberForm.enable();
      this.isEditMode = true;
    }
  }

  onModeUpdated(event: FooterEvent) {
    if(event.isEditMode) {
      this.isEditMode = true;
      this.memberForm.enable();
    }
    if(event.isCancelTriggered){
      this.isEditMode = false;
      this.ngOnInit();
    }
    if (event.isSaveTriggered) {
      this.isEditMode = false;
      if(this.memberId === '' || this.memberId === 'add'){
        this.createMember();
      } else {
        this.updateMember();
      }
    }
  }

  createMember() {
    this.memberService.createMember(this.recordId, this.memberForm.value).subscribe({
      next: (response) => {
        console.log('Member created successfully', response);
        this.router.navigate(['/family-records', this.recordId, 'members']);
      },
      error: (error) => {
        console.error('Error creating member', error);
      }
    });

    console.log('Create member', this.memberForm.value);
  }

  updateMember() {
    this.memberService.updateMember(this.recordId, this.memberId, this.memberForm.value).subscribe({
      next: (response) => {
        console.log('Member updated successfully', response);
        this.router.navigate(['/family-records', this.recordId, 'members']);
        this.ngOnInit();
      },
      error: (error) => {
        console.error('Error updating member', error);
        this.ngOnInit();
      }
    });
  }
}
