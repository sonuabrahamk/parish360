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
import { ToastService } from '../../../services/common/toast.service';

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
    private associationService: AssociationService,
    private toast: ToastService
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
        error: (error) => {
          this.toast.error(
            'Error in fetching mapped associations: ' + error.message
          );
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
    this.isMapAssociationsMode = false;
  }

  onMapAssociationClick() {
    this.associationService.getAssociations().subscribe({
      next: (associations) => {
        this.selectionRowData = associations;
        this.isMapAssociationsMode = true;
      },
      error: (error) => {
        this.toast.error('Error loading associations to map: ' + error.message);
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
          this.toast.success(
            'Associations mapped successfully to parish year!'
          );
          this.ngOnInit();
        },
        error: (error) => {
          this.toast.error(
            'Error in mapping associations to parish year: ' + error.message
          );
        },
      });
  }

  async onDelete() {
    const associationsToRemove = this.gridApi.getSelectedRows();
    if (associationsToRemove.length <= 0) {
      this.toast.warn('No associations selected to remove!');
    }
    if (
      await this.toast.confirm(
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
            this.toast.success('Selected associations un-mapped successfully!');
            this.ngOnInit();
          },
          error: (error) => {
            this.toast.error(
              'Error in remvoing association mapping: ' + error.message
            );
          },
        });
    }
  }
}
