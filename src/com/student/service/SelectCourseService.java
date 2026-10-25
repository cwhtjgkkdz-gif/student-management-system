package com.student.service;

import com.student.domain.PageBean;
import com.student.domain.SelectCourse;
import java.util.List;

public interface SelectCourseService {
    // 根据学生ID查询已选课程
    List<SelectCourse> findByStudentId(Integer studentId);

    // 选课
    boolean selectCourse(Integer studentId, Integer courseId);

    // 退课
    boolean dropCourse(Integer studentId, Integer courseId);

    // 查询所有选课记录
    List<SelectCourse> findAll();

    // 修改现有方法，添加搜索参数
    PageBean<SelectCourse> findByPage(Integer currentPage, Integer rows, String keyword);

    // 统计被选课程数(管理员)
    int countDistinctCourses();

    // 统计选课学生数(管理员)
    int countDistinctStudents();

    //统计学分(学生)
    int calculateTotalCredits(Integer studentId);
}