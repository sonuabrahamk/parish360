package org.parish360.core.configurations.service;

import org.parish360.core.configurations.dto.PYAssociationRequest;
import org.parish360.core.configurations.dto.PYAssociationResponse;
import org.parish360.core.configurations.dto.ParishYearInfo;

import java.util.List;

public interface ParishYearManager {
    ParishYearInfo createParishYearInfo(String parishId, ParishYearInfo parishYearInfo);

    ParishYearInfo updateParishYearInfo(String parishId, String parishYearId, ParishYearInfo parishYearInfo);

    ParishYearInfo getParishYearInfo(String parishId, String parishYearId);

    List<ParishYearInfo> getListOfParishYearInfo(String parishId);

    void deleteParishYearInfo(String parishId, String parishYearId);

    List<PYAssociationResponse> mapAssociations(String parishId, String parishYearId,
                                                PYAssociationRequest pyAssociationRequest);

    List<PYAssociationResponse> unMapAssociations(String parishId, String parishYearId,
                                                  PYAssociationRequest pyAssociationRequest);

    List<PYAssociationResponse> getPyAssociations(String parishYearId);
}
