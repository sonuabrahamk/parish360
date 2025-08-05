package org.parish360.core.error;

import jakarta.servlet.http.HttpServletRequest;
import org.parish360.core.error.exception.AccessDeniedException;
import org.parish360.core.error.exception.BadRequestException;
import org.parish360.core.error.exception.ResourceNotFoundException;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.http.converter.HttpMessageNotReadableException;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.web.bind.MethodArgumentNotValidException;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.RestControllerAdvice;

import java.time.LocalDateTime;
import java.util.List;
import java.util.Map;

@RestControllerAdvice
public class ErrorHandler {
    @ExceptionHandler(HttpMessageNotReadableException.class)
    public ResponseEntity<Error> handleHttpMessageNotReadable(Exception ex, HttpServletRequest request) {
        Error error = new Error(
                "Bad Request",
                ex.getMessage(),
                null,
                HttpStatus.BAD_REQUEST.value(),
                LocalDateTime.now(),
                request.getRequestURI()
        );
        return new ResponseEntity<>(error, HttpStatus.BAD_REQUEST);
    }

    @ExceptionHandler(MethodArgumentNotValidException.class)
    public ResponseEntity<Error> handleValidationError(MethodArgumentNotValidException ex, HttpServletRequest request) {
        Error error = new Error(
                "Bad Request",
                "Validations Failed",
                null,
                HttpStatus.BAD_REQUEST.value(),
                LocalDateTime.now(),
                request.getRequestURI()
        );

        // check for validation errors
        List<Map<String, String>> validations = ex.getBindingResult()
                .getFieldErrors()
                .stream()
                .map(err -> Map.of(err.getField(),
                        err.getDefaultMessage() != null ?
                                err.getDefaultMessage()
                                : ""))
                .toList();

        error.setValidations(validations);


        return new ResponseEntity<>(error, HttpStatus.BAD_REQUEST);
    }

    @ExceptionHandler({ResourceNotFoundException.class, UsernameNotFoundException.class})
    public ResponseEntity<Error> handleNotFound(Exception ex, HttpServletRequest request) {
        Error error = new Error(
                "Not Found",
                ex.getMessage(),
                null,
                HttpStatus.NOT_FOUND.value(),
                LocalDateTime.now(),
                request.getRequestURI()
        );
        return new ResponseEntity<>(error, HttpStatus.NOT_FOUND);
    }

    @ExceptionHandler(AccessDeniedException.class)
    public ResponseEntity<Error> handleAccessDenied(AccessDeniedException ex, HttpServletRequest request) {
        Error error = new Error(
                "Access Denied",
                ex.getMessage(),
                null,
                HttpStatus.FORBIDDEN.value(),
                LocalDateTime.now(),
                request.getRequestURI()
        );
        return new ResponseEntity<>(error, HttpStatus.FORBIDDEN);
    }

    @ExceptionHandler(BadRequestException.class)
    public ResponseEntity<Error> handleBadRequest(BadRequestException ex, HttpServletRequest request) {
        Error error = new Error(
                "Bad Request",
                ex.getMessage(),
                null,
                HttpStatus.BAD_REQUEST.value(),
                LocalDateTime.now(),
                request.getRequestURI()
        );
        return new ResponseEntity<>(error, HttpStatus.BAD_REQUEST);
    }

    @ExceptionHandler(Exception.class)
    public ResponseEntity<Error> handleGenericException(Exception ex, HttpServletRequest request) {
        Error error = new Error(
                "Internal Server Error",
                ex.getMessage(),
                null,
                HttpStatus.INTERNAL_SERVER_ERROR.value(),
                LocalDateTime.now(),
                request.getRequestURI()
        );
        return new ResponseEntity<>(error, HttpStatus.INTERNAL_SERVER_ERROR);
    }
}
