import { CommonModule } from '@angular/common';
import { Component, Input } from '@angular/core';
import { AgGridModule } from 'ag-grid-angular';
import { ColDef } from 'ag-grid-community';
import { FamilyRecords } from '../../../services/api/family-records.service';
import { FamilyRecordSubscription } from '../../../services/interfaces/family-record.interface';
import { ActivatedRoute } from '@angular/router';

@Component({
  selector: 'app-subscriptions',
  imports: [CommonModule, AgGridModule],
  templateUrl: './subscriptions.component.html',
  styleUrl: './subscriptions.component.css',
})
export class SubscriptionsComponent {
  @Input() recordId!: string;

  allMonths = [
    'JANUARY',
    'FEBRUARY',
    'MARCH',
    'APRIL',
    'MAY',
    'JUNE',
    'JULY',
    'AUGUST',
    'SEPTEMBER',
    'OCTOBER',
    'NOVEMBER',
    'DECEMBER',
  ];

  columnDefs: ColDef[] = [];
  rowData: any = [];
  subscriptions: FamilyRecordSubscription[] = [];

  constructor(
    private route: ActivatedRoute,
    private familyRecordService: FamilyRecords
  ) {}

  ngOnInit() {
    this.familyRecordService
      .getFamilyRecordSubscriptions(this.recordId)
      .subscribe((response) => {
        this.subscriptions = response;
        let years = [...new Set(this.subscriptions.map((s) => s.year))];

        // Column Defs
        this.columnDefs = [
          { field: 'month', headerName: 'Month', pinned: 'left' },
          ...years.map((year) => ({
            field: String(year),
            headerName: String(year),
            valueFormatter: (params: any) => {
              if (!params.value || !params.value.paid) return '';
              return `Rs. ${params.value.amount.toFixed(0)}`;
            },
            cellClassRules: {
              'paid-cell': (params: any) => params.value?.paid === true,
              'unpaid-cell': (params: any) => !params.value?.paid,
            },
          })),
        ];

        this.rowData = this.transformToPivot(this.subscriptions);
      });
  }

  transformToPivot(breakdown: any[]) {
    const pivotMap: { [month: string]: any } = {};
    breakdown.forEach((entry) => {
      const { year, month, amount, currency } = entry;

      // Initialize month entry if not present
      if (!pivotMap[month]) pivotMap[month] = { month };

      // Add year data
      pivotMap[month][year] = { paid: true, amount, currency };
    });

    // Ensure all months are present
    return this.allMonths.map((m) => pivotMap[m] || { month: m });
  }
}
