import { CommonModule } from '@angular/common';
import { Component } from '@angular/core';
import { AgGridModule } from 'ag-grid-angular';
import { Member } from '../../../services/interfaces/member.interface';
import { GridApi, ColDef, GridReadyEvent } from 'ag-grid-community';
import { DashboardService } from '../../../services/api/dashboard.service';

@Component({
  selector: 'app-members-list',
  standalone: true,
  imports: [AgGridModule, CommonModule],
  templateUrl: './members-list.component.html',
  styleUrl: './members-list.component.css'
})
export class MembersListComponent {
  rowData: Member[] = [];
  private gridApi!: GridApi;
  paginationPageSize = 10;
  paginationPageSizeSelector: number[] | boolean = [5, 10, 20];
  defaultColDef: ColDef = {
    resizable: true,
    filter: true,
    floatingFilter: true,
  };
  columnDefs: ColDef[] = [
    {
      headerName: 'Name',
      valueGetter: params => `${params.data.first_name} ${params.data.last_name}`,
    },
    {
      headerName: 'Father',
      field: 'father',
    },
    {
      headerName: 'Mother',
      field: 'mother',
    },
    {
      headerName: 'Date of Birth',
      field: 'dob',
      flex: 1
    },
    {
      headerName: 'Relationship',
      field: 'relationship',
    },
    {
      headerName: 'Contact',
      field: 'contact',
    },
    {
      headerName: 'Email',
      field: 'email',
    },
    {
      headerName: 'Gender',
      field: 'gender',
    },
    {
      headerName: 'Qualification',
      field: 'qualification',
    },
    {
      headerName: 'Occupation',
      field: 'occupation',
    },
  ];

  constructor(private dashboardService: DashboardService) {}

  ngOnInit() {
    this.dashboardService.getAllMembers().subscribe({
      next: (members) => {
        this.rowData = members;
        this.gridAutoSizeColumns();
      },
      error: () => {
        console.log('error loading service intention bookings');
      },
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
      .filter((column) => column?.getColDef()?.field !== 'dob');
    const colIds = columns.map((col) => col.getColId());
    this.gridApi.autoSizeColumns(colIds);
  }
}
