package com.hampcode.pagoya.customer.mapper;

import com.hampcode.pagoya.customer.dto.CustomerResponse;
import com.hampcode.pagoya.customer.model.Customer;
import org.mapstruct.Mapper;

@Mapper(componentModel = "spring")
public interface CustomerMapper {
    CustomerResponse toResponse(Customer customer);
}
