import { Component } from '@angular/core';
import { SummaryComponent } from "../../components/dashboard/summary/summary.component";
import { DashboardService } from '../../services/api/dashboard.service';
import { Summary } from '../../services/interfaces/dashboard.interface';
import { CommonModule } from '@angular/common';

@Component({
  selector: 'app-dashboard',
  imports: [CommonModule, SummaryComponent],
  templateUrl: './dashboard.component.html',
  styleUrl: './dashboard.component.css'
})
export class DashboardComponent {
  summary!: Summary;
  constructor(public dashboardService: DashboardService ) {}

  ngOnInit() {
    this.dashboardService.getParishReport().subscribe({
      next: (summary) => {
        this.summary = summary;
      },
      error: () => {
        console.log('error loading parish report');
      }
    });
  }

}
