import { Observable } from 'rxjs';
import { PAYMENT_BY_ID, PAYMENTS } from './api.constants';
import { ApiService } from './api.service';
import { Injectable } from '@angular/core';
import { Payment } from '../interfaces/payments.interface';
import { Router } from '@angular/router';

@Injectable({ providedIn: 'root' })
export class PaymentService {
  constructor(private apiService: ApiService, private router: Router) {}

  getPayments(): Observable<Payment[]> {
    return this.apiService.get<Payment[]>(PAYMENTS);
  }

  getPayment(paymentId: string): Observable<Payment> {
    return this.apiService.get<Payment>(PAYMENT_BY_ID(paymentId));
  }

  createPayment(payment: any): Observable<Blob> {
    return this.apiService.post<Blob>(PAYMENTS, payment, {
      responseType: 'blob',
    });
  }

  updatePayment(paymentId: string, payment: any): Observable<Payment> {
    return this.apiService.patch<Payment>(PAYMENT_BY_ID(paymentId), payment);
  }

  deletePayment(paymentId: string): Observable<void> {
    return this.apiService.delete<void>(PAYMENT_BY_ID(paymentId));
  }

  getReceipt(paymentId: string): Observable<Blob> {
    return this.apiService.get<Blob>(`${PAYMENT_BY_ID(paymentId)}/receipt`, {
      responseType: 'blob',
    });
  }

  printReceipt(receiptBlob: Blob) {
    const url = URL.createObjectURL(receiptBlob);
    const iframe = document.createElement('iframe');
    iframe.style.display = 'none';
    iframe.src = url;
    document.body.appendChild(iframe);

    iframe.onload = () => {
      iframe.contentWindow?.focus();
      iframe.contentWindow?.print();

      window.addEventListener('afterprint', () => {
        alert();
        document.body.removeChild(iframe);
        URL.revokeObjectURL(url);
        this.router.navigate(['/payments']);
      });
    };
  }
}
