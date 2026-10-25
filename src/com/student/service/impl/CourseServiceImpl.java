package com.student.service.impl;

import com.student.dao.CourseDao;
import com.student.dao.impl.CourseDaoImpl;
import com.student.domain.Course;
import com.student.domain.PageBean;
import com.student.service.CourseService;
import java.util.List;

public class CourseServiceImpl implements CourseService {
    private CourseDao courseDao = new CourseDaoImpl();

    @Override
    public List<Course> findAll() {
        return courseDao.findAll();
    }

    @Override
    public Course findById(Integer id) {
        return courseDao.findById(id);
    }

    @Override
    public void add(Course course) {
        courseDao.add(course);
    }

    @Override
    public void update(Course course) {
        courseDao.update(course);
    }

    @Override
    public void delete(Integer id) {
        courseDao.delete(id);
    }

    @Override
    public int count() {
        return courseDao.count();
    }
    @Override
    public PageBean<Course> findByPage(Integer currentPage, Integer rows, String keyword) {
        PageBean<Course> pb = new PageBean<>();
        pb.setCurrentPage(currentPage);
        pb.setRows(rows);

        int totalCount = courseDao.findTotalCount(keyword);
        pb.setTotalCount(totalCount);

        int start = (currentPage - 1) * rows;
        List<Course> list = courseDao.findByPage(start, rows, keyword);
        pb.setList(list);

        return pb;
    }
}