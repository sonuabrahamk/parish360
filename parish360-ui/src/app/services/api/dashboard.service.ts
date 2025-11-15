import { Injectable } from "@angular/core";
import { Observable } from "rxjs";
import { BASE_URL, DASHBOARD } from "./api.constants";
import { ApiService } from "./api.service";
import { Summary } from "../interfaces/dashboard.interface";
import { Member } from "../interfaces/member.interface";

@Injectable({ providedIn: 'root' })
export class DashboardService {
  constructor(private apiService: ApiService) {}

  getParishReport(): Observable<Summary> {
    return this.apiService.get<Summary>(DASHBOARD);
  }

  getAllMembers(): Observable<Member[]> {
    return this.apiService.get<Member[]>(DASHBOARD + BASE_URL.MEMBERS_LIST);
  }
}