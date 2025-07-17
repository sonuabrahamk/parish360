import { CommonModule } from '@angular/common';
import { Component, Input } from '@angular/core';
import { AgGridAngular } from 'ag-grid-angular';
import { ColDef } from 'ag-grid-community';
import { FamilyRecords } from '../../../services/api/family-records.service';

@Component({
  selector: 'app-payments',
  imports: [CommonModule, AgGridAngular],
  templateUrl: './payments.component.html',
  styleUrl: './payments.component.css',
})
export class PaymentsComponent {
  @Input() recordId!: string;

  rowData: any = [];
  columnDefs: ColDef[] = [
    {
      headerName: 'Receipt No',
      field: 'receipt_no',
      flex: 1,
    },
    {
      headerName: 'Date',
      field: 'date',
      flex: 1,
    },
    {
      headerName: 'Payment By',
      field: 'payment_by',
      flex: 1,
    },
    {
      headerName: 'Reason',
      field: 'reason',
      flex: 1,
    },
    {
      headerName: 'Amount',
      field: 'amount',
      flex: 1,
    },
  ];

  constructor(private familyRecordsService: FamilyRecords) {}

  ngOnInit() {
    this.familyRecordsService
      .getPaymentsList(this.recordId)
      .subscribe((paymentsList) => {
        this.rowData = paymentsList;
      });
  }
}
