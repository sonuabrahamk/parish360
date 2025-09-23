package org.parish360.core.configurations.service;

import org.parish360.core.configurations.dto.ParishYearInfo;

import java.util.List;

public interface ParishYearManager {
    ParishYearInfo createParishYearInfo(String parishId, ParishYearInfo parishYearInfo);

    ParishYearInfo updateParishYearInfo(String parishId, String parishYearId, ParishYearInfo parishYearInfo);

    ParishYearInfo getParishYearInfo(String parishId, String parishYearId);

    List<ParishYearInfo> getListOfParishYearInfo(String parishId);

    void deleteParishYearInfo(String parishId, String parishYearId);
}
