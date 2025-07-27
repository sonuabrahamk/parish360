package org.parish360.core.service.usermanagement;

import org.parish360.core.authentication.JwtUtil;
import org.parish360.core.dto.usermanagement.AuthenticationRequest;
import org.parish360.core.dto.usermanagement.AuthenticationResponse;
import org.parish360.core.entity.usermanagement.User;
import org.parish360.core.repository.usermanagement.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

import java.util.ArrayList;

@Service
public class UserService implements UserDetailsService {

    @Autowired
    private UserRepository userRepository;

    @Autowired
    private JwtUtil jwtUtil;

    @Override
    public UserDetails loadUserByUsername(String email) throws UsernameNotFoundException {
        User user = userRepository.findByEmail(email)
                .orElseThrow(() -> new UsernameNotFoundException("User not found"));

        return new org.springframework.security.core.userdetails.User(
                user.getEmail(), user.getPassword(),
                new ArrayList<>()
        );
    }

    public AuthenticationResponse authenticateUser(AuthenticationRequest authRequest) {
        User user = userRepository.findByEmail(authRequest.getUsername())
                .orElseThrow(() -> new UsernameNotFoundException("User not found"));

        String jwt = jwtUtil.generateToken(user);
        return new AuthenticationResponse(jwt);
    }
}
