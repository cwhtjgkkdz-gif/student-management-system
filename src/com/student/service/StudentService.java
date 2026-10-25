package com.student.service;

import com.student.domain.PageBean;
import com.student.domain.Student;
import java.util.List;

public interface StudentService {
    // 查询所有学生
    List<Student> findAll();

    // 根据ID查询学生
    Student findById(Integer id);

    // 添加学生
    void add(Student student);

    // 修改学生
    void update(Student student);

    // 删除学生
    void delete(Integer id);

    int count();

    // 添加分页查询方法
    PageBean<Student> findByPage(Integer currentPage, Integer rows, String keyword);

    // 修改密码
    boolean changePassword(Integer id, String oldPassword, String newPassword);

    // 注销用户（删除当前用户）
    boolean deactivateAccount(Integer id, String password);

    // 注册用户（与add方法类似，但可能包含验证逻辑）
    boolean register(Student student);

    // 检查学号是否已存在
    boolean isStudentNoExists(String studentNo);

    // 根据学号查询学生
    Student findByStudentNo(String studentNo);
}