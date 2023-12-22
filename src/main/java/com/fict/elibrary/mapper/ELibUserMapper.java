package com.fict.elibrary.mapper;

import com.fict.elibrary.dto.ELibUserDto;
import com.fict.elibrary.dto.auth.RegistrationRequest;
import com.fict.elibrary.entity.ELibUser;
import com.fict.elibrary.entity.Role;
import org.mapstruct.Mapper;
import org.mapstruct.Mapping;
import org.mapstruct.MappingConstants;
import org.mapstruct.Named;

@Mapper(componentModel = MappingConstants.ComponentModel.SPRING)
public interface ELibUserMapper {
    ELibUser toEntity(RegistrationRequest registrationRequest);


    @Mapping(source = "role", target = "role", qualifiedByName = "roleToString")
    ELibUserDto toDto(ELibUser user);

    @Named("roleToString")
    static String roleToString(Role role) {
        return role.getTitle();
    }
}
