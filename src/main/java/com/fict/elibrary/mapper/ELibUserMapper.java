package com.fict.elibrary.mapper;

import com.fict.elibrary.dto.auth.RegistrationRequest;
import com.fict.elibrary.entity.ELibUser;
import org.mapstruct.Mapper;
import org.mapstruct.MappingConstants;

@Mapper(componentModel = MappingConstants.ComponentModel.SPRING)
public interface ELibUserMapper {
    ELibUser toEntity(RegistrationRequest registrationRequest);
}
