import { CommonModule } from '@angular/common';
import { Component } from '@angular/core';
import { CanCreateDirective } from '../../../directives/can-create.directive';
import { AgGridModule } from 'ag-grid-angular';
import { FontAwesomeModule } from '@fortawesome/angular-fontawesome';
import { SCREENS } from '../../../services/common/common.constants';
import { ParishYear } from '../../../services/interfaces/parish-year.interface';
import { ColDef } from 'ag-grid-community';
import { ParishYearService } from '../../../services/api/parish-year.service';

@Component({
  selector: 'app-parish-year-list',
  standalone: true,
  imports: [CommonModule, CanCreateDirective, AgGridModule, FontAwesomeModule],
  templateUrl: './parish-year-list.component.html',
  styleUrl: './parish-year-list.component.css',
})
export class ParishYearListComponent {
  screen: string = SCREENS.CONFIGURATIONS;
  paginationPageSize = 10;
  paginationPageSizeSelector: number[] | boolean = [5, 10, 20];
  defaultColDef: ColDef = {
    flex: 1,
    filter: true,
    floatingFilter: true,
  };

  columnDefs: ColDef[] = [
    {
      headerName: 'ParishYear ID',
      field: 'id',
      cellRenderer: (params: any) =>
        `<a href="/parish-year/${params.value}" >${params.value}</a>`,
    },
    { headerName: 'Name', field: 'name' },
    { headerName: 'Start Date', field: 'start_date' },
    { headerName: 'End Date', field: 'end_date' },
    { headerName: 'Status', field: 'status' },
    { headerName: 'Locked', field: 'locked' },
    { headerName: 'Comment', field: 'comment' },
  ];

  rowData: ParishYear[] | undefined;

  constructor(private parishYearService: ParishYearService) {}

  ngOnInit() {
    this.parishYearService.getParishYearList().subscribe((parishYearList) => {
      this.rowData = parishYearList;
    });
  }
}
