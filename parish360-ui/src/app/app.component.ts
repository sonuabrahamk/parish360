import { Component } from '@angular/core';
import { RouterOutlet } from '@angular/router';
import { NavbarComponent } from "./panels/navbar/navbar.component";
import { SidebarComponent } from "./panels/sidebar/sidebar.component";
import { MainComponent } from "./panels/main/main.component";

@Component({
  selector: 'app-root',
  standalone: true,
  imports: [RouterOutlet, NavbarComponent, SidebarComponent, MainComponent],
  templateUrl: './app.component.html',
  styleUrl: './app.component.css'
})
export class AppComponent {
  title = 'parish360-ui';
}
