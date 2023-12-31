package com.fict.elibrary.controller.handler;

import com.fict.elibrary.exception.UserAlreadyExistsException;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.HttpStatus;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.ResponseStatus;

@ControllerAdvice
@Slf4j
class GlobalExceptionHandler {

    @ExceptionHandler(Throwable.class)
    @ResponseStatus(HttpStatus.INTERNAL_SERVER_ERROR)
    public String handleDefaultException(Throwable exception) {
        log.error("Error occurred: {}", exception.getMessage(), exception);
        return "error/500";
    }

    @ExceptionHandler(UserAlreadyExistsException.class)
    @ResponseStatus(HttpStatus.CONFLICT)
    public String handleUserAlreadyExists(UserAlreadyExistsException exception, Model model) {
        log.error("User already exists: {} \n Error list: {}", exception.getMessage(), exception.getErrorsList(), exception);
        model.addAttribute("regForm", "regForm");

        exception.getErrorsList()
                .forEach(error -> {
                    if (error.contains("username")) {
                        model.addAttribute("loginAlreadyExists", true);
                    }
                    if (error.contains("email")) {
                        model.addAttribute("emailAlreadyExists", true);
                    }
                    if (error.contains("phone number")) {
                        model.addAttribute("phoneAlreadyExists", true);
                    }
                });

        return "common/login-page";
    }

}
