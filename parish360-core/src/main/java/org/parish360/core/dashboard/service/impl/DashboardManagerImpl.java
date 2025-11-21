package org.parish360.core.dashboard.service.impl;

import org.parish360.core.common.util.TimezoneUtil;
import org.parish360.core.common.util.UUIDUtil;
import org.parish360.core.dao.entities.Expense;
import org.parish360.core.dao.entities.Payment;
import org.parish360.core.dao.entities.family.Member;
import org.parish360.core.dao.repository.ExpenseRepository;
import org.parish360.core.dao.repository.PaymentRepository;
import org.parish360.core.dao.repository.dataowner.ParishRepository;
import org.parish360.core.dao.repository.family.MemberRepository;
import org.parish360.core.dashboard.dto.ParishReportInfo;
import org.parish360.core.dashboard.dto.StatementResponse;
import org.parish360.core.dashboard.service.DashboardManager;
import org.parish360.core.error.exception.ResourceNotFoundException;
import org.parish360.core.family.dto.MemberInfo;
import org.parish360.core.family.service.FamilyMapper;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.Instant;
import java.time.LocalDate;
import java.time.LocalTime;
import java.util.ArrayList;
import java.util.Comparator;
import java.util.List;
import java.util.UUID;

@Service
public class DashboardManagerImpl implements DashboardManager {
    private final ParishRepository parishRepository;
    private final MemberRepository memberRepository;
    private final FamilyMapper familyMapper;
    private final PaymentRepository paymentRepository;
    private final ExpenseRepository expenseRepository;

    public DashboardManagerImpl(ParishRepository parishRepository,
                                MemberRepository memberRepository,
                                FamilyMapper familyMapper,
                                PaymentRepository paymentRepository,
                                ExpenseRepository expenseRepository) {
        this.parishRepository = parishRepository;
        this.memberRepository = memberRepository;
        this.familyMapper = familyMapper;
        this.paymentRepository = paymentRepository;
        this.expenseRepository = expenseRepository;
    }

    @Override
    @Transactional(readOnly = true)
    public ParishReportInfo getParishReport(String parishId) {
        return parishRepository
                .findParishReport(UUIDUtil.decode(parishId))
                .orElseThrow(() -> new ResourceNotFoundException("could not find parish report"));
    }

    @Override
    @Transactional(readOnly = true)
    public List<MemberInfo> getAllMembers(String parishId) {
        List<Member> members = memberRepository
                .findByParishId(UUIDUtil.decode(parishId))
                .orElseThrow(() -> new ResourceNotFoundException("could not find members"));
        return members.stream().map(familyMapper::daoToMemberInfo).toList();
    }

    @Override
    @Transactional(readOnly = true)
    public List<StatementResponse> getAccountStatement(String parishId, LocalDate startDate, LocalDate endDate) {

        UUID parishUuid = UUIDUtil.decode(parishId);
        Instant startTime = TimezoneUtil.asInstant(startDate.atStartOfDay());
        Instant endTime = TimezoneUtil.asInstant(endDate.atTime(LocalTime.MAX));

        List<Payment> payments = paymentRepository
                .findByParishIdAndCreatedAtBetween(parishUuid, startTime, endTime)
                .orElseThrow(() -> new ResourceNotFoundException("could not find payment records"));

        List<Expense> expenses = expenseRepository
                .findByParishIdAndDateBetween(parishUuid, startDate, endDate)
                .orElseThrow(() -> new ResourceNotFoundException("could not fetch expense records"));

        List<StatementResponse> paymentStatement = payments.stream()
                .map((payment) -> {
                    StatementResponse statement = new StatementResponse();
                    statement.setAccountName(payment.getAccount().getName());
                    statement.setDate(TimezoneUtil.asLocalDate(payment.getCreatedAt()));
                    statement.setType("CREDIT");
                    statement.setParty(payment.getPayee());
                    statement.setDescription(payment.getDescription());
                    statement.setPayment(payment.getAmount());
                    statement.setCurrency(payment.getCurrency());
                    return statement;
                })
                .toList();

        List<StatementResponse> expenseStatement = expenses.stream()
                .map((expense) -> {
                    StatementResponse statement = new StatementResponse();
                    statement.setAccountName(expense.getAccount().getName());
                    statement.setDate(expense.getDate());
                    statement.setType("DEBIT");
                    statement.setParty(expense.getPaidTo());
                    statement.setDescription(expense.getDescription());
                    statement.setPayment(expense.getAmount());
                    statement.setCurrency(expense.getCurrency());
                    return statement;
                })
                .toList();

        List<StatementResponse> statementResponses = new ArrayList<>();
        statementResponses.addAll(paymentStatement);
        statementResponses.addAll(expenseStatement);
        statementResponses.sort(Comparator.comparing(StatementResponse::getDate).reversed());

        return statementResponses;
    }
}
