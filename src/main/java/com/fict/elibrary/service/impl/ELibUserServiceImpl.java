package com.fict.elibrary.service.impl;

import com.fict.elibrary.dto.ELibUserDto;
import com.fict.elibrary.dto.auth.RegistrationRequest;
import com.fict.elibrary.entity.ELibUser;
import com.fict.elibrary.entity.Role;
import com.fict.elibrary.exception.ResourceNotFoundException;
import com.fict.elibrary.exception.UserAlreadyExistsException;
import com.fict.elibrary.mapper.ELibUserMapper;
import com.fict.elibrary.repository.ELibUserRepository;
import com.fict.elibrary.repository.RoleRepository;
import com.fict.elibrary.service.ELibUserService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Lazy;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.security.core.session.SessionInformation;
import org.springframework.security.core.session.SessionRegistry;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

@Service
@Slf4j
@RequiredArgsConstructor
public class ELibUserServiceImpl implements UserDetailsService, ELibUserService {
    private final ELibUserRepository userRepository;
    private final ELibUserMapper eLibUserMapper;
    private final RoleRepository roleRepository;
    private final ELibUserMapper userMapper;

    @Lazy
    @Autowired
    private SessionRegistry sessionRegistry;

    @Lazy
    @Autowired
    private PasswordEncoder passwordEncoder;


    @Override
    public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
        return userRepository.findByUsername(username)
                .orElseThrow(() -> new UsernameNotFoundException("Username not found: %s".formatted(username)));
    }


    private void checkIfExists(RegistrationRequest regReq) throws UserAlreadyExistsException {
        List<String> constraintViolationList = new ArrayList<>();

        if (userRepository.existsByEmail(regReq.getEmail())) {
            constraintViolationList.add("User with such email already exists: " + regReq.getEmail());
        }
        if (userRepository.existsByUsername(regReq.getUsername())) {
            constraintViolationList.add("User with such username already exists: " + regReq.getUsername());
        }

        if (regReq.getPhoneNumber() != null && !regReq.getPhoneNumber().isBlank() && userRepository.existsByPhoneNumber(regReq.getPhoneNumber())) {
            constraintViolationList.add("User with such phone number already exists: " + regReq.getPhoneNumber());
        }

        if (!constraintViolationList.isEmpty()) {
            throw new UserAlreadyExistsException("User already exists", constraintViolationList);
        }
    }

    @Override
    public void register(RegistrationRequest registrationRequest) throws UserAlreadyExistsException {
        checkIfExists(registrationRequest);
        if (registrationRequest.getPhoneNumber().isBlank()) {
            registrationRequest.setPhoneNumber(null);
        }

        ELibUser user = buildUser(registrationRequest);

        user.setRole(getUserRole());

        userRepository.save(user);
    }

    @Override
    public ELibUser findById(Long id) throws ResourceNotFoundException {
        return userRepository.findById(id)
                .orElseThrow(() -> new ResourceNotFoundException("User with such id {%s} not found".formatted(id)));
    }

    @Override
    public ELibUserDto findByIdToDto(Long id) throws ResourceNotFoundException {
        return userMapper.toDto(findById(id));
    }

    @Override
    public Page<ELibUserDto> findAll(Pageable pageable) {
        return userRepository.findAllByOrderByIsBannedAscRoleDesc(pageable)
                .map(eLibUserMapper::toDto);
    }

    @Override
    public void setUserBlockedStatus(Long userId, Boolean isBlocked) throws ResourceNotFoundException {
        var user = findById(userId);
        if ("ROLE_ADMIN".equals(user.getRole().getTitle())) {
            throw new IllegalStateException("Admin users cannot be blocked");
        }
        user.setIsBanned(isBlocked);
        log.info("Change user status: id: {{}}, isBlocked: {{}}", userId, isBlocked);
        invalidateSession(userId);
        userRepository.save(user);
    }


    private void invalidateSession(Long userId) {
        List<Object> principals = sessionRegistry.getAllPrincipals();
        log.debug("Invalidate session: {}", principals);
        for (Object principal : principals) {
            if (principal instanceof ELibUser user) {
                if (user.getId().equals(userId)) {
                    List<SessionInformation> sessions = sessionRegistry.getAllSessions(principal, false);
                    for (SessionInformation session : sessions) {
                        session.expireNow();
//                        sessionRegistry.removeSessionInformation(session.getSessionId());
                    }
                }
            }
        }
    }


    private Role getUserRole() {
        return roleRepository.findByTitle("ROLE_USER");
    }

    private ELibUser buildUser(RegistrationRequest registrationRequest) {
        ELibUser user = eLibUserMapper.toEntity(registrationRequest);
        user.setPassword(passwordEncoder.encode(registrationRequest.getPassword()));
        return user;
    }

}
