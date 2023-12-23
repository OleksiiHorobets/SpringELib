package com.fict.elibrary.service;

import com.fict.elibrary.dto.auth.RegistrationRequest;
import com.fict.elibrary.entity.ELibUser;
import com.fict.elibrary.exception.ResourceNotFoundException;
import com.fict.elibrary.exception.UserAlreadyExistsException;

public interface ELibUserService {
    void register(RegistrationRequest registrationRequest) throws UserAlreadyExistsException;

    ELibUser findById(Long id) throws ResourceNotFoundException;
}
