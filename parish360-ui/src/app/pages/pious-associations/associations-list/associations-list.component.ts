import { Component } from '@angular/core';
import { SCREENS } from '../../../services/common/common.constants';
import { Association } from '../../../services/interfaces/associations.interface';
import { CommonModule } from '@angular/common';
import { AgGridModule } from 'ag-grid-angular';
import {
  GridApi,
  ColDef,
  RowSelectionOptions,
  GridReadyEvent,
} from 'ag-grid-community';
import { AssociationService } from '../../../services/api/associations.service';

@Component({
  selector: 'app-associations-list',
  standalone: true,
  imports: [CommonModule, AgGridModule],
  templateUrl: './associations-list.component.html',
  styleUrl: './associations-list.component.css',
})
export class AssociationsListComponent {
  screen: string = SCREENS.ASSOCIATIONS;

  rowData: Association[] = [];
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

  columnDefs: ColDef<Association>[] = [
    {
      headerName: 'Association',
      field: 'name',
      cellRenderer: (params: any) =>
        `<a href="/associations/view/${params.data.id}">${params.value}</a>`,
    },
    {
      headerName: 'Description',
      field: 'description',
    },
  ];

  constructor(private associationService: AssociationService) {}

  ngOnInit() {
    this.associationService
      .getAssociations()
      .subscribe((associations) => (this.rowData = associations));
  }

  onGridReady(params: GridReadyEvent) {
    this.gridApi = params.api;
  }
}
