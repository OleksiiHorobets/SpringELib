package com.fict.elibrary.controller.api;

import com.fict.elibrary.exception.ResourceUniqueViolationException;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.HttpStatus;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.MethodArgumentNotValidException;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.ResponseStatus;
import org.springframework.web.bind.annotation.RestControllerAdvice;

import java.util.Map;
import java.util.stream.Collectors;

@RestControllerAdvice
@Slf4j
public class ApiExceptionHandler {

    @ResponseStatus(HttpStatus.BAD_REQUEST)
    @ExceptionHandler(MethodArgumentNotValidException.class)
    public Map<String, String> handleValidationExceptions(MethodArgumentNotValidException ex) {
        log.error("Validation failed exception: {}", ex.getMessage(), ex);
        return getFieldsValidationErrorsMap(ex);
    }


    @ResponseStatus(HttpStatus.CONFLICT)
    @ExceptionHandler(ResourceUniqueViolationException.class)
    public String handleResourceUniqueViolationException(ResourceUniqueViolationException ex) {
        log.error("Resource is not unique exception: {}", ex.getMessage(), ex);
        return ex.getMessage();
    }

    private static Map<String, String> getFieldsValidationErrorsMap(MethodArgumentNotValidException exception) {
        return exception.getBindingResult()
                .getAllErrors()
                .stream()
                .filter(objectError -> objectError.getDefaultMessage() != null)
                .map(FieldError.class::cast)
                .collect(Collectors.toMap(FieldError::getField, FieldError::getDefaultMessage));
    }
}
