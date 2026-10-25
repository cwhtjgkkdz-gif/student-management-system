package com.student.service;

import com.student.domain.Course;
import com.student.domain.PageBean;

import java.util.List;

public interface CourseService {
    // 查询所有课程
    List<Course> findAll();

    // 根据ID查询课程
    Course findById(Integer id);

    // 添加课程
    void add(Course course);

    // 修改课程
    void update(Course course);

    // 删除课程
    void delete(Integer id);
    int count();

    // 分页查询方法
    PageBean<Course> findByPage(Integer currentPage, Integer rows, String keyword);
}