package com.student.dao;

import com.student.domain.Teacher;
import java.util.List;

public interface TeacherDao {
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

    // 分页和搜索方法
    List<Teacher> findByPage(Integer start, Integer rows, String keyword);
    int findTotalCount(String keyword);
}