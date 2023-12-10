package com.fict.elibrary.service;

import com.fict.elibrary.repository.ELibUserRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
public class ELibUserService implements UserDetailsService {
    private final ELibUserRepository eLibUserRepository;


    @Override
    public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
        return eLibUserRepository.findByUsername(username)
                .orElseThrow(() -> new UsernameNotFoundException("Username not found: %s".formatted(username)));
    }
}
