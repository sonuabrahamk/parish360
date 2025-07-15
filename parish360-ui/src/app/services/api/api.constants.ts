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
};

export const EXTENSION = '.json'; // To be removed when API's are replaced

export const SUBSCRIPTIONS = '/subscriptions';