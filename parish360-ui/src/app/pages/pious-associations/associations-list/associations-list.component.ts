import { Component } from '@angular/core';
import { SCREENS } from '../../../services/common/common.constants';
import { Association } from '../../../services/interfaces/associations.interface';
import { CommonModule } from '@angular/common';
import { AgGridModule } from 'ag-grid-angular';
import {
  GridApi,
  ColDef,
  GridReadyEvent,
} from 'ag-grid-community';
import { ParishYearService } from '../../../services/api/parish-year.service';
import { ParishYear } from '../../../services/interfaces/parish-year.interface';
import { FormsModule } from '@angular/forms';
import { ActivatedRoute, Router } from '@angular/router';
import { ToastService } from '../../../services/common/toast.service';

@Component({
  selector: 'app-associations-list',
  standalone: true,
  imports: [CommonModule, AgGridModule, FormsModule],
  templateUrl: './associations-list.component.html',
  styleUrl: './associations-list.component.css',
})
export class AssociationsListComponent {
  screen: string = SCREENS.ASSOCIATIONS;

  parishYearId!: string;
  parishYearList: ParishYear[] = [];
  activeParishYear!: ParishYear;
  selectedParishYearName: string = '';

  rowData: Association[] = [];
  private gridApi!: GridApi;
  paginationPageSize = 10;
  paginationPageSizeSelector: number[] | boolean = [5, 10, 20];
  defaultColDef: ColDef = {
    flex: 1,
    filter: true,
    floatingFilter: true,
  };

  columnDefs: ColDef<Association>[] = [
    {
      headerName: 'Association',
      field: 'name',
      cellRenderer: (params: any) =>
        `<a href="/associations/${this.activeParishYear.id}/${params.data.id}">${params.value}</a>`,
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
      headerName: 'Scope',
      field: 'scope',
    },
    {
      headerName: 'Founded Date',
      field: 'founded_date',
    },
    {
      headerName: 'Patron',
      field: 'patron',
    },
    {
      headerName: 'Active',
      field: 'active',
    },
  ];

  constructor(
    private router: Router,
    private route: ActivatedRoute,
    private parishYearService: ParishYearService,
    private toast: ToastService
  ) {}

  ngOnInit() {
    this.parishYearService.getParishYearList().subscribe({
      next: (parishYears) => {
        this.parishYearList = parishYears;
        this.parishYearId =
          this.route.snapshot.paramMap.get('parishYearId') || '';
        this.activeParishYear =
          this.parishYearList.find((py) => py.id === this.parishYearId) ||
          this.parishYearList[0];
        this.selectedParishYearName = this.activeParishYear.name;

        this.loadAssociationList(this.activeParishYear.id);
      },
      error: (error) => {
        this.toast.error('Could not fetch parish year list: ' + error.message);
      },
    });
  }

  loadAssociationList(parishYearId: string) {
    this.parishYearService.getParishYearAssociations(parishYearId).subscribe({
      next: (parishYearAssociations) => {
        const associations: Association[] = [];
        parishYearAssociations.map((pyAssociation) => {
          const association = pyAssociation.association;
          association.id = pyAssociation.id;
          associations.push(association);
        });
        this.rowData = associations;
      },
      error: (error) => {
        this.toast.error('Could not find association for active parish year: ' + error.message);
      },
    });
  }

  onGridReady(params: GridReadyEvent) {
    this.gridApi = params.api;
  }

  onParishYearUpdate() {
    this.activeParishYear =
      this.parishYearList.find(
        (py) => py.name === this.selectedParishYearName
      ) || this.activeParishYear;
    this.router.navigateByUrl(`associations/${this.activeParishYear.id}`);
    this.loadAssociationList(this.activeParishYear.id);
  }
}
