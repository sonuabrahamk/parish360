package org.parish360.core.controller.parish.usermanagement;

import org.apache.catalina.connector.Response;
import org.parish360.core.dto.error.ErrorResponse;
import org.parish360.core.dto.usermanagement.UserResponse;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.UUID;

@RestController
@RequestMapping("/diocese/{dioceseId}/forane/{foraneId}/parish/{parishId}/users")
public class UserController {

    @GetMapping
    public ResponseEntity<?> getUsersList(@PathVariable("dioceseId") UUID dioceseId,
                                          @PathVariable("foraneId") UUID foraneId,
                                          @PathVariable("parishId") UUID parishId) {
        if (!foraneId.equals(new UUID(1, 1))) {
            ErrorResponse error = new ErrorResponse();
            error.setCode(Response.SC_BAD_REQUEST);
            error.setMessage("Bad Request");
            return ResponseEntity.badRequest().body(error);
        }
        return ResponseEntity.ok(new UserResponse[]{});
    }
}
