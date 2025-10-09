import { CommonModule } from '@angular/common';
import { Component, EventEmitter, Input, Output, TemplateRef } from '@angular/core';
import { FontAwesomeModule } from '@fortawesome/angular-fontawesome';
import { IconDefinition } from '@fortawesome/free-solid-svg-icons';
import { IconService } from '../../../services/common/icon.service';
import { ActivatedRoute, Router } from '@angular/router';

export interface Tab {
  label: string;
  content?: TemplateRef<any>;
  data?: any;
  icon?: IconDefinition;
  url?: string;
}

@Component({
  selector: 'app-tabs',
  standalone: true,
  imports: [CommonModule, FontAwesomeModule],
  templateUrl: './tabs.component.html',
  styleUrl: './tabs.component.css'
})
export class TabsComponent {
  @Input() tabs: Tab[] = [];
  @Input() activeTabIndex = 0;
  @Output() tabSelected = new EventEmitter<any>();

  constructor(private router: Router) {}

  selectTab(index: number) {
    this.activeTabIndex = index;
    this.tabSelected.emit(this.tabs[index].data);
    if (this.tabs[index].url) {
      this.router.navigateByUrl(this.tabs[index].url);
    }
  }

}
