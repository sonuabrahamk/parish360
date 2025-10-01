package org.parish360.core.bookings.service.impl;

import org.parish360.core.bookings.dto.BookingInfo;
import org.parish360.core.bookings.service.BookingManager;
import org.parish360.core.bookings.service.BookingMapper;
import org.parish360.core.common.util.UUIDUtil;
import org.parish360.core.dao.entities.bookings.Booking;
import org.parish360.core.dao.entities.configurations.Resource;
import org.parish360.core.dao.entities.dataowner.Parish;
import org.parish360.core.dao.entities.family.Family;
import org.parish360.core.dao.repository.bookings.BookingRepository;
import org.parish360.core.dao.repository.configurations.ResourceRepository;
import org.parish360.core.dao.repository.dataowner.ParishRepository;
import org.parish360.core.dao.repository.family.FamilyInfoRepository;
import org.parish360.core.error.exception.BadRequestException;
import org.parish360.core.error.exception.ResourceNotFoundException;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
public class BookingManagerImpl implements BookingManager {
    private final BookingMapper bookingMapper;
    private final BookingRepository bookingRepository;
    private final ParishRepository parishRepository;
    private final ResourceRepository resourceRepository;
    private final FamilyInfoRepository familyInfoRepository;

    public BookingManagerImpl(BookingMapper bookingMapper, BookingRepository bookingRepository, ParishRepository parishRepository, ResourceRepository resourceRepository, FamilyInfoRepository familyInfoRepository) {
        this.bookingMapper = bookingMapper;
        this.bookingRepository = bookingRepository;
        this.parishRepository = parishRepository;
        this.resourceRepository = resourceRepository;
        this.familyInfoRepository = familyInfoRepository;
    }

    @Override
    @Transactional
    public BookingInfo createBooking(String parishId, BookingInfo bookingInfo) {
        Booking booking = bookingMapper.bookingInfoToDao(bookingInfo);

        // fetch resource information
        Resource resource = resourceRepository
                .findById(UUIDUtil.decode(bookingInfo.getResourceId()))
                .orElseThrow(() -> new ResourceNotFoundException("could not find resource information"));
        booking.setResource(resource);

        // Check if resource is available for the given date
        if (bookingRepository.existsByResourceAndTime(resource.getId(),
                bookingInfo.getBookedFrom(), bookingInfo.getBookedTo())) {
            throw new BadRequestException("resource is already booked for the given time");
        }

        //fetch parish information
        Parish parish = parishRepository
                .findById(UUIDUtil.decode(parishId))
                .orElseThrow(() -> new ResourceNotFoundException("could not find parish information"));
        booking.setParish(parish);

        if (!bookingInfo.getFamilyCode().isEmpty()) {
            Family family = familyInfoRepository
                    .findByFamilyCodeAndParishId(bookingInfo.getFamilyCode(), UUIDUtil.decode(parishId))
                    .orElseThrow(() -> new ResourceNotFoundException("could not find family information"));
            booking.setFamily(family);
        }

        return bookingMapper.daoToBookingInfo(bookingRepository.save(booking));
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
}
