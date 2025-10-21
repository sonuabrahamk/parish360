import { Injectable } from "@angular/core";
import { Observable } from "rxjs";
import { DASHBOARD } from "./api.constants";
import { ApiService } from "./api.service";
import { Summary } from "../interfaces/dashboard.interface";

@Injectable({ providedIn: 'root' })
export class DashboardService {
  constructor(private apiService: ApiService) {}

  getParishReport(): Observable<Summary> {
    return this.apiService.get<Summary>(DASHBOARD);
  }
}