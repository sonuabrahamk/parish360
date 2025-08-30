package org.parish360.core.family.service;

import org.parish360.core.family.dto.SacramentInfo;

import java.util.List;

public interface SacramentInfoManager {
    SacramentInfo createSacramentInfo(String familyId, String memberId, SacramentInfo sacramentInfo);

    SacramentInfo updateSacramentInfo(String memberId, String sacramentInfoId, SacramentInfo sacramentInfo);

    SacramentInfo getSacramentInfo(String memberId, String sacramentInfoId);

    List<SacramentInfo> getSacramentInfoList(String memberId);

    void deleteSacramentInfo(String memberId, String sacramentInfo);
}
