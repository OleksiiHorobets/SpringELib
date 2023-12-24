package com.fict.elibrary.dto;

import lombok.Data;

@Data
public class ELibUserDto {
    private String id;
    private String username;
    private String firstName;
    private String lastName;
    private String email;
    private String phoneNumber;
    private String role;
    private Boolean isBanned;
}
