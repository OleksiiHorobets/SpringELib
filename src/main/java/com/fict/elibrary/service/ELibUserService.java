package com.fict.elibrary.service;

import com.fict.elibrary.dto.ELibUserDto;
import com.fict.elibrary.dto.auth.RegistrationRequest;
import com.fict.elibrary.entity.ELibUser;
import com.fict.elibrary.exception.ResourceNotFoundException;
import com.fict.elibrary.exception.UserAlreadyExistsException;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

public interface ELibUserService {
    void register(RegistrationRequest registrationRequest) throws UserAlreadyExistsException;

    ELibUser findById(Long id) throws ResourceNotFoundException;

    ELibUserDto findByIdToDto(Long id) throws ResourceNotFoundException;

    Page<ELibUserDto> findAll(Pageable pageable);

    void setUserBlockedStatus(Long id, Boolean isBlocked) throws ResourceNotFoundException;

}
