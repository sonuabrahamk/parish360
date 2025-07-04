import {
  AfterViewInit,
  ChangeDetectorRef,
  Component,
  TemplateRef,
  ViewChild,
} from '@angular/core';
import { CommonModule } from '@angular/common';
import { TabsComponent, Tab } from '../../components/tabs/tabs.component';
import { MembersComponent } from "../../components/family-records/members/members.component";

@Component({
  selector: 'app-records-view',
  standalone: true,
  imports: [CommonModule, TabsComponent, MembersComponent],
  templateUrl: './records-view.component.html',
  styleUrl: './records-view.component.css',
})
export class RecordsViewComponent implements AfterViewInit {
  @ViewChild('familyInfoTemplate') familyInfoTemplate!: TemplateRef<any>;
  @ViewChild('membersTemplate') membersTemplate!: TemplateRef<any>;
  @ViewChild('blessingsTemplate') blessingsTemplate!: TemplateRef<any>;
  @ViewChild('subscriptionsTemplate') subscriptionsTemplate!: TemplateRef<any>;
  @ViewChild('paymentsTemplate') paymentsTemplate!: TemplateRef<any>;
  @ViewChild('miscellaneousTemplate') miscellaneousTemplate!: TemplateRef<any>;

  familyTabs: Tab[] = [];

  constructor(private cdr: ChangeDetectorRef) {}

  ngAfterViewInit(): void {
    Promise.resolve().then(() => {
      this.familyTabs = [
        { label: 'Family Info', content: this.familyInfoTemplate },
        { label: 'Members', content: this.membersTemplate },
        { label: 'Blessings', content: this.blessingsTemplate },
        { label: 'Subscriptions', content: this.subscriptionsTemplate },
        { label: 'Payments', content: this.paymentsTemplate },
        { label: 'Miscellaneous', content: this.miscellaneousTemplate },
      ];
      this.cdr.detectChanges();
    });
  }
}
