package com.lx.service.impl;

import com.lx.dao.AccountMapper;
import com.lx.dao.UserMapper;
import com.lx.entity.UserDetail;
import com.lx.service.IUser;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.util.List;

@Service(value = "userImpl")
public class UserImpl implements IUser {
    @Qualifier(value = "userMapper")
    @Autowired
    private UserMapper userMapper;
    @Qualifier("accountMapper")
    @Autowired
    private AccountMapper accountMapper;


    public List<UserDetail> getUsersDetail() {
        return userMapper.getUsersDetail();
    }

    @Override
    public List<UserDetail> searchByname(String name) {
        return userMapper.searchByname(name);
    }

    public void insertUser(UserDetail user) {
        user.setAge(LocalDate.now().getYear() - Integer.valueOf(new SimpleDateFormat("yyyy").format(user.getBirthday())));
        userMapper.insertUser(user);
        accountMapper.initAccount(user.getId(), user.getBalance());
    }

    public void deleteUser(String id) {
        accountMapper.deleteAccount(id);
        userMapper.deleteUser(id);
    }

    public UserDetail getUserDetail(String id) {
        return userMapper.getUserDetail(id);
    }

    public void updateUser(UserDetail userDetail) {
        userDetail.setAge(LocalDate.now().getYear() - Integer.valueOf(new SimpleDateFormat("yyyy").format(userDetail.getBirthday())));

        userMapper.updateUser(userDetail);
        accountMapper.updateAccount(userDetail);
    }
}
