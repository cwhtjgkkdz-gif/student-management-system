package com.student.service;

import com.student.domain.PageBean;
import com.student.domain.Teacher;
import java.util.List;

public interface TeacherService {
    // 查询所有教师
    List<Teacher> findAll();

    // 根据ID查询教师
    Teacher findById(Integer id);

    // 添加教师
    void add(Teacher teacher);

    // 修改教师
    void update(Teacher teacher);

    // 删除教师
    void delete(Integer id);
    int count();

    // 添加分页查询方法
    PageBean<Teacher> findByPage(Integer currentPage, Integer rows, String keyword);
}