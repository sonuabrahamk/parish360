import { CommonModule } from '@angular/common';
import { Component, EventEmitter, Input, Output } from '@angular/core';
import { AgGridAngular } from 'ag-grid-angular';
import {
  ColDef,
  GridApi,
  GridReadyEvent,
  RowSelectionOptions,
} from 'ag-grid-community';
import { AssociationService } from '../../../services/api/associations.service';
import { FamilyRecords } from '../../../services/api/family-records.service';

@Component({
  selector: 'app-associates-mapping',
  standalone: true,
  imports: [CommonModule, AgGridAngular],
  templateUrl: './associates-mapping.component.html',
  styleUrl: './associates-mapping.component.css',
})
export class AssociatesMappingComponent {
  @Input() associationType!: string;
  @Input() pyAssociationId!: string;
  @Output() associatesChange = new EventEmitter<any>();

  private gridApi!: GridApi;

  associates: string[] = [];

  selectAssociates!: any;
  selectedAssociates!: any;
  columnDefs: ColDef<any>[] = [];

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

  constructor(
    private associationService: AssociationService,
    private familyRecords: FamilyRecords
  ) {}

  ngOnInit() {
    switch (this.associationType) {
      case 'MEMBER':
        this.getMemberRecords();
        break;
      case 'FAMILY':
        this.getFamilyRecords();
        break;
      case 'ASSOCIATION':
        this.getAssociationRecords();
        break;
    }
  }

  onGridReady(params: GridReadyEvent) {
    this.gridApi = params.api;
  }

  onAssociationSelected() {
    this.selectedAssociates = this.gridApi.getSelectedRows();
    this.associatesChange.emit(this.selectedAssociates);
  }

  getMemberRecords() {
    this.familyRecords.getAllMembers().subscribe({
      next: (response) => {
        this.columnDefs = [
          {
            headerName: 'First Name',
            field: 'first_name',
          },
          {
            headerName: 'Last Name',
            field: 'last_name',
          },
          {
            headerName: 'Gender',
            field: 'gender',
          },
          {
            headerName: 'Contact',
            field: 'contact',
          },
        ];
        this.selectAssociates = response;
      },
      error: () => {
        console.log('error in fetching members of associations!');
      },
    });
  }

  getFamilyRecords() {
    this.familyRecords.getFamilyRecords().subscribe({
      next: (response) => {
        this.columnDefs = [
          {
            headerName: 'Family code',
            field: 'family_code',
          },
          {
            headerName: 'Family Name',
            field: 'family_name',
          },
          {
            headerName: 'Contact',
            field: 'contact',
          },
        ];
        this.selectAssociates = response;
      },
      error: () => {
        console.log('error in fetching members of associations!');
      },
    });
  }

  getAssociationRecords() {
    this.associationService
      .getAssociationAssociates(this.pyAssociationId)
      .subscribe({
        next: (response) => {
          this.columnDefs = [
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
              headerName: 'Active',
              field: 'active',
            },
          ];
          this.selectAssociates = response;
        },
        error: () => {
          console.log('error in fetching members of associations!');
        },
      });
  }
}
