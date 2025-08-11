package org.parish360.core.family.service;

import org.parish360.core.family.dto.FamilyInfo;

import java.util.List;

public interface FamilyInfoManager {
    FamilyInfo createFamilyRecord(String parishId, FamilyInfo familyInfo);

    FamilyInfo updateFamilyRecord(String parishId, String familyId, FamilyInfo familyInfo);

    FamilyInfo getFamilyRecord(String parishId, String familyId);

    List<FamilyInfo> getFamilyRecordsList(String parishId);

    void removeFamilyRecord(String parishId, String familyId);
}
