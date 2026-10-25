package com.student.dao;

import com.student.domain.SelectCourse;
import java.util.List;

public interface SelectCourseDao {
    // 根据学生ID查询已选课程
    List<SelectCourse> findByStudentId(Integer studentId);

    // 检查是否已选该课程
    SelectCourse checkSelected(Integer studentId, Integer courseId);

    // 选课
    void add(SelectCourse selectCourse);

    // 退课
    void delete(Integer studentId, Integer courseId);

    // 查询所有选课记录
    List<SelectCourse> findAll();

    List<SelectCourse> findByPage(Integer start, Integer rows, String keyword);
    int findTotalCount(String keyword);
    // 统计被选课程数
    int countDistinctCourses();
    // 统计选课学生数
    int countDistinctStudents();
}