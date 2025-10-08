import { Observable } from 'rxjs';
import { EXTENSION, PAYMENT_BY_ID, PAYMENTS } from './api.constants';
import { ApiService } from './api.service';
import { Injectable } from '@angular/core';
import { Payment } from '../interfaces/payments.interface';

@Injectable({ providedIn: 'root' })
export class PaymentService {
  constructor(private apiService: ApiService) {}

  getPayments(): Observable<Payment[]> {
    return this.apiService.get<Payment[]>(PAYMENTS);
  }

  getPayment(paymentId: string): Observable<Payment> {
    return this.apiService.get<Payment>(PAYMENT_BY_ID(paymentId));
  }
}
