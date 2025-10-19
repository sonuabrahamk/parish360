package org.parish360.core.payments.service.impl;

import org.parish360.core.common.enums.PaymentType;
import org.parish360.core.common.util.UUIDUtil;
import org.parish360.core.dao.entities.Payment;
import org.parish360.core.dao.entities.bookings.Booking;
import org.parish360.core.dao.entities.configurations.Account;
import org.parish360.core.dao.entities.dataowner.Parish;
import org.parish360.core.dao.entities.family.Family;
import org.parish360.core.dao.entities.family.Subscription;
import org.parish360.core.dao.repository.PaymentRepository;
import org.parish360.core.dao.repository.bookings.BookingRepository;
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

import java.math.BigDecimal;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

@Service
public class PaymentManagerImpl implements PaymentManager {
    private final PaymentMapper paymentMapper;
    private final ParishRepository parishRepository;
    private final FamilyInfoRepository familyInfoRepository;
    private final AccountRepository accountRepository;
    private final PaymentRepository paymentRepository;
    private final SubscriptionRepository subscriptionRepository;
    private final BookingRepository bookingRepository;

    public PaymentManagerImpl(PaymentMapper paymentMapper, ParishRepository parishRepository, FamilyInfoRepository familyInfoRepository, AccountRepository accountRepository, PaymentRepository paymentRepository, SubscriptionRepository subscriptionRepository, BookingRepository bookingRepository) {
        this.paymentMapper = paymentMapper;
        this.parishRepository = parishRepository;
        this.familyInfoRepository = familyInfoRepository;
        this.accountRepository = accountRepository;
        this.paymentRepository = paymentRepository;
        this.subscriptionRepository = subscriptionRepository;
        this.bookingRepository = bookingRepository;
    }

    @Override
    @Transactional
    public PaymentInfo createPayment(String parishId, PaymentInfo paymentInfo) {
        Payment payment = paymentMapper.paymentInfoToDao(paymentInfo);

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
        Family family = null;
        if (paymentInfo.getFamilyCode() != null && !paymentInfo.getFamilyCode().isEmpty()) {
            // fetch family information
            family = familyInfoRepository
                    .findByFamilyCodeAndParishId(paymentInfo.getFamilyCode(), UUIDUtil.decode(parishId))
                    .orElseThrow(() -> new ResourceNotFoundException("could not find family information"));
            payment.setFamily(family);
        }

        // fetch reference information
        switch (paymentInfo.getType()) {
            case PaymentType.BOOKING -> {
                if (payment.getBookingCode() == null) {
                    throw new BadRequestException("booking code should be specified for booking payments");
                }
                // update booking amounts based on the payment
                List<Booking> bookings = bookingRepository
                        .findWithResourceAndServiceByBookingCodeAndParishId(payment.getBookingCode(), parish.getId())
                        .orElseThrow(() -> new ResourceNotFoundException("could not find booking information"))
                        .stream()
                        .filter(booking -> {
                            String status = booking.getStatus();
                            return "CONFIRMED".equals(status) || "IN-PROGRESS".equals(status);
                        })
                        .toList();

                BigDecimal remainingAmount = payment.getAmount();

                for (Booking booking : bookings) {
                    BigDecimal total = booking.getTotalAmount();
                    BigDecimal paid = booking.getAmountPaid();

                    if (total.compareTo(paid) > 0) {
                        BigDecimal balance = total.subtract(paid);

                        if (remainingAmount.compareTo(balance) >= 0) {
                            booking.setAmountPaid(paid.add(balance));
                            remainingAmount = remainingAmount.subtract(balance);
                        } else {
                            booking.setAmountPaid(paid.add(remainingAmount));
                            remainingAmount = BigDecimal.ZERO;
                            break; // No more money left to allocate
                        }
                    }
                }

                if (remainingAmount.compareTo(BigDecimal.ZERO) > 0) {
                    throw new BadRequestException("Please check the amount to be paid for this booking.");
                }

                bookingRepository.saveAll(bookings);

            }
            case PaymentType.SUBSCRIPTION -> {
                if (payment.getSubscriptionFrom() == null || payment.getSubscriptionTo() == null) {
                    throw new BadRequestException(
                            "start date and end date should be specified for subscription payments");
                }
                if (family == null) {
                    throw new BadRequestException("family information should be specified for subscription payments");
                }

                // fetch subscriptions to create and create subscription entries for mentioned dates
                List<Subscription> subscriptions = generateSubscriptionList(
                        payment.getSubscriptionFrom(), payment.getSubscriptionTo(), family);
                BigDecimal amountToBePaid = BigDecimal.valueOf(subscriptions.size() * 100L);
                if (payment.getAmount().compareTo(amountToBePaid) != 0) {
                    throw new BadRequestException(
                            "Please check the amount: total subscriptions amount is : " + amountToBePaid);
                }
                subscriptionRepository.saveAll(subscriptions);
            }
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

    private List<Subscription> generateSubscriptionList(LocalDate startDate, LocalDate endDate, Family family) {
        List<Subscription> subscriptions = new ArrayList<>();

        // Normalize both dates to the first day of their respective months
        LocalDate current = startDate.withDayOfMonth(1);
        LocalDate end = endDate.withDayOfMonth(1);

        while (!current.isAfter(end)) {
            Subscription subscription = new Subscription();
            subscription.setYear(current.getYear());
            subscription.setMonth(current.getMonthValue());
            subscription.setAmount(BigDecimal.valueOf(100));
            subscription.setCurrency("INR");
            subscription.setFamily(family);

            subscriptions.add(subscription);
            current = current.plusMonths(1);
        }
        return subscriptions;
    }
}
