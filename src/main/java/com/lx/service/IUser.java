package com.lx.service;

import com.lx.entity.User;
import com.lx.entity.UserDetail;

import java.util.List;

public interface IUser {

    List<UserDetail> getUsersDetail();
    List<UserDetail> searchByname(String name);

    void insertUser(UserDetail user);

    void deleteUser(String id);

    UserDetail getUserDetail(String id);


    void updateUser(UserDetail userDetail);
}
