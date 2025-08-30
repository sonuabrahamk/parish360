package org.parish360.core.family.service;

import org.parish360.core.family.dto.MiscellaneousInfo;

import java.util.List;

public interface MiscellaneousManager {
    MiscellaneousInfo createMiscellaneousInfo(String parishId, String familId, MiscellaneousInfo miscellaneousInfo);

    MiscellaneousInfo updateMiscellaneousInfo(String familyId, String miscellaneousId, MiscellaneousInfo miscellaneousInfo);

    MiscellaneousInfo getMiscellaneousInfo(String familyId, String miscellaneousId);

    List<MiscellaneousInfo> getMiscellaneousInfoList(String familyId);

    void deleteMiscellaneousInfo(String familyId, String miscellaneousId);
}
