// src/app/toast.service.ts
import { Injectable } from '@angular/core';
import { BehaviorSubject } from 'rxjs';

export type ToastType = 'success' | 'error' | 'warning' | 'info';

export interface ToastMessage {
  text: string;
  type: ToastType;
}

@Injectable({
  providedIn: 'root',
})
export class ToastService {
  private messageSource = new BehaviorSubject<ToastMessage | null>(null);
  message$ = this.messageSource.asObservable();

  info(text: string, duration = 3000) {
    this.messageSource.next({ text, type: 'info' });

    // Auto-dismiss after duration
    setTimeout(() => {
      this.hide();
    }, duration);
  }

  error(text: string, duration = 3000) {
    this.messageSource.next({ text, type: 'error' });

    // Auto-dismiss after duration
    setTimeout(() => {
      this.hide();
    }, duration);
  }

  success(text: string, duration = 3000) {
    this.messageSource.next({ text, type: 'success' });

    // Auto-dismiss after duration
    setTimeout(() => {
      this.hide();
    }, duration);
  }

  warn(text: string, duration = 3000) {
    this.messageSource.next({ text, type: 'warning' });

    // Auto-dismiss after duration
    setTimeout(() => {
      this.hide();
    }, duration);
  }

  hide() {
    this.messageSource.next(null);
  }
}
