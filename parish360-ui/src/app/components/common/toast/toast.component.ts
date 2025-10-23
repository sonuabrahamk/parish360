import { CommonModule } from '@angular/common';
import { Component } from '@angular/core';
import {
  ToastMessage,
  ToastService,
} from '../../../services/common/toast.service';

@Component({
  selector: 'app-toast',
  standalone: true,
  imports: [CommonModule],
  templateUrl: './toast.component.html',
  styleUrl: './toast.component.css',
})
export class ToastComponent {
  message: ToastMessage | null = null;

  constructor(private toastService: ToastService) {}

  ngOnInit() {
    this.toastService.message$.subscribe((msg) => {
      this.message = msg;
    });
  }

  close() {
    this.toastService.hide();
  }
}
