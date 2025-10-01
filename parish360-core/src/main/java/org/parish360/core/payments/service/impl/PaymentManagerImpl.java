package org.parish360.core.payments.service.impl;

import org.parish360.core.common.enums.PaymentType;
import org.parish360.core.common.util.UUIDUtil;
import org.parish360.core.dao.entities.Payment;
import org.parish360.core.dao.entities.configurations.Account;
import org.parish360.core.dao.entities.dataowner.Parish;
import org.parish360.core.dao.entities.family.Family;
import org.parish360.core.dao.entities.family.Subscription;
import org.parish360.core.dao.repository.PaymentRepository;
import org.parish360.core.dao.repository.configurations.AccountRepository;
import org.parish360.core.dao.repository.dataowner.ParishRepository;
import org.parish360.core.dao.repository.family.FamilyInfoRepository;
import org.parish360.core.dao.repository.family.SubscriptionRepository;
import org.parish360.core.error.exception.BadRequestException;
import org.parish360.core.error.exception.ResourceNotFoundException;
import org.parish360.core.payments.dto.PaymentInfo;
import org.parish360.core.payments.service.PaymentManager;
import org.parish360.core.payments.service.PaymentMapper;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
public class PaymentManagerImpl implements PaymentManager {
    private final PaymentMapper paymentMapper;
    private final ParishRepository parishRepository;
    private final FamilyInfoRepository familyInfoRepository;
    private final AccountRepository accountRepository;
    private final PaymentRepository paymentRepository;
    private final SubscriptionRepository subscriptionRepository;

    public PaymentManagerImpl(PaymentMapper paymentMapper, ParishRepository parishRepository, FamilyInfoRepository familyInfoRepository, AccountRepository accountRepository, PaymentRepository paymentRepository, SubscriptionRepository subscriptionRepository) {
        this.paymentMapper = paymentMapper;
        this.parishRepository = parishRepository;
        this.familyInfoRepository = familyInfoRepository;
        this.accountRepository = accountRepository;
        this.paymentRepository = paymentRepository;
        this.subscriptionRepository = subscriptionRepository;
    }

    @Override
    @Transactional
    public PaymentInfo createPayment(String parishId, PaymentInfo paymentInfo) {
        Payment payment = paymentMapper.paymentInfoToDao(paymentInfo);

        // fetch reference information
        switch (paymentInfo.getType()) {
            case PaymentType.BOOKING, PaymentType.SERVICE_INTENTION ->
                    throw new BadRequestException("this feature is yet to be available");
            case PaymentType.SUBSCRIPTION -> {
                Subscription subscription = subscriptionRepository
                        .findById(UUIDUtil.decode(paymentInfo.getReferenceId()))
                        .orElseThrow(() -> new ResourceNotFoundException("could not find subscription information"));
                payment.setReferenceId(subscription.getId());
            }
        }

        // fetch parish information
        Parish parish = parishRepository
                .findById(UUIDUtil.decode(parishId))
                .orElseThrow(() -> new ResourceNotFoundException("could not find parish information"));
        payment.setParish(parish);

        // fetch account information
        Account account = accountRepository
                .findByIdAndParishId(UUIDUtil.decode(paymentInfo.getAccountId()), UUIDUtil.decode(parishId))
                .orElseThrow(() -> new ResourceNotFoundException("could not find account information"));
        payment.setAccount(account);

        // validate if family information exists and assign family
        if (!paymentInfo.getFamilyCode().isEmpty()) {
            // fetch family information
            Family family = familyInfoRepository
                    .findByFamilyCodeAndParishId(paymentInfo.getFamilyCode(), UUIDUtil.decode(parishId))
                    .orElseThrow(() -> new ResourceNotFoundException("could not find family information"));
            payment.setFamily(family);
        }

        return paymentMapper.daoToPaymentInfo(paymentRepository.save(payment));
    }

    @Override
    @Transactional
    public PaymentInfo updatePayment(String parishId, String paymentId, PaymentInfo paymentInfo) {
        // fetch current payment information
        Payment currentPayment = paymentRepository
                .findByIdAndParishId(UUIDUtil.decode(paymentId), UUIDUtil.decode(parishId))
                .orElseThrow(() -> new ResourceNotFoundException("could not find payment information"));

        Payment updatePayment = paymentMapper.paymentInfoToDao(paymentInfo);
        paymentMapper.mergeNotNullPayment(updatePayment, currentPayment);

        return paymentMapper.daoToPaymentInfo(paymentRepository.save(currentPayment));
    }

    @Override
    @Transactional(readOnly = true)
    public PaymentInfo getPaymentInfo(String parishId, String paymentId) {
        return paymentMapper.daoToPaymentInfo(paymentRepository
                .findByIdAndParishId(UUIDUtil.decode(paymentId), UUIDUtil.decode(parishId))
                .orElseThrow(() -> new ResourceNotFoundException("could not find payment information")));
    }

    @Override
    @Transactional(readOnly = true)
    public List<PaymentInfo> getListOfPayments(String parishId) {
        List<Payment> payments = paymentRepository
                .findByParishId(UUIDUtil.decode(parishId))
                .orElseThrow(() -> new ResourceNotFoundException("could not find payment information"));

        return payments.stream()
                .map(paymentMapper::daoToPaymentInfo)
                .toList();
    }

    @Override
    public void deletePaymentInfo(String parishId, String paymentId) {
        Payment payment = paymentRepository
                .findByIdAndParishId(UUIDUtil.decode(paymentId), UUIDUtil.decode(paymentId))
                .orElseThrow(() -> new ResourceNotFoundException("could not find payment information"));
        paymentRepository.delete(payment);
    }
}
