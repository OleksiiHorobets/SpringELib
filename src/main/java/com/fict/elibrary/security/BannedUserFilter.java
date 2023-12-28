package com.fict.elibrary.security;

import jakarta.servlet.FilterChain;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import lombok.RequiredArgsConstructor;
import org.springframework.security.core.session.SessionInformation;
import org.springframework.security.core.session.SessionRegistry;
import org.springframework.web.filter.OncePerRequestFilter;

import java.io.IOException;
import java.util.Optional;


@RequiredArgsConstructor
public class BannedUserFilter extends OncePerRequestFilter {
    private final SessionRegistry sessionRegistry;

    @Override
    protected void doFilterInternal(HttpServletRequest request, HttpServletResponse response, FilterChain filterChain) throws ServletException, IOException {
        Optional.ofNullable(sessionRegistry.getSessionInformation(request.getSession().getId()))
                .filter(SessionInformation::isExpired)
                .ifPresent(placeHolder -> request.getSession().invalidate());

        filterChain.doFilter(request, response);
    }

}
