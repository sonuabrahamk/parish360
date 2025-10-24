// src/app/toast.service.ts
import { Injectable } from '@angular/core';
import { BehaviorSubject, Observable, Subject } from 'rxjs';

export type ToastType = 'success' | 'error' | 'warning' | 'info' | 'confirm';

export interface ToastMessage {
  title: string;
  text: string;
  type: ToastType;
  resolver?: (value: boolean) => void;
}

@Injectable({
  providedIn: 'root',
})
export class ToastService {
  private messageSource = new BehaviorSubject<ToastMessage | null>(null);
  message$ = this.messageSource.asObservable();

  info(text: string, duration = 3000) {
    const title = 'Information';
    this.messageSource.next({ title, text, type: 'info' });

    // Auto-dismiss after duration
    setTimeout(() => {
      this.hide();
    }, duration);
  }

  error(text: string, duration = 3000) {
    const title = 'Error';
    this.messageSource.next({ title, text, type: 'error' });

    // Auto-dismiss after duration
    setTimeout(() => {
      this.hide();
    }, duration);
  }

  success(text: string, duration = 3000) {
    const title = 'Success';
    this.messageSource.next({ title, text, type: 'success' });

    // Auto-dismiss after duration
    setTimeout(() => {
      this.hide();
    }, duration);
  }

  warn(text: string, duration = 3000) {
    const title = 'Warning';
    this.messageSource.next({ title, text, type: 'warning' });

    // Auto-dismiss after duration
    setTimeout(() => {
      this.hide();
    }, duration);
  }

  hide() {
    this.messageSource.next(null);
  }

  confirm(text: string): Promise<boolean> {
    const title = 'Confirmation';
    return new Promise((resolve) => {
      this.messageSource.next({
        title,
        text,
        type: 'confirm',
        resolver: resolve,
      });
    });
  }

  resolve(value: boolean) {
    const message = this.messageSource.getValue();
    if (message?.resolver) {
      message.resolver(value);
      this.hide();
    }
  }
}
