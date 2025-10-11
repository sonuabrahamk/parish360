export const BASE_URL = {
  LOGIN: `/login`,
  PERMISSIONS: (id: string) => `/permissions/${id}.json`,

  DIOCESE_LIST: `/diocese`,
  DIOCESE_BY_ID: (dioceseId: string) => `/diocese/${dioceseId}`,

  FORANE: `/forane`,
  FORANE_BY_ID: (foraneId: string) => `/forane/${foraneId}`,

  PARISH_LIST: `/parish`,
  PARISH_BY_ID: (parishId: string) => `/parish/${parishId}`,

  FAMILY_RECORDS_LIST: `/family-records`,
  FAMILY_RECORDS_BY_ID: (familyRecordsId: string | string) =>
    `/family-records/${familyRecordsId}`,

  MEMBERS_LIST: `/members`,
  MEMBER_BY_ID: (memberId: string) => `/members/${memberId}`,

  SACRAMENTS_LIST: `/sacraments`,
  SACRAMENT_BY_ID: (sacramentId: string) => `/sacraments/${sacramentId}`,

  MIGRATIONS_LIST: `/migrations`,
  MIGRATION_BY_ID: (migrationId: string) => `/migrations/${migrationId}`,
};

export const EXTENSION = '.json'; // To be removed when API's are replaced

// Family records API paths
export const SUBSCRIPTIONS = '/subscriptions';

export const BLESSINGS = '/blessings';
export const BLESSING_BY_ID = (blessingId: string) =>
  `/blessings/${blessingId}`;

export const MISCELLANOUS = '/miscellaneous';
export const MISCELLANOUS_BY_ID = (miscellenousId: string) =>
  `/miscellaneous/${miscellenousId}`;

// Bookings API paths
export const BOOKINGS = '/bookings';

// Ceremonies API paths
export const CEREMONIES = '/ceremonys';
export const CEREMONY_BY_ID = (ceremonyId: string) =>
  `/ceremonies/${ceremonyId}`;

// Payments API paths
export const PAYMENTS = '/payments';
export const PAYMENT_BY_ID = (paymentId: string) => `/payments/${paymentId}`;

// Expenses API paths
export const EXPENSES = '/expenses';
export const EXPENSE_BY_ID = (expenseId: string) => `/expenses/${expenseId}`;

//Associations API paths
export const ASSOCIATIONS = '/configurations/association';
export const ASSOCIATION_BY_ID = (associationId: string) =>
  `/configurations/association/${associationId}`;

export const COMMITTEE = '/committee';
export const MEMBERS = '/members';

// User Management API's
export const USERS = '/users';
export const USER_BY_ID = (userId: string) => `/users/${userId}`;

// Liturgy Service API paths
export const SERVICES = '/configurations/services';

// Resources API paths
export const RESOURCES = '/configurations/resources';
export const RESOURCE_BY_ID = (resourceId: string) =>
  `/configurations/resources/${resourceId}`;

// Accounts API paths
export const ACCOUNTS = '/configurations/accounts';
export const ACCOUNT_BY_ID = (accountId: string) =>
  `/configurations/accounts/${accountId}`;

// Parish Year API paths
export const PARISH_YEAR = '/configurations/parish-year';
export const PARISH_YEAR_BY_ID = (parishYearId: string) =>
  `/configurations/parish-year/${parishYearId}`;
