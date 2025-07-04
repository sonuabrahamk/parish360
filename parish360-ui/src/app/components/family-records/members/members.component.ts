import {
  ChangeDetectorRef,
  Component,
  OnInit,
  TemplateRef,
  ViewChild,
} from '@angular/core';
import { Tab, TabsComponent } from '../../tabs/tabs.component';
import { member, MembersResponse } from '../../../services/interfaces';
import { MembertemplateComponent } from "../membertemplate/membertemplate.component";
import { HttpClient } from '@angular/common/http';

@Component({
  selector: 'app-members',
  standalone: true,
  imports: [TabsComponent, MembertemplateComponent],
  templateUrl: './members.component.html',
  styleUrl: './members.component.css',
})
export class MembersComponent implements OnInit {
  @ViewChild('memberTemplate') memberTemplate!: TemplateRef<any>;

  members: member[] = [];
  membersTabs: Tab[] = [];
  activeMember: member | null = null;

  constructor(private cdr: ChangeDetectorRef, private http: HttpClient) {}

  ngOnInit(): void {
    this.http.get<MembersResponse>('data/members.json').subscribe((data: MembersResponse) => {
      this.members = data.members;
      this.membersTabs = this.members.map((member: member): Tab => {
        return { label: member.first_name + ' ' + member.last_name, content: this.memberTemplate, data: member };
      });
      this.activeMember = this.members[0]; // Set the first member as active by default
      this.cdr.detectChanges();
    });
  }

  onTabChange(selectedMember: member) {
    this.activeMember = selectedMember;
  }
}
