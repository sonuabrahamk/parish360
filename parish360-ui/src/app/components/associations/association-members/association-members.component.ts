import { CommonModule } from '@angular/common';
import { Component, Input } from '@angular/core';
import { AssociationService } from '../../../services/api/associations.service';
import { Member } from '../../../services/interfaces/associations.interface';
import {
  GridApi,
  ColDef,
  RowSelectionOptions,
  GridReadyEvent,
} from 'ag-grid-community';
import { AgGridModule } from 'ag-grid-angular';

@Component({
  selector: 'app-association-members',
  standalone: true,
  imports: [CommonModule, AgGridModule],
  templateUrl: './association-members.component.html',
  styleUrl: './association-members.component.css',
})
export class AssociationMembersComponent {
  @Input() parishYear: string = '';
  @Input() associationId: string = '';

  members: Member[] = [];

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

  columnDefs: ColDef<Member>[] = [
    {
      headerName: 'Book No',
      field: 'book_no',
    },
    {
      headerName: 'Name',
      field: 'name',
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
      headerName: 'Joined On',
      field: 'joined',
    },
    {
      headerName: 'Status',
      field: 'status',
    },
  ];

  constructor(private associationService: AssociationService) {}

  ngOnInit() {
    console.log('initialised!')
  }

  onGridReady(params: GridReadyEvent) {
    this.gridApi = params.api;
  }
}
