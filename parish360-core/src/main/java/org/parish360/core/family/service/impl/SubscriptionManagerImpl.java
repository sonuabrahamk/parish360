package org.parish360.core.family.service.impl;

import org.parish360.core.common.util.UUIDUtil;
import org.parish360.core.dao.entities.family.Family;
import org.parish360.core.dao.entities.family.Subscription;
import org.parish360.core.dao.repository.family.FamilyInfoRepository;
import org.parish360.core.dao.repository.family.SubscriptionRepository;
import org.parish360.core.error.exception.ResourceNotFoundException;
import org.parish360.core.family.dto.SubscriptionInfo;
import org.parish360.core.family.service.FamilyMapper;
import org.parish360.core.family.service.SubscriptionManager;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
public class SubscriptionManagerImpl implements SubscriptionManager {
    private final FamilyMapper familyMapper;
    private final FamilyInfoRepository familyInfoRepository;
    private final SubscriptionRepository subscriptionRepository;

    public SubscriptionManagerImpl(FamilyMapper familyMapper, FamilyInfoRepository familyInfoRepository, SubscriptionRepository subscriptionRepository) {
        this.familyMapper = familyMapper;
        this.familyInfoRepository = familyInfoRepository;
        this.subscriptionRepository = subscriptionRepository;
    }

    @Override
    @Transactional
    public SubscriptionInfo createSubscription(String parishId, String familyId, SubscriptionInfo subscriptionInfo) {
        // fetch family information of the subscription to be created
        Family family = familyInfoRepository.findByIdAndParishId(UUIDUtil.decode(familyId), UUIDUtil.decode(parishId))
                .orElseThrow(() -> new ResourceNotFoundException("family information not found"));

        Subscription subscription = familyMapper.subscriptionInfoToDao(subscriptionInfo);
        subscription.setFamily(family);

        return familyMapper.daoToSubscriptionInfo(subscriptionRepository.save(subscription));
    }

    @Override
    public SubscriptionInfo updateSubscription(String familyId, String subscriptionId, SubscriptionInfo subscriptionInfo) {
        // fetch current Subscription info
        Subscription currentSubscription = subscriptionRepository.findByIdAndFamilyId(
                        UUIDUtil.decode(subscriptionId), UUIDUtil.decode(familyId))
                .orElseThrow(() -> new ResourceNotFoundException("subscription information not found"));

        Subscription updateSubscription = familyMapper.subscriptionInfoToDao(subscriptionInfo);
        familyMapper.mergeNotNullSubscriptionFieldToTarget(updateSubscription, currentSubscription);

        return familyMapper.daoToSubscriptionInfo(subscriptionRepository.save(currentSubscription));
    }

    @Override
    public SubscriptionInfo getSubscription(String familyId, String subscriptionId) {
        return familyMapper.daoToSubscriptionInfo(
                subscriptionRepository.findByIdAndFamilyId(
                                UUIDUtil.decode(subscriptionId), UUIDUtil.decode(familyId))
                        .orElseThrow(
                                () -> new ResourceNotFoundException("subscription information not found")));
    }

    @Override
    public List<SubscriptionInfo> getSubscriptionList(String familyId) {
        // fetch subscription list
        Sort sort = Sort.by(
                Sort.Order.desc("year"),
                Sort.Order.desc("month")
        );
        List<Subscription> subscriptions = subscriptionRepository.findByFamilyId(UUIDUtil.decode(familyId), sort)
                .orElseThrow(() -> new ResourceNotFoundException("subscription information not found"));
        return subscriptions.stream()
                .map(familyMapper::daoToSubscriptionInfo)
                .toList();
    }

    @Override
    public void deleteSubscription(String familyId, String subscriptionId) {
        // fetch subscription information
        Subscription subscription = subscriptionRepository.findByIdAndFamilyId(
                        UUIDUtil.decode(subscriptionId), UUIDUtil.decode(familyId))
                .orElseThrow(() -> new ResourceNotFoundException("subscription not found"));

        //remove subscription
        subscriptionRepository.delete(subscription);
    }
}
