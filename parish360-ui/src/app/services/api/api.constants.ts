export const ApiConstants = {
    BASE_URL: "data",
    LOGIN: `/login`,
    PERMISSIONS: (id: number | string) => `/permissions/${id}.json`,
    PERMISSIONS_KEY: "permissions",

    DIOCESE_LIST: `/diocese`,
    DIOCESE_BY_ID: (dioceseId: number | string) => `/diocese/${dioceseId}`,

    FORANE: `/forane`,
    FORANE_BY_ID: (foraneId: number | string) => `/forane/${foraneId}`,

    PARISH_LIST: `/parish`,
    PARISH_BY_ID: (parishId: number | string) => `/parish/${parishId}`,

    FAMILY_RECORDS_LIST: `/family-records`,
    FAMILY_RECORDS_BY_ID: (familyRecordsId: number | string) => `/family-records/${familyRecordsId}`,

    MEMBERS_LIST: `/members`,
    MEMBER_BY_ID: (memberId: number | string) => `/members/${memberId}`,
} 