import { Observable } from 'rxjs';
import { BASE_URL } from './api.constants';
import { ApiService } from './api.service';
import { Injectable } from '@angular/core';
import { MigrationDetails } from '../interfaces/member.interface';

@Injectable({ providedIn: 'root' })
export class MigrationService {
  constructor(private apiService: ApiService) {}

  getMigrations(
    recordId: string,
    memberId: string
  ): Observable<MigrationDetails[]> {
    return this.apiService.get<MigrationDetails[]>(
      BASE_URL.FAMILY_RECORDS_BY_ID(recordId) +
        BASE_URL.MEMBER_BY_ID(memberId) +
        BASE_URL.MIGRATIONS_LIST
    );
  }

  createMigration(
    recordId: string,
    memberId: string,
    migration: MigrationDetails
  ): Observable<MigrationDetails> {
    return this.apiService.post<MigrationDetails>(
      BASE_URL.FAMILY_RECORDS_BY_ID(recordId) +
        BASE_URL.MEMBER_BY_ID(memberId) +
        BASE_URL.MIGRATIONS_LIST,
      migration
    );
  }

  updateMigration(
    recordId: string,
    memberId: string,
    migrationId: string,
    migration: MigrationDetails
  ): Observable<MigrationDetails> {
    return this.apiService.patch<MigrationDetails>(
      BASE_URL.FAMILY_RECORDS_BY_ID(recordId) +
        BASE_URL.MEMBER_BY_ID(memberId) +
        BASE_URL.MIGRATION_BY_ID(migrationId),
      migration
    );
  }

  deleteMigration(
    recordId: string,
    memberId: string,
    migrationId: string
  ): Observable<void> {
    return this.apiService.delete<void>(
      BASE_URL.FAMILY_RECORDS_BY_ID(recordId) +
        BASE_URL.MEMBER_BY_ID(memberId) +
        BASE_URL.MIGRATION_BY_ID(migrationId)
    );
  }
}
