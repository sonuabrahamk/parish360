package org.parish360.core.dataowner.service;

import org.parish360.core.dataowner.dto.DioceseInfo;

import java.util.List;

public interface DioceseManager {

    public DioceseInfo createDiocese(DioceseInfo dioceseInfo);

    public List<DioceseInfo> getDiocese();
}
