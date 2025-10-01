package org.parish360.core.bookings.service;

import org.parish360.core.bookings.dto.BookingInfo;

import java.util.List;

public interface BookingManager {
    BookingInfo createBooking(String parishId, BookingInfo bookingInfo);

    BookingInfo updateBooking(String parishId, String bookingId, BookingInfo bookingInfo);

    BookingInfo getBookingInfo(String parishId, String bookingId);

    List<BookingInfo> getListOfBooking(String parishId);

    void deleteBookingInfo(String parishId, String bookingId);
}
