import { Component } from '@angular/core';
import { RouterOutlet } from '@angular/router';
import { NavbarComponent } from "./panels/navbar/navbar.component";
import { SidebarComponent } from "./panels/sidebar/sidebar.component";
import { ClientSideRowModelModule, CsvExportModule, Module } from 'ag-grid-community';

@Component({
  selector: 'app-root',
  standalone: true,
  imports: [RouterOutlet, NavbarComponent, SidebarComponent],
  templateUrl: './app.component.html',
  styleUrl: './app.component.css'
})
export class AppComponent {
  title = 'parish360-ui';
  modules: Module[] = [
        ClientSideRowModelModule,
        CsvExportModule
    ];
}
