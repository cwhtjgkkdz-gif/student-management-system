package com.student.service.impl;

import com.student.dao.AdminDao;
import com.student.dao.StudentDao;
import com.student.dao.impl.AdminDaoImpl;
import com.student.dao.impl.StudentDaoImpl;
import com.student.domain.Admin;
import com.student.domain.Student;
import com.student.service.LoginService;

public class LoginServiceImpl implements LoginService {
    private AdminDao adminDao = new AdminDaoImpl();
    private StudentDao studentDao = new StudentDaoImpl();

    @Override
    public Admin adminLogin(String username, String password) {
        return adminDao.findByUsernameAndPassword(username, password);
    }

    @Override
    public Student studentLogin(String studentNo, String password) {
        return studentDao.findByStudentNoAndPassword(studentNo, password);
    }
}