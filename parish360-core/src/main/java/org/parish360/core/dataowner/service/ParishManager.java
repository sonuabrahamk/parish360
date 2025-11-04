package org.parish360.core.dataowner.service;

import org.parish360.core.dataowner.dto.ParishInfo;

import java.util.List;

public interface ParishManager {

    List<ParishInfo> getParishList(String dioceseId, String foraneId);

    ParishInfo getParishInfo(String parishId);

    ParishInfo updateParishInfo(String parishId, ParishInfo parishInfo);

    ParishInfo createParish(String dioceseId, String foraneId, ParishInfo parishInfo);
}
