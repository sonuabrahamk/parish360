import { Component, Input, SimpleChanges, ViewChild } from '@angular/core';
import { CommonModule } from '@angular/common';
import {
  FormBuilder,
  FormGroup,
  ReactiveFormsModule,
  Validators,
} from '@angular/forms';
import { SectionFormComponent } from '../../common/section-form/section-form.component';
import { Member } from '../../../services/interfaces/member.interface';
import { FooterComponent } from '../footer/footer.component';
import { FooterEvent } from '../../../services/interfaces/permissions.interface';
import { SCREENS } from '../../../services/common/common.constants';
import { CanEditDirective } from '../../../directives/can-edit.directive';
import { ActivatedRoute, Router } from '@angular/router';
import { MemberService } from '../../../services/api/members.service';
import { ToastService } from '../../../services/common/toast.service';

@Component({
  selector: 'app-personal-section',
  standalone: true,
  imports: [
    CommonModule,
    ReactiveFormsModule,
    SectionFormComponent,
    FooterComponent,
    CanEditDirective,
  ],
  templateUrl: './personal-section.component.html',
  styleUrl: './personal-section.component.css',
})
export class PersonalSectionComponent {
  @Input() member: Member | null = null;
  @ViewChild(FooterComponent) footerComponent!: FooterComponent;

  memberForm!: FormGroup;
  screen: string = SCREENS.FAMILY_RECORD;
  isEditMode: boolean = false;
  memberId: string = '';
  recordId: string = '';

  constructor(
    private fb: FormBuilder,
    private route: ActivatedRoute,
    private router: Router,
    private memberService: MemberService,
    private toast: ToastService
  ) {}

  ngOnInit() {
    this.memberForm = this.fb.group({});
    this.memberId =
      this.route.snapshot.params['sectionId'] || this.member?.id || '';
    this.recordId = this.route.snapshot.params['id'] || '';
    this.loadMemberFormGroup();
  }

  ngOnChanges(changes: SimpleChanges): void {
    if (changes['member'] && this.memberForm) {
      this.loadMemberFormGroup();
    }
  }

  loadMemberFormGroup(): void {
    if (this.member) {
      this.memberForm = this.fb.group({
        first_name: [this.member.first_name || '', Validators.required],
        last_name: [this.member.last_name || '', Validators.required],
        dob: [this.member.dob || ''],
        father: [this.member.father || ''],
        mother: [this.member.mother || ''],
        contact: [this.member.contact || '', Validators.pattern('^[0-9]{10}$')],
        email: [this.member.email || '', Validators.email],
        gender: [this.member.gender || ''],
        relationship: [this.member.relationship || ''],
        qualification: [this.member.qualification || ''],
        occupation: [this.member.occupation || ''],
        birth_place: this.fb.group({
          city: [this.member.birth_place?.city || ''],
          state: [this.member.birth_place?.state || ''],
          country: [this.member.birth_place?.country || ''],
        }),
        god_father: this.fb.group({
          name: [this.member.god_father?.name || ''],
          parish: [this.member.god_father?.parish || ''],
          baptism_name: [this.member.god_father?.baptism_name || ''],
          contact: [this.member.god_father?.contact || ''],
        }),
        god_mother: this.fb.group({
          name: [this.member.god_mother?.name || ''],
          parish: [this.member.god_mother?.parish || ''],
          baptism_name: [this.member.god_mother?.baptism_name || ''],
          contact: [this.member.god_mother?.contact || ''],
        }),
      });
      this.memberForm.disable();
      this.isEditMode = false;
    }
    if (this.memberId === 'add' || this.member === null) {
      this.memberForm.enable();
      this.isEditMode = true;
    }
  }

  onModeUpdated(event: FooterEvent) {
    if (event.isEditMode) {
      this.isEditMode = true;
      this.memberForm.enable();
    }
    if (event.isCancelTriggered) {
      this.isEditMode = false;
      this.ngOnInit();
    }
    if (event.isSaveTriggered) {
      this.isEditMode = false;
      if (this.memberId === 'add' || this.member === null) {
        this.createMember();
      } else {
        this.updateMember();
      }
    }
    if (event.isDeleteTriggered) {
      this.deleteMember();
    }
  }

  createMember() {
    if (this.memberForm.invalid) {
      this.memberForm.markAllAsTouched();
      this.footerComponent.edit();
      return;
    }
    this.memberService
      .createMember(this.recordId, this.memberForm.getRawValue())
      .subscribe({
        next: (response) => {
          this.toast.success('Member created successfully!');
          this.router.navigateByUrl(`/family-records/${this.recordId}/members`);
        },
        error: (error) => {
          this.toast.error('Error creating member: ', error.message);
        },
      });
  }

  updateMember() {
    if (this.memberForm.invalid) {
      this.memberForm.markAllAsTouched();
      this.footerComponent.edit();
      return;
    }
    if (this.member === null) {
      this.toast.error('Member data is missing.');
      return;
    }
    this.memberService
      .updateMember(
        this.recordId,
        this.member.id,
        this.memberForm.getRawValue()
      )
      .subscribe({
        next: (response) => {
          this.toast.success('Member updated successfully!');
          this.router.navigate([
            'family-records',
            this.recordId,
            'members',
            response.id,
          ]);
        },
        error: (error) => {
          this.toast.error('Error updating member: ', error.message);
        },
      });
  }

  deleteMember() {
    this.toast
      .confirm('Are you sure you want to delete this member?')
      .then((confirmed) => {
        if (confirmed) {
          this.memberService
            .deleteMember(this.recordId, this.memberId)
            .subscribe({
              next: () => {
                this.toast.success('Member deleted successfully!');
                this.router.navigateByUrl(
                  `/family-records/${this.recordId}/members`
                );
              },
              error: (error) => {
                this.toast.error('Error deleting member: ', error.message);
              },
            });
        }
      });
  }

  // Utility getter for template
  isInvalid(controlName: string): boolean {
    const control = this.memberForm.get(controlName);
    return !!(control && control.invalid && (control.dirty || control.touched));
  }
}
