import { Component } from '@angular/core';
import { RouterOutlet } from '@angular/router';
import { NavbarComponent } from './components/panels/navbar/navbar.component';
import { SidebarComponent } from './components/panels/sidebar/sidebar.component';
import {
  ClientSideRowModelModule,
  CsvExportModule,
  Module,
} from 'ag-grid-community';
import { AuthService } from './authentication/auth.service';
import { CommonModule } from '@angular/common';
import { ToastComponent } from './components/common/toast/toast.component';

@Component({
  selector: 'app-root',
  standalone: true,
  imports: [
    RouterOutlet,
    NavbarComponent,
    SidebarComponent,
    CommonModule,
    ToastComponent,
  ],
  templateUrl: './app.component.html',
  styleUrl: './app.component.css',
})
export class AppComponent {
  title = 'parish360-ui';
  modules: Module[] = [ClientSideRowModelModule, CsvExportModule];

  constructor(public auth: AuthService) {}
}
