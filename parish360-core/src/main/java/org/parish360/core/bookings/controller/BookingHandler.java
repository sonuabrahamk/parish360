package org.parish360.core.bookings.controller;

import jakarta.validation.Valid;
import org.parish360.core.bookings.dto.BookingInfo;
import org.parish360.core.bookings.dto.BookingRequest;
import org.parish360.core.bookings.dto.BookingResponse;
import org.parish360.core.bookings.service.BookingManager;
import org.parish360.core.error.exception.BadRequestException;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/parish/{parishId}/bookings")
public class BookingHandler {
    private final BookingManager bookingManager;

    public BookingHandler(BookingManager bookingManager) {
        this.bookingManager = bookingManager;
    }

    @PostMapping
    public ResponseEntity<List<BookingInfo>> createBookingInfo(@PathVariable("parishId") String parishId,
                                                               @Valid @RequestBody BookingRequest bookingRequest) {
        // validate if booking dates
        if (bookingRequest.getBookedFrom().isAfter(bookingRequest.getBookedTo())) {
            throw new BadRequestException("invalid date range selected");
        }
        return ResponseEntity.ok(bookingManager.createBooking(parishId, bookingRequest));
    }

    @PatchMapping("/{bookingId}")
    public ResponseEntity<BookingInfo> updateBookingInfo(@PathVariable("parishId") String parishId,
                                                         @PathVariable("bookingId") String bookingId,
                                                         @Valid @RequestBody BookingInfo bookingInfo) {
        // validate if booking dates
        if (bookingInfo.getBookedFrom().isAfter(bookingInfo.getBookedFrom())) {
            throw new BadRequestException("invalid date range selected");
        }
        return ResponseEntity.ok(bookingManager.updateBooking(parishId, bookingId, bookingInfo));
    }

    @GetMapping("/{bookingId}")
    public ResponseEntity<BookingInfo> getBookingInfo(@PathVariable("parishId") String parishId,
                                                      @PathVariable("bookingId") String bookingId) {
        return ResponseEntity.ok(bookingManager.getBookingInfo(parishId, bookingId));
    }

    @GetMapping("/view/{bookingCode}")
    public ResponseEntity<BookingResponse> getBookingInfoByCode(@PathVariable("parishId") String parishId,
                                                                @PathVariable("bookingCode") String bookingCode) {
        return ResponseEntity.ok(bookingManager.getBookingByCode(parishId, bookingCode));
    }

    @GetMapping
    public ResponseEntity<List<BookingInfo>> getListOfBookings(@PathVariable("parishId") String parishId) {
        return ResponseEntity.ok(bookingManager.getListOfBooking(parishId));
    }

    @DeleteMapping("/{bookingId}")
    public ResponseEntity<Object> deleteBookingInfo(@PathVariable("parishId") String parishId,
                                                    @PathVariable("bookingId") String bookingId) {
        bookingManager.deleteBookingInfo(parishId, bookingId);
        return ResponseEntity.status(HttpStatus.NO_CONTENT).build();
    }

    @PatchMapping("/{bookingId}/cancel")
    public ResponseEntity<BookingInfo> cancelBookingInfo(@PathVariable("parishId") String parishId,
                                                         @PathVariable("bookingId") String bookingId) {
        return ResponseEntity.ok(bookingManager.cancelBookingInfo(parishId, bookingId));
    }
}
