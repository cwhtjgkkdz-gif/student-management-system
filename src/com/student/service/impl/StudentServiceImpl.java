package com.student.service.impl;

import com.student.dao.StudentDao;
import com.student.dao.impl.StudentDaoImpl;
import com.student.domain.PageBean;
import com.student.domain.Student;
import com.student.service.StudentService;
import java.util.List;

public class StudentServiceImpl implements StudentService {
    private StudentDao studentDao = new StudentDaoImpl();

    @Override
    public List<Student> findAll() {
        return studentDao.findAll();
    }

    @Override
    public Student findById(Integer id) {
        return studentDao.findById(id);
    }

    @Override
    public void add(Student student) {
        studentDao.add(student);
    }

    @Override
    public void update(Student student) {
        studentDao.update(student);
    }

    @Override
    public void delete(Integer id) {
        studentDao.delete(id);
    }

    @Override
    public int count() {
        return studentDao.count();
    }

    @Override
    public PageBean<Student> findByPage(Integer currentPage, Integer rows, String keyword) {
        PageBean<Student> pb = new PageBean<>();
        pb.setCurrentPage(currentPage);
        pb.setRows(rows);

        int totalCount = studentDao.findTotalCount(keyword);
        pb.setTotalCount(totalCount);

        int start = (currentPage - 1) * rows;
        List<Student> list = studentDao.findByPage(start, rows, keyword);
        pb.setList(list);

        return pb;
    }


    @Override
    public boolean changePassword(Integer id, String oldPassword, String newPassword) {
        // 先验证旧密码
        Student student = studentDao.findById(id);
        if (student == null || !student.getPassword().equals(oldPassword)) {
            return false;
        }

        // 更新密码
        return studentDao.updatePassword(id, newPassword);
    }

    @Override
    public boolean deactivateAccount(Integer id, String password) {
        // 验证密码
        Student student = studentDao.findById(id);
        if (student == null || !student.getPassword().equals(password)) {
            return false;
        }

        // 删除用户
        studentDao.delete(id);
        return true;
    }

    @Override
    public boolean register(Student student) {
        // 检查学号是否已存在
        if (studentDao.isStudentNoExists(student.getStudentNo())) {
            return false;
        }

        // 添加用户
        studentDao.add(student);
        return true;
    }

    @Override
    public boolean isStudentNoExists(String studentNo) {
        return studentDao.isStudentNoExists(studentNo);
    }

    @Override
    public Student findByStudentNo(String studentNo) {
        return studentDao.findByStudentNo(studentNo);
    }
}