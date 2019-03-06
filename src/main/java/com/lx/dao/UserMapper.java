package com.lx.dao;

import com.lx.entity.User;
import com.lx.entity.UserDetail;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository(value = "userMapper")
public interface UserMapper {
    List<String> getUsers();

    List<UserDetail> getUsersDetail();
    List<UserDetail> searchByname(String name);

    UserDetail getUserDetail(String id);

    void insertUser(UserDetail user);

    void deleteUser(String id);

    void updateUser(UserDetail userDetail);
}