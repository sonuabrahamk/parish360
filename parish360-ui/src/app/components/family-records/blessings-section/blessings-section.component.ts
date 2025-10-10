import { CommonModule } from '@angular/common';
import { Component, Input } from '@angular/core';
import { FontAwesomeModule } from '@fortawesome/angular-fontawesome';
import { faPlus } from '@fortawesome/free-solid-svg-icons';
import { AgGridModule } from 'ag-grid-angular';
import { ColDef, GridApi } from 'ag-grid-community';
import { BlessingRecord } from '../../../services/interfaces/family-record.interface';
import { SCREENS } from '../../../services/common/common.constants';
import { CanCreateDirective } from '../../../directives/can-create.directive';
import { PermissionsService } from '../../../services/common/permissions.service';
import { BlessingService } from '../../../services/api/blessings.service';

@Component({
  selector: 'app-blessings-section',
  standalone: true,
  imports: [CommonModule, AgGridModule, FontAwesomeModule, CanCreateDirective],
  templateUrl: './blessings-section.component.html',
  styleUrl: './blessings-section.component.css',
})
export class BlessingsSectionComponent {
  @Input() recordId!: string;
  screen: string = SCREENS.FAMILY_RECORD;

  faAdd = faPlus;
  rowData!: BlessingRecord[];
  editingRowId: string | null = null;
  gridApi!: GridApi;

  columnDefs: ColDef<BlessingRecord>[] = [
    {
      headerName: 'Priest',
      field: 'priest',
      editable: (params) => this.isEditing(params.data),
      cellEditor: 'agTextCellEditor',
    },
    {
      headerName: 'Date',
      field: 'date',
      cellDataType: 'date',
      editable: (params) => this.isEditing(params.data),
      cellEditor: 'agDateCellEditor',
    },
    {
      headerName: 'Reason',
      field: 'reason',
      flex: 1,
      editable: (params) => this.isEditing(params.data),
      cellEditor: 'agTextCellEditor',
    },
  ];

  editorColumnDef = {
    headerName: 'Actions',
    field: undefined,
    cellRenderer: this.actionCellRenderer.bind(this),
    editable: false,
    suppressMovable: true,
    cellClass: 'flex justify-center',
  };

  onGridReady(params: any): void {
    this.gridApi = params.api;

    this.gridApi.addEventListener('cellClicked', (event: any) => {
      const id = event.data?.id;

      if (event.event.target.classList.contains('btn-edit')) {
        this.editingRowId = id;
        this.gridApi.refreshCells();
        this.gridApi.setFocusedCell(event.rowIndex, 'priest');
        this.gridApi.startEditingCell({
          rowIndex: event.rowIndex,
          colKey: 'priest',
        });
      }

      if (event.event.target.classList.contains('btn-save')) {
        if (event.data?.priest && event.data?.reason) {
          this.editingRowId = null;
          this.gridApi.stopEditing();
          this.gridApi.refreshCells();
          this.onSave(event.data);
        } else {
          // if no entry to new record added
          this.gridApi.setFocusedCell(event.rowIndex, 'priest');
          this.gridApi.startEditingCell({
            rowIndex: event.rowIndex,
            colKey: 'priest',
          });
        }
      }

      if (event.event.target.classList.contains('btn-delete')) {
        if (!this.permissionService.canDelete(this.screen)) {
          alert('You do not have permission to delete an entry!!');
        } else {
          confirm('Are you sure you want to delete this entry?')
            ? this.blessingsService
                .deleteBlessingsRecord(this.recordId, id)
                .subscribe(() => {
                  this.rowData = this.rowData.filter((row) => row.id !== id);
                  this.gridApi.applyTransaction({ update: [...this.rowData] });
                })
            : null;
        }
      }

      if (event.event.target.classList.contains('btn-cancel')) {
        if (!this.gridApi.getDisplayedRowAtIndex(0)?.data.priest) {
          this.rowData = this.rowData.filter((row) => row.id !== id);
          this.gridApi.applyTransaction({ update: [...this.rowData] });
        }
        this.editingRowId = null;
        this.gridApi.stopEditing();
        this.gridApi.refreshCells();
      }
    });
  }

  actionCellRenderer(params: any): string {
    const id = params.data?.id;
    if (this.editingRowId === id) {
      return `
        <!-- Save / Floppy SVG Button -->
        <button class="btn-save my-1">
          <svg xmlns="http://www.w3.org/2000/svg"
              fill="none" viewBox="0 0 24 24"
              stroke-width="1.5" stroke="currentColor"
              class="w-5 h-5 btn-save">
            <path class="btn-save" stroke-linecap="round" stroke-linejoin="round"
                  d="M17 16.5V19.5A1.5 1.5 0 0115.5 21h-7A1.5 1.5 0 017 19.5v-3A1.5 1.5 0 018.5 15h7a1.5 1.5 0 011.5 1.5zM17 8.25v-.75A2.25 2.25 0 0014.75 5.25H9.25A2.25 2.25 0 007 7.5v.75M19.5 8.25V19.5A2.25 2.25 0 0117.25 21H6.75A2.25 2.25 0 014.5 18.75V5.25A2.25 2.25 0 016.75 3h11.086a1.5 1.5 0 011.06.44l.664.664a1.5 1.5 0 01.44 1.06z" />
          </svg>
        </button>
        <!-- Cancel / X SVG Button -->
        <button class="btn-cancel btn-warning my-1">
          <svg xmlns="http://www.w3.org/2000/svg"
              fill="none" viewBox="0 0 24 24"
              stroke-width="1.5" stroke="currentColor"
              class="w-5 h-5 btn-cancel">
            <path class="btn-cancel" stroke-linecap="round" stroke-linejoin="round"
                  d="M6 18L18 6M6 6l12 12" />
          </svg>
        </button>
      `;
    } else {
      return `
          <!-- Edit / Pencil SVG Button -->
          <button class="btn-edit">
            <svg xmlns="http://www.w3.org/2000/svg"
                fill="none" viewBox="0 0 24 24"
                stroke-width="1.5" stroke="currentColor"
                class="w-5 h-5 btn-edit">
              <path class="btn-edit" stroke-linecap="round" stroke-linejoin="round"
                    d="M16.862 3.487a2.25 2.25 0 113.182 3.182L7.5 19.313l-4.5 1.125 
                      1.125-4.5L16.862 3.487z" />
            </svg>
          </button>
          <!-- Delete / Trash SVG Button -->
          <button *appCanDelete="screen" class="btn-delete btn-danger my-1">
            <svg xmlns="http://www.w3.org/2000/svg"
                fill="none" viewBox="0 0 24 24"
                stroke-width="1.5" stroke="currentColor"
                class="w-5 h-5 btn-delete">
              <path class="btn-delete" stroke-linecap="round" stroke-linejoin="round"
                    d="M6 7.5V19.5A1.5 1.5 0 007.5 21h9a1.5 1.5 0 001.5-1.5V7.5M4.5 7.5h15M10.5 11.25v6M13.5 11.25v6M9 7.5V5.25A1.5 1.5 0 0110.5 3.75h3A1.5 1.5 0 0115 5.25V7.5" />
            </svg>
          </button>
      `;
    }
  }

  constructor(
    private blessingsService: BlessingService,
    private permissionService: PermissionsService
  ) {}

  ngOnInit() {
    this.blessingsService
      .getBlessingsRecords(this.recordId)
      .subscribe((blessingsList) => {
        this.rowData = blessingsList.map((item) => ({
          ...item,
          date: new Date(item.date), // Convert ISO string to Date object
        }));
      });

    this.permissionService.canEdit(this.screen)
      ? (this.columnDefs = [...this.columnDefs, this.editorColumnDef])
      : null;
  }

  addRow() {
    if (this.gridApi.getDisplayedRowAtIndex(0)?.data.priest) {
      const newId = 'add';
      let newRowData = [
        {
          id: newId,
          priest: '',
          date: new Date(),
          reason: '',
        },
      ];
      this.gridApi.applyTransaction({ add: newRowData, addIndex: 0 });
      this.editingRowId = newId;
    }
    this.gridApi.setFocusedCell(0, 'priest');
    this.gridApi.startEditingCell({ rowIndex: 0, colKey: 'priest' });
    this.gridApi.refreshCells();
  }

  onEdit() {
    alert();
  }

  isEditing(row: any): boolean {
    return row.id === this.editingRowId;
  }

  getRowId = (params: { data: any }) => {
    return params.data.id;
  };

  onSave(row: any) {
    confirm('Are you sure you want to save the changes?') &&
      (row.id === 'add'
        ? this.blessingsService
            .createBlessingsRecord(this.recordId, {
              priest: row.priest,
              date: row.date,
              reason: row.reason,
            } as BlessingRecord)
            .subscribe((newRecord) => {
              this.rowData = this.rowData.map((r) =>
                r.id === this.editingRowId ? newRecord : r
              );
              this.gridApi.applyTransaction({ update: [...this.rowData] });
            })
        : this.blessingsService
            .updateBlessingsRecord(this.recordId, row.id, {
              priest: row.priest,
              date: row.date,
              reason: row.reason,
            } as BlessingRecord)
            .subscribe((updatedRecord) => {
              this.rowData = this.rowData.map((r) =>
                r.id === row.id ? updatedRecord : r
              );
              this.gridApi.applyTransaction({ update: [...this.rowData] });
            }));
  }
}
