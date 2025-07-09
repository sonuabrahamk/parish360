import { CommonModule } from '@angular/common';
import { Component, Input } from '@angular/core';
import { FontAwesomeModule } from '@fortawesome/angular-fontawesome';
import { faPlus } from '@fortawesome/free-solid-svg-icons';
import { AgGridModule } from 'ag-grid-angular';
import { ColDef, GridApi } from 'ag-grid-community';

@Component({
  selector: 'app-blessings-section',
  standalone: true,
  imports: [CommonModule, AgGridModule, FontAwesomeModule],
  templateUrl: './blessings-section.component.html',
  styleUrl: './blessings-section.component.css',
})
export class BlessingsSectionComponent {
  @Input() isEditMode: boolean = true
  faAdd = faPlus;

  rowData = [
    { id: 1, priest: 'Alice', date: '1990-05-10', reason: 'alice@example.com' },
    { id: 2, priest: 'Bob', date: '1990-05-10', reason: 'bob@example.com' },
  ];

  editingRowId: number | null = null;
  gridApi!: GridApi;

  columnDefs: ColDef[] = [
    {
      headerName: 'Priest',
      field: 'priest',
      editable: (params) => this.editingRowId === params.data.id,
      cellEditor: 'agTextCellEditor',
      cellEditorParams: {
        maxLength: 30,
      },
    },
    {
      headerName: 'Date',
      field: 'date',
      editable: (params) => this.editingRowId === params.data.id,
      cellEditor: 'agTextCellEditor', // default editor (text input)
      valueSetter: (params) => {
        const value = params.newValue?.trim();
        const isValidDate = /^\d{4}-\d{2}-\d{2}$/.test(value);
        if (!isValidDate) {
          alert('Date must be in YYYY-MM-DD format');
          return false;
        }
        params.data.dob = value;
        return true;
      },
    },
    {
      headerName: 'Reason',
      field: 'reason',
      flex: 1,
      editable: (params) => this.editingRowId === params.data.id,
      cellEditor: 'agTextCellEditor',
      cellEditorParams: {
        maxLength: 50,
      },
      valueSetter: (params) => {
        // Simple validation: must be a valid email
        const email = params.newValue;
        const valid = /^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(email);
        if (valid) {
          params.data.email = email;
          return true;
        }
        alert('Invalid email address');
        return false;
      },
    },
    ( this.isEditMode ?
    {
      headerName: 'Actions',
      field: undefined,
      cellRenderer: this.actionCellRenderer.bind(this),
      editable: false,
      suppressMovable: true,
      cellClass: 'flex justify-center'
    } : {}),
  ];

  onGridReady(params: any): void {
    this.gridApi = params.api;

    this.gridApi.addEventListener('cellClicked', (event: any) => {
      const id = event.data?.id;

      if (event.event.target.classList.contains('btn-edit')) {
        this.editingRowId = id;
        this.gridApi.startEditingCell({
          rowIndex: event.rowIndex,
          colKey: 'name',
        });
      }

      if (event.event.target.classList.contains('btn-save')) {
        this.gridApi.stopEditing();
        this.editingRowId = null;
        this.gridApi.refreshCells();
      }

      if (event.event.target.classList.contains('btn-delete')) {
        this.rowData = this.rowData.filter((row) => row.id !== id);
        this.gridApi.applyTransaction({ update: [...this.rowData] });
      }

      if (event.event.target.classList.contains('btn-cancel')) {
        this.rowData = this.rowData.filter((row) => row.id !== id);
        this.gridApi.applyTransaction({ update: [...this.rowData] });
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
              class="w-5 h-5">
            <path stroke-linecap="round" stroke-linejoin="round"
                  d="M17 16.5V19.5A1.5 1.5 0 0115.5 21h-7A1.5 1.5 0 017 19.5v-3A1.5 1.5 0 018.5 15h7a1.5 1.5 0 011.5 1.5zM17 8.25v-.75A2.25 2.25 0 0014.75 5.25H9.25A2.25 2.25 0 007 7.5v.75M19.5 8.25V19.5A2.25 2.25 0 0117.25 21H6.75A2.25 2.25 0 014.5 18.75V5.25A2.25 2.25 0 016.75 3h11.086a1.5 1.5 0 011.06.44l.664.664a1.5 1.5 0 01.44 1.06z" />
          </svg>
        </button>
        <!-- Cancel / X SVG Button -->
        <button class="btn-cancel btn-warning my-1">
          <svg xmlns="http://www.w3.org/2000/svg"
              fill="none" viewBox="0 0 24 24"
              stroke-width="1.5" stroke="currentColor"
              class="w-5 h-5">
            <path stroke-linecap="round" stroke-linejoin="round"
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
                class="w-5 h-5">
              <path stroke-linecap="round" stroke-linejoin="round"
                    d="M16.862 3.487a2.25 2.25 0 113.182 3.182L7.5 19.313l-4.5 1.125 
                      1.125-4.5L16.862 3.487z" />
            </svg>
          </button>
          <!-- Delete / Trash SVG Button -->
          <button class="btn-delete btn-danger my-1">
            <svg xmlns="http://www.w3.org/2000/svg"
                fill="none" viewBox="0 0 24 24"
                stroke-width="1.5" stroke="currentColor"
                class="w-5 h-5">
              <path stroke-linecap="round" stroke-linejoin="round"
                    d="M6 7.5V19.5A1.5 1.5 0 007.5 21h9a1.5 1.5 0 001.5-1.5V7.5M4.5 7.5h15M10.5 11.25v6M13.5 11.25v6M9 7.5V5.25A1.5 1.5 0 0110.5 3.75h3A1.5 1.5 0 0115 5.25V7.5" />
            </svg>
          </button>
      `;
    }
  }

  addRow() {
    const newId = this.rowData.length
      ? Math.max(...this.rowData.map((r) => r.id)) + 1
      : 1;
    this.rowData = [...this.rowData, {id: newId, priest: '', date: '', reason: '' }];
    this.gridApi.applyTransaction({ update: [...this.rowData] });
    this.editingRowId = newId;
  }

  onEdit() {

  }
}
