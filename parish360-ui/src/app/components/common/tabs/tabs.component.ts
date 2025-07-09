import { CommonModule } from '@angular/common';
import { Component, EventEmitter, Input, Output, TemplateRef } from '@angular/core';
import { FontAwesomeModule } from '@fortawesome/angular-fontawesome';
import { IconDefinition } from '@fortawesome/free-solid-svg-icons';
import { IconService } from '../../../services/common/icon.service';

export interface Tab {
  label: string;
  content?: TemplateRef<any>;
  data?: any;
  icon?: IconDefinition;
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

  constructor(private iconService: IconService) {}

  selectTab(index: number) {
    this.activeTabIndex = index;
    this.tabSelected.emit(this.tabs[index].data);
  }

}
