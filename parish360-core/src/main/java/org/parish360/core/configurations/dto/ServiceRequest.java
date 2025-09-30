package org.parish360.core.configurations.dto;

import jakarta.validation.constraints.NotNull;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import org.parish360.core.common.enums.ServiceRecurrencePattern;

import java.time.DayOfWeek;
import java.time.LocalDate;
import java.time.LocalTime;
import java.util.List;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class ServiceRequest {
    @NotNull(message = "service name cannot be null")
    private String name;
    @NotNull(message = "type should be specified")
    private String type;
    @NotNull(message = "single or multiple request has to be defined")
    private boolean recurring;
    private ServiceRecurrencePattern serviceRecurrencePattern;
    private List<DayOfWeek> daysOfWeek;
    @NotNull(message = "date has to be mentioned")
    private LocalDate startDate;
    private LocalDate endDate;
    @NotNull(message = "start time has to be mentioned")
    private LocalTime startTime;
    @NotNull(message = "end time has to be mentioned")
    private LocalTime endTime;
    @NotNull(message = "resource has to be mentioned")
    private String resourceId;
}
