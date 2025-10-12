import { CommonModule } from '@angular/common';
import { Component, Input } from '@angular/core';
import { AgGridModule } from 'ag-grid-angular';
import { CanCreateDirective } from '../../../directives/can-create.directive';
import { CanEditDirective } from '../../../directives/can-edit.directive';
import { SCREENS } from '../../../services/common/common.constants';
import { Association } from '../../../services/interfaces/associations.interface';
import {
  GridApi,
  ColDef,
  RowSelectionOptions,
  GridReadyEvent,
} from 'ag-grid-community';
import { ParishYearService } from '../../../services/api/parish-year.service';

@Component({
  selector: 'app-parish-year-associations',
  standalone: true,
  imports: [CommonModule, AgGridModule, CanCreateDirective, CanEditDirective],
  templateUrl: './parish-year-associations.component.html',
  styleUrl: './parish-year-associations.component.css',
})
export class ParishYearAssociationsComponent {
  @Input() parishYearId: string = '';
  screen: string = SCREENS.CONFIGURATIONS;

  private gridApi!: GridApi;

  rowData: Association[] = [];
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
      headerName: 'Association Name',
      field: 'name',
    },
    {
      headerName: 'Description',
      field: 'description',
    },
    {
      headerName: 'Type',
      field: 'type',
    },
    {
      headerName: 'Patron',
      field: 'patron',
    },
    {
      headerName: 'Founded Date',
      field: 'founded_date',
    },
    {
      headerName: 'Status',
      field: 'active',
    },
  ];

  constructor(private parishYearService: ParishYearService) {}

  ngOnInit() {
    this.parishYearService
      .getParishYearAssociations(this.parishYearId)
      .subscribe({
        next: (response) => {
          const associations: Association[] = [];
          response.map((item) => {
            associations.push(item.association);
          });
          this.rowData = associations;
        },
        error: () => {
          console.log('error in fetching mapped associations!');
        },
      });
  }

  onGridReady(params: GridReadyEvent) {
    this.gridApi = params.api;
  }

  onCreate() {
    console.log('create new association mapping logic here');
  }

  onDelete() {
    console.log('remove association mapping logic here');
  }
}
