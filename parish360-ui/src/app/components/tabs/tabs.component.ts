import { CommonModule } from '@angular/common';
import { Component, EventEmitter, Input, Output, TemplateRef } from '@angular/core';

export interface Tab {
  label: string;
  content?: TemplateRef<any>;
  data?: any;
}

@Component({
  selector: 'app-tabs',
  standalone: true,
  imports: [CommonModule],
  templateUrl: './tabs.component.html',
  styleUrl: './tabs.component.css'
})
export class TabsComponent {
  @Input() tabs: Tab[] = [];
  @Input() activeTabIndex = 0;
  @Output() tabSelected = new EventEmitter<any>();

  selectTab(index: number) {
    this.activeTabIndex = index;
    this.tabSelected.emit(this.tabs[index].data);
  }

}
