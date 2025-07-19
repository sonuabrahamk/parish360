import { Observable } from 'rxjs';
import { CEREMONIES, EXTENSION } from './api.constants';
import { ApiService } from './api.service';
import { Injectable } from '@angular/core';
import { Ceremony } from '../interfaces/ceremonys.interface';

@Injectable({ providedIn: 'root' })
export class CeremoniesService {
  constructor(private apiService: ApiService) {}

  getCeremonies(): Observable<Ceremony[]> {
    return this.apiService.get<Ceremony[]>(CEREMONIES + EXTENSION);
  }
}
