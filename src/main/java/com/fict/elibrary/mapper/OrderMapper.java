package com.fict.elibrary.mapper;

import com.fict.elibrary.dto.OrderDto;
import com.fict.elibrary.entity.Order;
import org.mapstruct.Mapper;
import org.mapstruct.Mapping;
import org.mapstruct.MappingConstants;

@Mapper(
        componentModel = MappingConstants.ComponentModel.SPRING,
        uses = ELibUserMapper.class
)
public interface OrderMapper {

    @Mapping(source = "id", target = "orderId")
    OrderDto toDto(Order order);

}
