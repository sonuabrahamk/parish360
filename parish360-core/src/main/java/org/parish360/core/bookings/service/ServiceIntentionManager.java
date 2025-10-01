package org.parish360.core.bookings.service;

import org.parish360.core.bookings.dto.ServiceIntentionInfo;

import java.util.List;

public interface ServiceIntentionManager {
    ServiceIntentionInfo createServiceIntention(String parishId, ServiceIntentionInfo serviceIntentionInfo);

    ServiceIntentionInfo updateServiceIntention(String parishId,
                                                String serviceIntentionId, ServiceIntentionInfo serviceIntentionInfo);

    ServiceIntentionInfo getServiceIntentionsInfo(String parishId, String serviceIntentionId);

    List<ServiceIntentionInfo> getListOfServiceIntentions(String parishId);

    void deleteServiceIntentionInfo(String parishId, String serviceIntentionId);

}
