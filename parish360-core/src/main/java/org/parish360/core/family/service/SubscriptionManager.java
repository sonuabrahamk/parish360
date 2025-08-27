package org.parish360.core.family.service;

import org.parish360.core.family.dto.SubscriptionInfo;

import java.util.List;

public interface SubscriptionManager {
    SubscriptionInfo createSubscription(String parishId, String familyId, SubscriptionInfo subscriptionInfo);

    SubscriptionInfo updateSubscription(String familyId, String subscriptionId, SubscriptionInfo subscriptionInfo);

    SubscriptionInfo getSubscription(String familyId, String subscriptionId);

    List<SubscriptionInfo> getSubscriptionList(String familyId);

    void deleteSubscription(String familyId, String subscriptionId);
}
