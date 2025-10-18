package org.parish360.core.bookings.service.impl;

import org.parish360.core.bookings.dto.BookingInfo;
import org.parish360.core.bookings.dto.BookingRequest;
import org.parish360.core.bookings.service.BookingManager;
import org.parish360.core.bookings.service.BookingMapper;
import org.parish360.core.common.enums.PaymentType;
import org.parish360.core.common.util.UUIDUtil;
import org.parish360.core.dao.entities.Payment;
import org.parish360.core.dao.entities.bookings.Booking;
import org.parish360.core.dao.entities.configurations.Account;
import org.parish360.core.dao.entities.configurations.Resource;
import org.parish360.core.dao.entities.configurations.Services;
import org.parish360.core.dao.entities.dataowner.Parish;
import org.parish360.core.dao.entities.family.Family;
import org.parish360.core.dao.repository.PaymentRepository;
import org.parish360.core.dao.repository.bookings.BookingRepository;
import org.parish360.core.dao.repository.configurations.AccountRepository;
import org.parish360.core.dao.repository.configurations.ResourceRepository;
import org.parish360.core.dao.repository.configurations.ServiceRepository;
import org.parish360.core.dao.repository.dataowner.ParishRepository;
import org.parish360.core.dao.repository.family.FamilyInfoRepository;
import org.parish360.core.error.exception.BadRequestException;
import org.parish360.core.error.exception.ResourceNotFoundException;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.List;

@Service
public class BookingManagerImpl implements BookingManager {
    private final BookingMapper bookingMapper;
    private final BookingRepository bookingRepository;
    private final ParishRepository parishRepository;
    private final ResourceRepository resourceRepository;
    private final ServiceRepository serviceRepository;
    private final FamilyInfoRepository familyInfoRepository;
    private final PaymentRepository paymentRepository;
    private final AccountRepository accountRepository;

    public BookingManagerImpl(BookingMapper bookingMapper, BookingRepository bookingRepository, ParishRepository parishRepository, ResourceRepository resourceRepository, ServiceRepository serviceRepository, FamilyInfoRepository familyInfoRepository, PaymentRepository paymentRepository, AccountRepository accountRepository) {
        this.bookingMapper = bookingMapper;
        this.bookingRepository = bookingRepository;
        this.parishRepository = parishRepository;
        this.resourceRepository = resourceRepository;
        this.serviceRepository = serviceRepository;
        this.familyInfoRepository = familyInfoRepository;
        this.paymentRepository = paymentRepository;
        this.accountRepository = accountRepository;
    }

    @Override
    @Transactional
    public List<BookingInfo> createBooking(String parishId, BookingRequest bookingRequest) {
        List<Booking> bookingsToCreate = new ArrayList<>();
        BigDecimal advanceAmount = bookingRequest.getPayment().getAmount();
        Booking booking = bookingMapper.bookingRequestToDao(bookingRequest);

        // generate a booking code
        String booking_code = generateBookingCode();
        booking.setBookingCode(booking_code);

        if (bookingRequest.getItems().length == 0) {
            throw new BadRequestException("no items selected to be booked");
        }

        //fetch parish information
        Parish parish = parishRepository
                .findById(UUIDUtil.decode(parishId))
                .orElseThrow(() -> new ResourceNotFoundException("could not find parish information"));
        booking.setParish(parish);

        if (!bookingRequest.getFamilyCode().isEmpty()) {
            Family family = familyInfoRepository
                    .findByFamilyCodeAndParishId(bookingRequest.getFamilyCode(), UUIDUtil.decode(parishId))
                    .orElseThrow(() -> new ResourceNotFoundException("could not find family information"));
            booking.setFamily(family);
        }

        for (String item : bookingRequest.getItems()) {

            // assign resource or service according to booking type
            switch (bookingRequest.getBookingType()) {
                case "resource":
                    // Check if resource is available for the given date
                    if (bookingRepository.existsByResourceAndTime(UUIDUtil.decode(item),
                            bookingRequest.getBookedFrom(), bookingRequest.getBookedTo())) {
                        throw new BadRequestException("one of the resource is already booked for the given time");
                    }

                    // fetch resource information
                    Resource resource = resourceRepository
                            .findById(UUIDUtil.decode(item))
                            .orElseThrow(() ->
                                    new ResourceNotFoundException(
                                            "could not find resource information for " + item));
                    booking.setResource(resource);
                    booking.setTotalAmount(resource.getAmount());
                    if (advanceAmount.compareTo(resource.getAmount()) >= 0) {
                        booking.setAmountPaid(resource.getAmount());
                        advanceAmount = advanceAmount.subtract(resource.getAmount());
                    } else {
                        booking.setAmountPaid(advanceAmount);
                        advanceAmount = BigDecimal.ZERO;
                    }
                    break;
                case "service-intention":
                    // fetch service information
                    Services service = serviceRepository
                            .findById(UUIDUtil.decode(item))
                            .orElseThrow(() -> new ResourceNotFoundException(
                                    "could not find service information for " + item));
                    booking.setService(service);
                    booking.setTotalAmount(service.getAmount());
                    if (advanceAmount.compareTo(service.getAmount()) >= 0) {
                        booking.setAmountPaid(service.getAmount());
                        advanceAmount = advanceAmount.subtract(service.getAmount());
                    } else {
                        booking.setAmountPaid(advanceAmount);
                        advanceAmount = BigDecimal.ZERO;
                    }
                    break;
                default:
                    throw new BadRequestException("booking type mentioned is not valid");
            }

            // add booking information to list of bookings to created
            bookingsToCreate.add(booking);
        }
        // create booking entries
        List<Booking> bookingsCreated = bookingRepository.saveAll(bookingsToCreate);

        Payment payment = bookingMapper.paymentInfoToPaymentDao(bookingRequest.getPayment());
        payment.setParish(parish);
        payment.setType(PaymentType.BOOKING);
        payment.setBookingCode(booking_code);
        payment.setFamily(booking.getFamily());

        // fetch account information
        Account account = accountRepository
                .findByIdAndParishId(UUIDUtil
                        .decode(bookingRequest.getPayment().getAccountId()), UUIDUtil.decode(parishId))
                .orElseThrow(() -> new ResourceNotFoundException("could not find account information"));
        payment.setAccount(account);

        paymentRepository.save(payment);

        return bookingsCreated.stream()
                .map(bookingMapper::daoToBookingInfo)
                .toList();
    }

    @Override
    @Transactional
    public BookingInfo updateBooking(String parishId, String bookingId, BookingInfo bookingInfo) {
        //fetch current booking
        Booking currentBooking = bookingRepository
                .findByIdAndParishId(UUIDUtil.decode(bookingId), UUIDUtil.decode(parishId))
                .orElseThrow(() -> new ResourceNotFoundException("could not find booking information"));

        Booking updateBooking = bookingMapper.bookingInfoToDao(bookingInfo);
        bookingMapper.mergeNotNullBookingField(updateBooking, currentBooking);
        return bookingMapper.daoToBookingInfo(bookingRepository.save(currentBooking));
    }

    @Override
    @Transactional(readOnly = true)
    public BookingInfo getBookingInfo(String parishId, String bookingId) {
        return bookingMapper.daoToBookingInfo(bookingRepository
                .findByIdAndParishId(UUIDUtil.decode(bookingId), UUIDUtil.decode(parishId))
                .orElseThrow(() -> new ResourceNotFoundException("could not find booking information")));
    }

    @Override
    @Transactional(readOnly = true)
    public List<BookingInfo> getListOfBooking(String parishId) {
        List<Booking> bookings = bookingRepository
                .findByParishId(UUIDUtil.decode(parishId))
                .orElseThrow(() -> new ResourceNotFoundException("could not find bookings information"));
        return bookings.stream()
                .map(bookingMapper::daoToBookingInfo)
                .toList();
    }

    @Override
    @Transactional
    public void deleteBookingInfo(String parishId, String bookingId) {
        Booking booking = bookingRepository
                .findByIdAndParishId(UUIDUtil.decode(bookingId), UUIDUtil.decode(parishId))
                .orElseThrow(() -> new ResourceNotFoundException("could not find booking information"));

        bookingRepository.delete(booking);
    }

    private String generateBookingCode() {
        return "202510-100";
    }
}
