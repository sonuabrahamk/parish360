package org.parish360.core.dataowner.service;

import org.parish360.core.dataowner.dto.ParishInfo;

import java.util.List;

public interface ParishManager {

    List<ParishInfo> getParishList(String dioceseId, String foraneId);

    ParishInfo createParish(String dioceseId, String foraneId, ParishInfo parishInfo);
}
