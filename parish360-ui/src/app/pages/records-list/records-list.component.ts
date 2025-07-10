import { Component } from '@angular/core';
import { AgGridModule } from 'ag-grid-angular';
import { ColDef } from 'ag-grid-community';
import { HyperLink } from '../../services/common/table-components';
import { PermissionsService } from '../../services/common/permissions.service';
import { CommonModule } from '@angular/common';
import { CREATE, SCREENS } from '../../services/common/common.constants';

@Component({
  selector: 'app-records-list',
  standalone: true,
  imports: [AgGridModule, CommonModule],
  templateUrl: './records-list.component.html',
  styleUrl: './records-list.component.css',
})
export class RecordsListComponent {

  constructor(private permissions: PermissionsService){}

  canCreate (): boolean{
    return this.permissions.hasPermission(SCREENS.FAMILY_RECORD, CREATE);
  }

  columnDefs: ColDef[] = [
    { field: 'RecordID', cellRenderer: HyperLink },
    { field: 'Book No' },
    { field: 'Head of Family' },
    { field: 'Family Name' },
    { field: 'Parish' },
    { field: 'Unit' },
    { field: 'Mobile' },
  ];

  defaultColDef: ColDef = {
    flex: 1,
    filter: true,
    floatingFilter: true,
  };
  paginationPageSize = 10;
  paginationPageSizeSelector: number[] | boolean = [5, 10, 20];

  rowData = [
    {
      RecordID: '84301845-e528-4370-b5b6-117e0c72a7cb',
      'Book No': '222',
      'Head of Family': 'Abraham Thomas',
      'Family Name': 'Kuzhimattam',
      Parish: 'Velankani Matha Church',
      Unit: 'Holy Family',
      Mobile: '9844470069',
    },
  ];
}
