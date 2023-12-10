package com.fict.elibrary.dto.auth;

import lombok.Builder;
import lombok.Data;

@Data
@Builder
public class RegistrationRequest {
    private String username;
    private String password;
    private String email;
    private String phoneNumber;
    private String firstName;
    private String lastName;
}
