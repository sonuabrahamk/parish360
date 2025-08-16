package org.parish360.core.family.service;

import org.parish360.core.family.dto.BlessingInfo;

import java.util.List;

public interface BlessingManager {
    BlessingInfo createBlessingInfo(String parishId, String familyId, BlessingInfo blessingInfo);

    BlessingInfo updateBlessingInfo(String familyId, String blessingId, BlessingInfo blessingInfo);

    BlessingInfo getBlessingInfo(String familyId, String blessingId);

    List<BlessingInfo> getBlessingInfoList(String familyId);

    void deleteBlessingInfo(String familyId, String blessingId);
}
