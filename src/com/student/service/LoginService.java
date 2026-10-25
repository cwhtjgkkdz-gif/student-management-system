package com.student.service;

import com.student.domain.Admin;
import com.student.domain.Student;

public interface LoginService {
    // 管理员登录
    Admin adminLogin(String username, String password);

    // 学生登录
    Student studentLogin(String studentNo, String password);
}