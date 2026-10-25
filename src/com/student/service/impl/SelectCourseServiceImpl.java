package com.student.service.impl;

import com.student.dao.SelectCourseDao;
import com.student.dao.impl.SelectCourseDaoImpl;
import com.student.domain.PageBean;
import com.student.domain.SelectCourse;
import com.student.service.SelectCourseService;

import java.util.Date;
import java.util.List;

public class SelectCourseServiceImpl implements SelectCourseService {
    private SelectCourseDao selectCourseDao = new SelectCourseDaoImpl();

    @Override
    public List<SelectCourse> findByStudentId(Integer studentId) {
        return selectCourseDao.findByStudentId(studentId);
    }

    @Override
    public boolean selectCourse(Integer studentId, Integer courseId) {
        // 检查是否已选
        SelectCourse selected = selectCourseDao.checkSelected(studentId, courseId);
        if (selected != null) {
            return false; // 已选，选课失败
        }
        // 执行选课
        SelectCourse selectCourse = new SelectCourse();
        selectCourse.setStudentId(studentId);
        selectCourse.setCourseId(courseId);
        selectCourse.setSelectTime(new Date());
        selectCourseDao.add(selectCourse);
        return true; // 选课成功
    }

    @Override
    public boolean dropCourse(Integer studentId, Integer courseId) {
        // 检查是否已选
        SelectCourse selected = selectCourseDao.checkSelected(studentId, courseId);
        if (selected == null) {
            return false; // 未选，退课失败
        }
        // 执行退课
        selectCourseDao.delete(studentId, courseId);
        return true; // 退课成功
    }

    @Override
    public List<SelectCourse> findAll() {
        return selectCourseDao.findAll();
    }

    @Override
    public PageBean<SelectCourse> findByPage(Integer currentPage, Integer rows, String keyword) {
        PageBean<SelectCourse> pb = new PageBean<>();
        pb.setCurrentPage(currentPage);
        pb.setRows(rows);

        int totalCount = selectCourseDao.findTotalCount(keyword);
        pb.setTotalCount(totalCount);

        int start = (currentPage - 1) * rows;
        List<SelectCourse> list = selectCourseDao.findByPage(start, rows, keyword);
        pb.setList(list);

        return pb;
    }

    @Override
    public int countDistinctCourses() {
        return selectCourseDao.countDistinctCourses();
    }

    @Override
    public int countDistinctStudents() {
        return selectCourseDao.countDistinctStudents();
    }

    @Override
    public int calculateTotalCredits(Integer studentId) {
        // 查询学生已选课程
        List<SelectCourse> selectedCourses = selectCourseDao.findByStudentId(studentId);

        // 计算总学分
        int totalCredits = 0;
        for (SelectCourse course : selectedCourses) {
            if (course.getCredit() != null) {
                totalCredits += course.getCredit();
            }
        }
        return totalCredits;
    }
}