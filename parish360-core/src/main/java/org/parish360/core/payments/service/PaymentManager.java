package org.parish360.core.payments.service;

import org.parish360.core.payments.dto.PaymentInfo;

import java.util.List;

public interface PaymentManager {
    PaymentInfo createPayment(String parishId, PaymentInfo paymentInfo);

    PaymentInfo updatePayment(String parishId, String paymentId, PaymentInfo paymentInfo);

    PaymentInfo getPaymentInfo(String parishId, String paymentId);

    List<PaymentInfo> getListOfPayments(String parishId);

    void deletePaymentInfo(String parishId, String paymentId);
}
