package com.lx.dao;

import com.lx.entity.UserDetail;
import org.springframework.stereotype.Repository;

import java.math.BigDecimal;

@Repository(value = "accountMapper")
public interface AccountMapper {
    void initAccount(int uId, BigDecimal balance);

    void deleteAccount(String id);

    void updateAccount(UserDetail userDetail);
}