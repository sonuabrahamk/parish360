import { Observable } from 'rxjs';
import {
  RESOURCE_BY_ID,
  RESOURCES,
} from './api.constants';
import { ApiService } from './api.service';
import { Injectable } from '@angular/core';
import { Resource } from '../interfaces/resources.interface';

@Injectable({ providedIn: 'root' })
export class ResourceService {
  constructor(private apiService: ApiService) {}

  getResourcesList(): Observable<Resource[]> {
    return this.apiService.get<Resource[]>(RESOURCES);
  }

  createResourceRecord(resource: Resource): Observable<Resource> {
    return this.apiService.post<Resource>(RESOURCES, resource);
  }

  updateResourceRecord(
    resourceId: string,
    resource: Resource
  ): Observable<Resource> {
    return this.apiService.patch<Resource>(
      RESOURCE_BY_ID(resourceId),
      resource
    );
  }

  deleteResourceRecord(resourceId: string): Observable<void> {
    return this.apiService.delete<void>(RESOURCES);
  }
}
