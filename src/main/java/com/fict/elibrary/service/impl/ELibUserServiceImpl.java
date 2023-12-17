package com.fict.elibrary.service.impl;

import com.fict.elibrary.dto.auth.RegistrationRequest;
import com.fict.elibrary.entity.ELibUser;
import com.fict.elibrary.entity.Role;
import com.fict.elibrary.exception.UserAlreadyExistsException;
import com.fict.elibrary.mapper.ELibUserMapper;
import com.fict.elibrary.repository.ELibUserRepository;
import com.fict.elibrary.repository.RoleRepository;
import com.fict.elibrary.service.ELibUserService;
import lombok.RequiredArgsConstructor;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Lazy;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

@Service
@RequiredArgsConstructor
public class ELibUserServiceImpl implements UserDetailsService, ELibUserService {
    private final ELibUserRepository userRepository;
    private final ELibUserMapper eLibUserMapper;
    private final RoleRepository roleRepository;

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

        if (regReq.getPhoneNumber() != null && userRepository.existsByPhoneNumber(regReq.getPhoneNumber())) {
            constraintViolationList.add("User with such phone number already exists: " + regReq.getPhoneNumber());
        }

        if (!constraintViolationList.isEmpty()) {
            throw new UserAlreadyExistsException("User already exists", constraintViolationList);
        }
    }

//    {
//    "username": "qwe123",
//    "email" :"qwe123@qwe.com",
//    "password":"qwe123",
//    "firstName":"first",
//    "lastName":"last"
//}

    @Override
    public void register(RegistrationRequest registrationRequest) throws UserAlreadyExistsException {
        checkIfExists(registrationRequest);

        ELibUser user = buildUser(registrationRequest);

        user.setRole(getUserRole());

        userRepository.save(user);
    }

    private Role getUserRole() {
        return roleRepository.findUserRole("ROLE_USER");
    }

    private ELibUser buildUser(RegistrationRequest registrationRequest) {
        ELibUser user = eLibUserMapper.toEntity(registrationRequest);
        user.setPassword(passwordEncoder.encode(registrationRequest.getPassword()));
        return user;
    }

}
