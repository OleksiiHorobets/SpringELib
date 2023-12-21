package com.fict.elibrary.controller.handler;

import lombok.extern.slf4j.Slf4j;
import org.springframework.http.HttpStatus;
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

//    @ExceptionHandler({NoHandlerFoundException.class})
//    @ResponseStatus(HttpStatus.NOT_FOUND)
//    public String handleNoHandlerFoundException(NoHandlerFoundException ex, HttpServletRequest httpServletRequest) {
//        HttpStatus status = HttpStatus.INTERNAL_SERVER_ERROR;
//
//        log.info("Page not found exception: {}", httpServletRequest.getAsyncContext(), ex);
//
//        return "error/404";
//    }


}
