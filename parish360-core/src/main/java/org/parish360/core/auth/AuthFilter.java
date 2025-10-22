package org.parish360.core.auth;

import jakarta.servlet.FilterChain;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import lombok.NonNull;
import org.parish360.core.common.util.JwtUtil;
import org.parish360.core.error.exception.ResourceNotFoundException;
import org.parish360.core.error.exception.UnAuthorizedException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.web.authentication.WebAuthenticationDetailsSource;
import org.springframework.stereotype.Component;
import org.springframework.web.filter.OncePerRequestFilter;
import org.springframework.web.servlet.HandlerExceptionResolver;

import java.io.IOException;

@Component
public class AuthFilter extends OncePerRequestFilter {

    @Autowired
    private JwtUtil jwtUtil;

    @Autowired
    private HandlerExceptionResolver handlerExceptionResolver;

    @Override
    protected boolean shouldNotFilter(HttpServletRequest request) {
        String path = request.getRequestURI();
        return path.startsWith("/auth") || path.startsWith("/health");
    }

    @Override
    protected void doFilterInternal(HttpServletRequest request,
                                    @NonNull HttpServletResponse response,
                                    @NonNull FilterChain filterChain) throws ServletException, IOException {

        if (request.getCookies() != null) {
            for (Cookie cookie : request.getCookies()) {
                if (AuthConstants.AUTH_COOKIE_NAME.equals(cookie.getName())) {
                    String token = cookie.getValue();
                    String path = request.getRequestURI();
                    if (path == null) {
                        throw new ResourceNotFoundException("invalid endpoint");
                    }
                    try {
                        if (token != null
                                && SecurityContextHolder.getContext().getAuthentication() == null
                                && jwtUtil.validateToken(token, path, request.getMethod())) {
                            UsernamePasswordAuthenticationToken authToken = new UsernamePasswordAuthenticationToken(
                                    jwtUtil.extractSubject(token), null, null);

                            // This is CRUCIAL
                            authToken.setDetails(new WebAuthenticationDetailsSource().buildDetails(request));

                            SecurityContextHolder.getContext().setAuthentication(authToken);

                            // refresh cookie and add to response
                            Cookie refreshCookie = new Cookie(AuthConstants.AUTH_COOKIE_NAME, token);
                            refreshCookie.setHttpOnly(true);
                            refreshCookie.setSecure(true);
                            refreshCookie.setPath("/");
                            refreshCookie.setMaxAge(AuthConstants.COOKIE_EXPIRY_SECONDS);
                            response.addCookie(refreshCookie);
                        }
                    } catch (Exception e) {
                        handlerExceptionResolver
                                .resolveException(request, response, null, new UnAuthorizedException(e.getMessage()));
                        return;
                    }
                }
            }
        }

        filterChain.doFilter(request, response);
    }
}
