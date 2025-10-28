import { Component } from '@angular/core';
import { SCREENS } from '../../../services/common/common.constants';
import { CommonModule } from '@angular/common';
import { CanCreateDirective } from '../../../directives/can-create.directive';
import { Ceremony } from '../../../services/interfaces/ceremonys.interface';
import {
  ColDef,
  GridApi,
  GridReadyEvent,
  RowSelectionOptions,
} from 'ag-grid-community';
import { Router } from '@angular/router';
import { CeremoniesService } from '../../../services/api/ceremonies.service';
import { AgGridModule } from 'ag-grid-angular';

@Component({
  selector: 'app-ceremony-list',
  standalone: true,
  imports: [CommonModule, CanCreateDirective, AgGridModule],
  templateUrl: './ceremony-list.component.html',
  styleUrl: './ceremony-list.component.css',
})
export class CeremonyListComponent {
  screen: string = SCREENS.CEREMONIES;

  rowData: Ceremony[] = [];
  private gridApi!: GridApi;
  paginationPageSize = 10;
  paginationPageSizeSelector: number[] | boolean = [5, 10, 20];
  defaultColDef: ColDef = {
    flex: 1,
    filter: true,
    floatingFilter: true,
  };
  rowSelection: RowSelectionOptions | 'single' | 'multiple' = {
    mode: 'multiRow',
    checkboxes: true,
    headerCheckbox: true,
    enableClickSelection: true,
  };

  columnDefs: ColDef<Ceremony>[] = [
    {
      headerName: 'Ceremony ID',
      field: 'id',
      cellRenderer: (params: any) =>
        `<a href="/ceremonies/${params.value}">${params.value}</a>`,
    },
    {
      headerName: 'Ceremony Type',
      field: 'type',
    },
    {
      headerName: 'Date',
      field: 'date',
    },
    {
      headerName: 'Priest Name',
      field: 'minister.priest',
    },
    {
      headerName: 'Name',
      field: 'name',
    },
    {
      headerName: 'Baptism Name',
      field: 'baptism_name',
    },
    {
      headerName: `Father's Name`,
      field: 'father',
    },
    {
      headerName: `Mother's Name`,
      field: 'mother',
    },
    {
      headerName: 'Parishioner',
      field: 'is_parishioner',
      cellRenderer: (params: any) => (params.value ? 'Yes' : 'No'),
      cellClass: 'text-center',
    },
  ];

  constructor(
    private ceremoniesService: CeremoniesService,
    private router: Router
  ) {}

  ngOnInit() {
    this.ceremoniesService.getCeremonies().subscribe((ceremonies) => {
      this.rowData = ceremonies;
    });
  }

  onGridReady(params: GridReadyEvent) {
    this.gridApi = params.api;
    setTimeout(() => {
      this.gridAutoSizeColumns();
    });
  }

  gridAutoSizeColumns() {
    const columns = this.gridApi
      .getAllGridColumns()
      .filter((column) => column?.getColDef()?.field !== 'name');
    const colIds = columns.map((col) => col.getColId());
    this.gridApi.autoSizeColumns(colIds);
  }

  onCreate() {
    this.router.navigate(['/ceremonies/create']);
  }
}
