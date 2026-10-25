package com.student.service.impl;

import com.student.dao.TeacherDao;
import com.student.dao.impl.TeacherDaoImpl;
import com.student.domain.PageBean;
import com.student.domain.Teacher;
import com.student.service.TeacherService;
import java.util.List;

public class TeacherServiceImpl implements TeacherService {
    private TeacherDao teacherDao = new TeacherDaoImpl();

    @Override
    public List<Teacher> findAll() {
        return teacherDao.findAll();
    }

    @Override
    public Teacher findById(Integer id) {
        return teacherDao.findById(id);
    }

    @Override
    public void add(Teacher teacher) {
        teacherDao.add(teacher);
    }

    @Override
    public void update(Teacher teacher) {
        teacherDao.update(teacher);
    }

    @Override
    public void delete(Integer id) {
        teacherDao.delete(id);
    }

    @Override
    public int count() {
         return teacherDao.count();
    }

    @Override
    public PageBean<Teacher> findByPage(Integer currentPage, Integer rows, String keyword) {
        PageBean<Teacher> pb = new PageBean<>();
        pb.setCurrentPage(currentPage);
        pb.setRows(rows);

        int totalCount = teacherDao.findTotalCount(keyword);
        pb.setTotalCount(totalCount);

        int start = (currentPage - 1) * rows;
        List<Teacher> list = teacherDao.findByPage(start, rows, keyword);
        pb.setList(list);

        return pb;
    }
}