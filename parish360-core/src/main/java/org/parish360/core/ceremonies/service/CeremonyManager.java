package org.parish360.core.ceremonies.service;

import org.parish360.core.ceremonies.dto.CeremonyInfo;

import java.util.List;

public interface CeremonyManager {
    CeremonyInfo createCeremonyInfo(String parishId, CeremonyInfo ceremonyInfo);

    CeremonyInfo updateCeremonyInfo(String parishId, String ceremonyId, CeremonyInfo ceremonyInfo);

    CeremonyInfo getCeremonyInfo(String parishId, String ceremonyId);

    List<CeremonyInfo> getListOfCeremonies(String parishId);

    void deleteCeremony(String parishId, String ceremonyId);
}
