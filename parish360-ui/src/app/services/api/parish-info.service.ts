import { Observable } from 'rxjs';
import { ApiService } from './api.service';
import { Injectable } from '@angular/core';
import { Parish } from '../interfaces/parish.interface';
import { PARISH_INFO } from './api.constants';

@Injectable({ providedIn: 'root' })
export class ParishInfoService {
  constructor(private apiService: ApiService) {}

  getParishInfo(): Observable<Parish> {
    return this.apiService.get<Parish>(PARISH_INFO);
  }

  updateParishInfo(parish: Parish): Observable<Parish> {
    return this.apiService.patch<Parish>(PARISH_INFO, parish);
  }
}
