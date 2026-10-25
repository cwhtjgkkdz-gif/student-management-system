package com.student.dao;

import com.student.domain.Admin;

public interface AdminDao {
    // 根据用户名和密码查询管理员
    Admin findByUsernameAndPassword(String username, String password);
}