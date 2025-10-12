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
import { ParishYearAssociationRequest } from '../../../services/interfaces/parish-year.interface';
import { AssociationService } from '../../../services/api/associations.service';

@Component({
  selector: 'app-parish-year-associations',
  standalone: true,
  imports: [CommonModule, AgGridModule, CanCreateDirective, CanEditDirective],
  templateUrl: './parish-year-associations.component.html',
  styleUrl: './parish-year-associations.component.css',
})
export class ParishYearAssociationsComponent {
  @Input() parishYearId: string = '';
  isMapAssociationsMode: boolean = false;
  screen: string = SCREENS.CONFIGURATIONS;

  private gridApi!: GridApi;
  private selectGridApi!: GridApi;

  selectionRowData: Association[] = [];
  selectedRowData: Association[] = [];
  rowData: Association[] = [];
  paginationPageSize = 10;
  paginationPageSizeSelector: number[] | boolean = [5, 10, 20];
  defaultColDef: ColDef = {
    flex: 1,
    filter: true,
    floatingFilter: true,
  };
  selectedColDef: ColDef = {
    flex: 1,
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

  selectionColumnDefs: ColDef<Association>[] = [
    {
      headerName: 'Association Name',
      field: 'name',
    },
    {
      headerName: 'Description',
      field: 'description',
      flex: 1,
    },
    {
      headerName: 'Type',
      field: 'type',
    },
  ];

  constructor(
    private parishYearService: ParishYearService,
    private associationService: AssociationService
  ) {}

  ngOnInit() {
    this.parishYearService
      .getParishYearAssociations(this.parishYearId)
      .subscribe({
        next: (response) => {
          const associations: Association[] = [];
          response.map((item) => {
            item.association.id = item.id;
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

  onSelectGridReady(params: GridReadyEvent) {
    this.selectGridApi = params.api;
  }

  onCancel() {
    console.log('Cancel triggered!');
    this.isMapAssociationsMode = false;
  }

  onMapAssociationClick() {
    this.associationService.getAssociations().subscribe({
      next: (associations) => {
        this.selectionRowData = associations;
        this.isMapAssociationsMode = true;
      },
      error: () => {
        console.log('Error loading associations to map');
      },
    });
  }

  onAssociationSelected(event: any) {
    this.selectedRowData = this.selectGridApi.getSelectedRows();
  }

  onSave() {
    const selectedAssociationIds = this.selectedRowData.map((row) => row.id);
    this.parishYearService
      .mapAssociationsToParishYear(this.parishYearId, {
        associations: selectedAssociationIds,
      })
      .subscribe({
        next: (ParishYearAssociations) => {
          this.isMapAssociationsMode = false;
          this.ngOnInit();
        },
        error: () => {
          console.log('error in mapping associations to parish year');
        },
      });
  }

  onDelete() {
    const associationsToRemove = this.gridApi.getSelectedRows();
    if (associationsToRemove.length <= 0) {
      console.log('no associations selected to remove!');
    }
    if (
      confirm(
        'Are you sure you want to un-map ' +
          associationsToRemove.length +
          ' associations from this parish year ?'
      )
    ) {
      const selectedIds = associationsToRemove.map((row) => row.id);
      this.parishYearService
        .unMapAssociationsFromParishYear(this.parishYearId, {
          associations: selectedIds,
        } as ParishYearAssociationRequest)
        .subscribe({
          next: () => {
            this.ngOnInit();
          },
          error: () => {
            console.log('error in remvoing association mapping');
          },
        });
    }
  }
}
