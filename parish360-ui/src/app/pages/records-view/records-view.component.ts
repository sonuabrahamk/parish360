import {
  AfterViewInit,
  ChangeDetectorRef,
  Component,
  TemplateRef,
  ViewChild,
} from '@angular/core';
import { CommonModule } from '@angular/common';
import { TabsComponent, Tab } from '../../components/common/tabs/tabs.component';
import { MembersComponent } from "../../components/family-records/members/members.component";
import { IconService } from '../../services/common/icon.service';
import { faHouse, faUsers, faPrayingHands, faCalendarCheck, faIndianRupee, faBox } from '@fortawesome/free-solid-svg-icons';
import { ActivatedRoute } from '@angular/router';
import { BlessingsSectionComponent } from "../../components/family-records/blessings-section/blessings-section.component";
import { FamilyInfoComponent } from "../../components/family-records/family-info/family-info.component";

@Component({
  selector: 'app-records-view',
  standalone: true,
  imports: [CommonModule, TabsComponent, MembersComponent, BlessingsSectionComponent, FamilyInfoComponent],
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
  recordId!: string;

  constructor(private cdr: ChangeDetectorRef, private iconService:IconService, private route: ActivatedRoute) {}

  ngOnInit(): void {
    this.route.paramMap.subscribe(params => {
      this.recordId = params.get('id')??'';
    });
  }

  ngAfterViewInit(): void {
    Promise.resolve().then(() => {
      this.familyTabs = [
        { label: 'Family Info', content: this.familyInfoTemplate, icon: faHouse },
        { label: 'Members', content: this.membersTemplate, icon: faUsers },
        { label: 'Blessings', content: this.blessingsTemplate, icon: faPrayingHands},
        { label: 'Subscriptions', content: this.subscriptionsTemplate, icon: faCalendarCheck },
        { label: 'Payments', content: this.paymentsTemplate, icon: faIndianRupee },
        { label: 'Miscellaneous', content: this.miscellaneousTemplate, icon: faBox },
      ];
      this.cdr.detectChanges();
    });
  }
}
