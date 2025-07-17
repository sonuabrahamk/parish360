import { CommonModule } from '@angular/common';
import { Component, Input } from '@angular/core';
import { AgGridAngular } from 'ag-grid-angular';
import { ColDef } from 'ag-grid-community';
import { FamilyRecords } from '../../../services/api/family-records.service';
import { FamilyRecordSubscription } from '../../../services/interfaces/family-record.interface';
import { ActivatedRoute } from '@angular/router';

@Component({
  selector: 'app-subscriptions',
  imports: [CommonModule, AgGridAngular],
  templateUrl: './subscriptions.component.html',
  styleUrl: './subscriptions.component.css',
})
export class SubscriptionsComponent {
  @Input() recordId!: string;

  allMonths = [
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December',
  ];

  columnDefs: ColDef[] = [];
  rowData: any = [];
  subscriptions: FamilyRecordSubscription[] = [];

  constructor(
    private route: ActivatedRoute,
    private familyRecordService: FamilyRecords
  ) {}

  ngOnInit() {
    this.route.paramMap.subscribe((params) => {
      this.recordId = params.get('id') ?? '';
    });

    this.familyRecordService
      .getFamilyRecordSubscriptions(this.recordId)
      .subscribe((response) => {
        this.subscriptions = response.subscriptions;
        let years = [...new Set(this.subscriptions.map((s) => s.year))];

        // Column Defs
        this.columnDefs = [
          { field: 'month', headerName: 'Month', pinned: 'left' },
          ...years.map((year) => ({
            field: String(year),
            headerName: String(year),
            cellRenderer: (params: any) => {
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
      const { year, month, paid, amount } = entry;
      if (!pivotMap[month]) pivotMap[month] = { month };
      pivotMap[month][year] = { paid, amount };
    });

    // Ensure all months are present
    return this.allMonths.map((m) => pivotMap[m] || { month: m });
  }
}
