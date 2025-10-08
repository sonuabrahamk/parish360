import { Component } from '@angular/core';
import { AgGridModule } from 'ag-grid-angular';
import { ColDef } from 'ag-grid-community';
import { CommonModule } from '@angular/common';
import { FamilyRecords } from '../../../services/api/family-records.service';
import { FamilyRecord } from '../../../services/interfaces/family-record.interface';
import { CanCreateDirective } from '../../../directives/can-create.directive';
import { SCREENS } from '../../../services/common/common.constants';

@Component({
  selector: 'app-records-list',
  standalone: true,
  imports: [AgGridModule, CommonModule, CanCreateDirective],
  templateUrl: './records-list.component.html',
  styleUrl: './records-list.component.css',
})
export class RecordsListComponent {
  constructor(private familyRecordService: FamilyRecords) {}

  screen: string = SCREENS.FAMILY_RECORD;
  paginationPageSize = 10;
  paginationPageSizeSelector: number[] | boolean = [5, 10, 20];
  defaultColDef: ColDef = {
    flex: 1,
    filter: true,
    floatingFilter: true,
  };

  columnDefs: ColDef[] = [
    {
      headerName: 'Record ID',
      field: 'id',
      cellRenderer: (params: any) =>
        `<a href="/family-records/${params.value}" >${params.value}</a>`,
    },
    { headerName: 'Book No', field: 'family_code' },
    { headerName: 'Family Name', field: 'family_name' },
    { headerName: 'Mobile', field: 'contact' },
  ];

  rowData: FamilyRecord[] | undefined;

  ngOnInit() {
    this.familyRecordService.getFamilyRecords().subscribe((records) => {
      console.log(records);
      this.rowData = records;
    });
  }
}
