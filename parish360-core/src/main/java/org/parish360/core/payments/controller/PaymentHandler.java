package org.parish360.core.payments.controller;

import jakarta.validation.Valid;
import org.parish360.core.payments.dto.PaymentInfo;
import org.parish360.core.payments.service.PaymentManager;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/parish/{parishId}/payments")
public class PaymentHandler {
    private final PaymentManager paymentManager;

    public PaymentHandler(PaymentManager paymentManager) {
        this.paymentManager = paymentManager;
    }

    @PostMapping
    public ResponseEntity<PaymentInfo> createPayment(@PathVariable("parishId") String parishId,
                                                     @Valid @RequestBody PaymentInfo paymentInfo) {
        return ResponseEntity.ok(paymentManager.createPayment(parishId, paymentInfo));
    }

    @PatchMapping("/{paymentId}")
    public ResponseEntity<PaymentInfo> updatePayment(@PathVariable("parishId") String parishId,
                                                     @PathVariable("paymentId") String paymentId,
                                                     @Valid @RequestBody PaymentInfo paymentInfo) {
        return ResponseEntity.ok(paymentManager.updatePayment(parishId, paymentId, paymentInfo));
    }

    @GetMapping("/{paymentId}")
    public ResponseEntity<PaymentInfo> getPayment(@PathVariable("parishId") String parishId,
                                                  @PathVariable("paymentId") String paymentId) {
        return ResponseEntity.ok(paymentManager.getPaymentInfo(parishId, paymentId));
    }

    @GetMapping
    public ResponseEntity<List<PaymentInfo>> getPaymentListByParish(@PathVariable("parishId") String parishId) {
        return ResponseEntity.ok(paymentManager.getListOfPayments(parishId));
    }

    @DeleteMapping("/{paymentId}")
    public ResponseEntity<Object> deletePayment(@PathVariable("parishId") String parishId,
                                                @PathVariable("paymentId") String paymentId) {
        paymentManager.deletePaymentInfo(parishId, paymentId);
        return ResponseEntity.status(HttpStatus.NO_CONTENT).build();
    }
}
