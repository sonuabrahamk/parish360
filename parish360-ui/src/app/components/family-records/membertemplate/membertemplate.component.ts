import { Component, Input } from '@angular/core';
import { CommonModule } from '@angular/common';

@Component({
  selector: 'app-membertemplate',
  standalone: true,
  imports: [CommonModule],
  templateUrl: './membertemplate.component.html',
  styleUrl: './membertemplate.component.css'
})
export class MembertemplateComponent {
  @Input() member: any | null = null;

  sideTab: string[] = ['Personel Details','Sacrament Details','Documents','Migration Details'];
  activeSideTab: number = 0;

  selectTab(index: number){
    this.activeSideTab = index;
  }
}
