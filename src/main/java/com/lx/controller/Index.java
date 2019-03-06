package com.lx.controller;


import com.lx.entity.UserDetail;
import com.lx.exception.GlobalExceptionHandler;
import com.lx.service.IUser;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;

import javax.validation.Valid;
import java.util.List;

@Controller
public class Index {
    private static final org.slf4j.Logger LOG = LoggerFactory.getLogger(GlobalExceptionHandler.class);

    @Autowired
    @Qualifier(value = "userImpl")
    private IUser userImpl;


    @GetMapping(value = "/")
    public String home(Model model) {
        model.addAttribute("users", userImpl.getUsersDetail());
        return "index";
    }

    @PostMapping(value = "/users")
    public String add(@Valid UserDetail user, BindingResult bindingResult) {
        if (bindingResult.hasErrors()) {
            String msg = bindingResult.getFieldError().getDefaultMessage();
            LOG.error(msg);
            throw new IllegalArgumentException(msg);
        }
        userImpl.insertUser(user);
        return "redirect:/";
    }

    @DeleteMapping(value = "/users/{id}")
    @ResponseBody
    public String del(@PathVariable String id) {
        userImpl.deleteUser(id);
        return "SUCCESS";
    }

    @GetMapping(value = "/users/{id}")
    @ResponseBody
    public UserDetail edit(@PathVariable String id) {
        UserDetail userDetail = userImpl.getUserDetail(id);

        return userDetail;
    }

    @GetMapping(value = "/users")
    @ResponseBody
    public List<UserDetail> search(String name) {
        List<UserDetail> userDetails = userImpl.searchByname(name);
        if (userDetails.size() < 1) {
            return null;
        }
        return userDetails;
    }

    @GetMapping(value = "/users/search")
    public String searchUI(Model model, String name) {
        List<UserDetail> userDetails = userImpl.searchByname(name);
        if (userDetails.size() < 1) {
            return "redirect:/";
        }
        model.addAttribute("users", userDetails);
        return "search";
    }

    @PutMapping(value = "/users")
    @ResponseBody
    public String update(@RequestBody @Valid UserDetail user, BindingResult bindingResult) {
        if (bindingResult.hasErrors()) {
            String msg = bindingResult.getFieldError().getDefaultMessage();
            LOG.error(msg);
            throw new IllegalArgumentException(msg);
        }
        userImpl.updateUser(user);
        return "SUCCESS";
    }
}