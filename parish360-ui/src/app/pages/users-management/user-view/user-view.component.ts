import { CommonModule } from '@angular/common';
import { Component, ViewChild } from '@angular/core';
import {
  FormBuilder,
  FormGroup,
  ReactiveFormsModule,
  Validators,
} from '@angular/forms';
import {
  FooterEvent,
  Role,
  User,
} from '../../../services/interfaces/permissions.interface';
import {
  COUNTRY_DIAL_CODES,
  CURRENCIES,
  SCREENS,
  TIMEZONES,
} from '../../../services/common/common.constants';
import { UserService } from '../../../services/api/user-api.service';
import { ToastService } from '../../../services/common/toast.service';
import { FooterComponent } from '../../../components/family-records/footer/footer.component';
import { CanEditDirective } from '../../../directives/can-edit.directive';
import { ActivatedRoute, Router } from '@angular/router';
import { PermissionsService } from '../../../services/common/permissions.service';
import { TabsComponent } from '../../../components/common/tabs/tabs.component';
import { AgGridModule } from 'ag-grid-angular';
import {
  ColDef,
  FirstDataRenderedEvent,
  GridApi,
  GridReadyEvent,
} from 'ag-grid-community';

@Component({
  selector: 'app-user-view',
  standalone: true,
  imports: [
    CommonModule,
    ReactiveFormsModule,
    FooterComponent,
    CanEditDirective,
    TabsComponent,
    AgGridModule,
  ],
  templateUrl: './user-view.component.html',
  styleUrl: './user-view.component.css',
})
export class UserViewComponent {
  screen: string = SCREENS.USERS;
  @ViewChild(FooterComponent) footerComponent!: FooterComponent;

  timezones = TIMEZONES;
  currencies = CURRENCIES;
  countryCodes = COUNTRY_DIAL_CODES;

  isEditMode: boolean = false;
  userId: string = '';

  user!: User;
  userForm!: FormGroup;
  hover: boolean = false;
  profileImageUrl: string = 'img/profile.png';
  selectRoles: Role[] = [];
  selectedRoles: Role[] = [];
  initialRoles: Role[] = [];
  columnDefs: ColDef<Role>[] = [
    {
      headerName: 'Role Name',
      field: 'name',
      flex: 1,
    },
    {
      headerName: 'Description',
      field: 'description',
      flex: 1,
    },
  ];

  private gridApi!: GridApi;
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
  rowSelection: any = {
    mode: 'multiRow',
    checkboxes: true,
    headerCheckbox: true,
    enableClickSelection: true,
  };

  constructor(
    private route: ActivatedRoute,
    private router: Router,
    private fb: FormBuilder,
    private userService: UserService,
    private toast: ToastService,
    private permissionService: PermissionsService
  ) {}

  ngOnInit() {
    this.route.paramMap.subscribe({
      next: (param) => {
        this.userId = param.get('id') || '';
        if (this.userId === '') {
          this.router.navigate(['users']);
          return;
        }
        if (this.userId === 'create') {
          if (!this.permissionService.canCreate(this.screen)) {
            this.router.navigate(['users']);
            return;
          }
          this.loadUserForm();
          this.userForm.enable();
          this.isEditMode = true;
          return;
        }
        this.userService.getUser(this.userId).subscribe({
          next: (user) => {
            this.user = user;
            this.selectedRoles = user.roles;
            this.initialRoles = user.roles;
            this.loadUserForm();
            this.userForm.get('username')?.disable();
          },
          error: (error) => {
            this.toast.error('Error loading user: ' + error.message);
          },
        });
      },
    });
  }

  onGridReady(params: GridReadyEvent) {
    this.gridApi = params.api;
    if (this.selectRoles.length === 0) {
      this.userService.getAllRoles().subscribe({
        next: (roles) => {
          this.selectRoles = roles;
          const allowedRoleIds = roles.map((role) => role.id);
          this.initialRoles.filter((role) => !allowedRoleIds.includes(role.id));
        },
        error: (error) => {
          this.toast.error('Error loading roles: ' + error.message);
        },
      });
    }
  }

  onRoleSelected() {
    const rows = this.gridApi.getSelectedRows() as Role[];
    this.selectedRoles = [...this.initialRoles, ...rows];
  }

  onFirstDataRendered(event: FirstDataRenderedEvent) {
    if (this.selectedRoles.length > 0) {
      const selectedIds: string[] = this.selectedRoles.map((role) => role.id);
      event.api.forEachNodeAfterFilterAndSort((node) => {
        if (selectedIds.includes(node.data.id)) {
          node.setSelected(true);
        }
      });
    }
  }

  onModeUpdated(event: FooterEvent) {
    if (event.isEditMode) {
      this.userForm.enable();
      this.userForm.get('username')?.disable();
    }
    if (event.isCancelTriggered) {
      if (this.userId === 'create') {
        this.router.navigate(['users']);
      }
      this.userForm.disable();
    }
    if (event.isSaveTriggered) {
      this.onSave();
    }
    this.isEditMode = event.isEditMode;
  }

  onMouseEnterEvent() {
    this.permissionService.canEdit(this.screen)
      ? (this.hover = true)
      : (this.hover = false);
  }

  onFileSelected(event: Event) {
    const file = (event.target as HTMLInputElement).files?.[0];
    if (!file) return;

    const reader = new FileReader();
    reader.onload = () => {
      const arrayBuffer = reader.result as ArrayBuffer;
      const byteArray = Array.from(new Uint8Array(arrayBuffer)); // convert to byte[]

      this.uploadImage(byteArray);

      // Update UI preview
      this.profileImageUrl = URL.createObjectURL(file);
    };
    reader.readAsArrayBuffer(file);
  }

  uploadImage(byteArray: number[]) {
    this.toast.info('Backend update to be implemented!');
  }

  loadUserForm() {
    this.userForm = this.fb.group({
      username: [this.user?.username || '', Validators.required],
      first_name: [this.user?.first_name || '', Validators.required],
      last_name: [this.user?.last_name || '', Validators.required],
      email: [this.user?.email || '', Validators.email],
      password: [''],
      dial_code: [this.user?.dial_code || '+91'],
      contact: [this.user?.contact || '', Validators.pattern(/^[0-9]{10}$/)],
      is_active: [String(this.user?.is_active) || ''],
      timezone: [this.user?.timezone || 'Asia/Kolkata'],
      currency: [this.user?.currency || 'INR'],
      locale: ['en-IN'],
    });
    this.userForm.disable();
  }

  onSave() {
    if (
      (!this.permissionService.canCreate(this.screen) ||
        !this.permissionService.canEdit(this.screen)) &&
      this.userForm.invalid
    ) {
      this.userForm.markAllAsTouched();
      this.toast.warn('Please validate all fields before saving!');
      return;
    }
    this.toast
      .confirm('Are you sure you want to save the changes?')
      .then((confirmed) => {
        if (confirmed) {
          const userInfo = this.userForm.getRawValue();
          userInfo.roles = this.selectedRoles;
          console.log(userInfo);
          if (this.userId === 'create') {
            this.userService.createUser(userInfo).subscribe({
              next: (user) => {
                this.user = user;
                this.loadUserForm();
                this.toast.success('User has been successfully created!');
                return;
              },
              error: (error) => {
                this.footerComponent.edit();
                this.toast.error('Error creating user: ' + error.message);
              },
            });
          } else {
            this.userService.updateUser(this.userId, userInfo).subscribe({
              next: (user) => {
                this.user = user;
                this.loadUserForm();
                this.toast.success(
                  'User information has been updated successfully!'
                );
                return;
              },
              error: (error) => {
                this.toast.error('Error updating user: ' + error.message);
              },
            });
          }
        }
      });
  }

  // Utility getter for template
  isInvalid(controlName: string): boolean {
    const control = this.userForm.get(controlName);
    return !!(control && control.invalid && (control.dirty || control.touched));
  }
}
