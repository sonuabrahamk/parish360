import { CommonModule } from '@angular/common';
import { Component } from '@angular/core';
import { AgGridModule } from 'ag-grid-angular';
import { SCREENS } from '../../../services/common/common.constants';
import { User } from '../../../services/interfaces/permissions.interface';
import {
  GridApi,
  ColDef,
  RowSelectionOptions,
  GridReadyEvent,
} from 'ag-grid-community';
import { CanCreateDirective } from '../../../directives/can-create.directive';
import { CanDeleteDirective } from '../../../directives/can-delete.directive';
import { UserService } from '../../../services/api/user-api.service';
import { Router } from '@angular/router';

@Component({
  selector: 'app-users-list',
  standalone: true,
  imports: [CommonModule, AgGridModule, CanCreateDirective, CanDeleteDirective],
  templateUrl: './users-list.component.html',
  styleUrl: './users-list.component.css',
})
export class UsersListComponent {
  screen: string = SCREENS.USERS;

  users: User[] = [];
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

  columnDefs: ColDef<User>[] = [
    {
      headerName: 'User ID',
      field: 'id',
      cellRenderer: (params: any) =>
        `<a href="/users/view/${params.value}">${params.value}</a>`,
    },
    {
      headerName: 'First Name',
      field: 'first_name',
    },
    {
      headerName: 'Last Name',
      field: 'last_name',
    },
    {
      headerName: 'Email',
      field: 'email',
    },
    {
      headerName: 'Contact',
      field: 'contact',
    },
    {
      headerName: 'Status',
      field: 'status',
    },
  ];

  constructor(private userService: UserService, private router: Router) {}

  ngOnInit() {
    this.userService.getUsers().subscribe((users) => {
      this.users = users;
    });
  }

  onGridReady(params: GridReadyEvent) {
    this.gridApi = params.api;
  }

  onCreate() {
    this.router.navigate(['/users/create']);
  }

  onDelete() {
    console.log('Delete User !!');
  }
}
