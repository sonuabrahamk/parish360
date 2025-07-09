import { CommonModule } from '@angular/common';
import { Component, computed } from '@angular/core';
import { LoaderService } from '../../../services/common/loader.service';

@Component({
  selector: 'app-loader',
  standalone: true,
  imports: [CommonModule],
  templateUrl: './loader.component.html',
  styleUrl: './loader.component.css'
})
export class LoaderComponent {
  constructor(private loaderService: LoaderService) {}
  readonly isLoading = computed(() => this.loaderService.isLoading());
}
