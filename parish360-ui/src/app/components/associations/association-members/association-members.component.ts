import { CommonModule } from '@angular/common';
import { Component, Input } from '@angular/core';
import { AssociationService } from '../../../services/api/associations.service';
import {
  Association,
  Member,
} from '../../../services/interfaces/associations.interface';
import {
  GridApi,
  ColDef,
  RowSelectionOptions,
  GridReadyEvent,
} from 'ag-grid-community';
import { AgGridModule } from 'ag-grid-angular';
import { FamilyRecord } from '../../../services/interfaces/family-record.interface';
import { ParishYearAssociation } from '../../../services/interfaces/parish-year.interface';
import { ParishYearService } from '../../../services/api/parish-year.service';
import { CanEditDirective } from '../../../directives/can-edit.directive';
import { SCREENS } from '../../../services/common/common.constants';
import { AssociatesMappingComponent } from '../associates-mapping/associates-mapping.component';
import { ToastService } from '../../../services/common/toast.service';

@Component({
  selector: 'app-association-members',
  standalone: true,
  imports: [
    CommonModule,
    AgGridModule,
    CanEditDirective,
    AssociatesMappingComponent,
  ],
  templateUrl: './association-members.component.html',
  styleUrl: './association-members.component.css',
})
export class AssociationMembersComponent {
  @Input() pyAssociationId: string = '';
  @Input() parishYearId: string = '';
  screen: string = SCREENS.ASSOCIATIONS;
  isMappingEnabled: boolean = false;
  associationType!: string;

  members: Member[] = [];
  families: FamilyRecord[] = [];
  associations: Association[] = [];
  parishYearAssociation!: ParishYearAssociation;
  selectedAssociates!: any;

  private gridApi!: GridApi;
  rowData!: any;
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

  columnDefs: ColDef<any>[] = [];

  constructor(
    private associationService: AssociationService,
    private parishYearService: ParishYearService,
    private toast: ToastService
  ) {}

  ngOnInit() {
    this.isMappingEnabled = false;
    this.parishYearService
      .getParishYearAssociation(this.parishYearId, this.pyAssociationId)
      .subscribe({
        next: (pyAssociation) => {
          this.associationType = pyAssociation.association.type;
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
        },
        error: (error) => {
          this.toast.error(
            'Could not fetch parish year association information: ' +
              error.message
          );
        },
      });
  }

  onGridReady(params: GridReadyEvent) {
    this.gridApi = params.api;
  }

  getMemberRecords() {
    this.associationService
      .getAssociationAssociates(this.pyAssociationId)
      .subscribe({
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
              headerName: 'Date Of Birth',
              field: 'dob',
            },
            {
              headerName: 'Gender',
              field: 'gender',
            },
            {
              headerName: 'Contact',
              field: 'contact',
            },
            {
              headerName: 'Email',
              field: 'email',
            },
          ];
          this.rowData = response;
        },
        error: (error) => {
          this.toast.error(
            'Error in fetching members of associations: ' + error.message
          );
        },
      });
  }

  getFamilyRecords() {
    this.associationService
      .getAssociationAssociates(this.pyAssociationId)
      .subscribe({
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
          this.rowData = response;
        },
        error: (error) => {
          this.toast.error(
            'Error in fetching members of associations: ' + error.message
          );
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
          this.rowData = response;
        },
        error: (error) => {
          this.toast.error(
            'Error in fetching members of associations: ' + error.message
          );
        },
      });
  }

  onMapAssociationClick() {
    this.isMappingEnabled = true;
  }

  async onUnMapAssociationClick() {
    const associatesToRemove = this.gridApi.getSelectedRows();
    if (associatesToRemove.length <= 0) {
      this.toast.warn('No associations selected to remove!');
    }
    if (
      await this.toast.confirm(
        'Are you sure you want to un-map ' +
          associatesToRemove.length +
          ' associations from this parish year ?'
      )
    ) {
      const selectedIds = associatesToRemove.map((row) => row.id);
      this.associationService
        .unMapAssociates(this.pyAssociationId, selectedIds)
        .subscribe({
          next: () => {
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

  onCancel() {
    this.isMappingEnabled = false;
  }

  onMapAssociates() {
    const associateIds: string[] = [];
    this.selectedAssociates.map((associate: any) => {
      associateIds.push(associate.id);
    });
    this.associationService
      .mapAssociates(this.pyAssociationId, associateIds)
      .subscribe({
        next: () => {
          this.ngOnInit();
        },
        error: (error) => {
          this.toast.error('Error is mapping associates: ' + error.message);
        },
      });
  }

  onAssociatesMapped(associates: any) {
    this.selectedAssociates = associates;
  }
}
