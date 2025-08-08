package org.parish360.core.dataowner.service;

import org.parish360.core.dataowner.dto.ForaneInfo;

import java.util.List;

public interface ForaneManager {

    public List<ForaneInfo> getForaneList(String dioceseId);

    public ForaneInfo createForane(String dioceseId, ForaneInfo foraneInfo);
}
