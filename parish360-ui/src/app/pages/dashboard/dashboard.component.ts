import { Component } from '@angular/core';
import { SummaryComponent } from '../../components/dashboard/summary/summary.component';
import { DashboardService } from '../../services/api/dashboard.service';
import { Summary } from '../../services/interfaces/dashboard.interface';
import { CommonModule } from '@angular/common';
import { ToastService } from '../../services/common/toast.service';

@Component({
  selector: 'app-dashboard',
  imports: [CommonModule, SummaryComponent],
  templateUrl: './dashboard.component.html',
  styleUrl: './dashboard.component.css',
})
export class DashboardComponent {
  summary!: Summary;
  constructor(
    public dashboardService: DashboardService,
    private toastService: ToastService
  ) {}

  ngOnInit() {
    this.dashboardService.getParishReport().subscribe({
      next: (summary) => {
        this.summary = summary;
      },
      error: () => {
        this.toastService.error('error loading parish report');
      },
    });
  }
}
