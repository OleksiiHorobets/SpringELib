package com.fict.elibrary.dto.auth;

import jakarta.validation.constraints.Email;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Pattern;
import lombok.Builder;
import lombok.Data;

@Data
@Builder
public class RegistrationRequest {
    @NotNull
    @Pattern(regexp = "^\\w{3,30}$")
    private String username;

    @NotNull
    @Pattern(regexp = "^(?=.*[A-Za-z])(?=.*\\d)[A-Za-z\\d]{6,30}$")
    private String password;

    @NotNull
    @Email
    private String email;

    @Pattern(regexp = "^(\\d{12}|\\s*)$")
    private String phoneNumber;

    @NotNull
    @Pattern(regexp = "^[a-zA-Z ,.'\\-]{1,30}$")
    private String firstName;

    @NotNull
    @Pattern(regexp = "^[a-zA-Z ,.'\\-]{1,30}$")
    private String lastName;
}
