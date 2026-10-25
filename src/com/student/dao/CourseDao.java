package com.student.dao;

import com.student.domain.Course;
import java.util.List;

public interface CourseDao {
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

    // 分页和搜索方法
    List<Course> findByPage(Integer start, Integer rows, String keyword);
    int findTotalCount(String keyword);
}