package com.fict.elibrary.exception;

import lombok.Getter;

import java.util.List;

public class UserAlreadyExistsException extends Exception {

    @Getter
    private final List<String> errorsList;

    public UserAlreadyExistsException(String message, List<String> errors) {
        super(message);
        errorsList = errors;
    }
}
