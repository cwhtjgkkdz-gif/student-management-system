package com.student.dao.impl;

import com.student.dao.TeacherDao;
import com.student.domain.Teacher;
import com.student.util.JDBCUtils;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;

import java.util.List;

public class TeacherDaoImpl implements TeacherDao {
    private JdbcTemplate template = new JdbcTemplate(JDBCUtils.getDataSource());

    @Override
    public List<Teacher> findAll() {
        String sql = "SELECT * FROM teacher";
        return template.query(sql, new BeanPropertyRowMapper<>(Teacher.class));
    }

    @Override
    public Teacher findById(Integer id) {
        String sql = "SELECT * FROM teacher WHERE id = ?";
        return template.queryForObject(sql, new BeanPropertyRowMapper<>(Teacher.class), id);
    }

    @Override
    public void add(Teacher teacher) {
        String sql = "INSERT INTO teacher(teacher_no, name, gender, subject, phone) " +
                "VALUES(?, ?, ?, ?, ?)";
        template.update(sql,
                teacher.getTeacherNo(),
                teacher.getName(),
                teacher.getGender(),
                teacher.getSubject(),
                teacher.getPhone());
    }

    @Override
    public void update(Teacher teacher) {
        String sql = "UPDATE teacher SET teacher_no = ?, name = ?, gender = ?, subject = ?, phone = ? " +
                "WHERE id = ?";
        template.update(sql,
                teacher.getTeacherNo(),
                teacher.getName(),
                teacher.getGender(),
                teacher.getSubject(),
                teacher.getPhone(),
                teacher.getId());
    }

    @Override
    public void delete(Integer id) {
        String sql = "DELETE FROM teacher WHERE id = ?";
        template.update(sql, id);
    }

    @Override
    public int count() {
        String sql = "SELECT COUNT(*) FROM teacher";
        Integer count = template.queryForObject(sql, Integer.class);
        return count != null ? count : 0;
    }

    @Override
    public List<Teacher> findByPage(Integer start, Integer rows, String keyword) {
        String sql = "SELECT * FROM teacher WHERE teacher_no LIKE ? OR name LIKE ? OR subject LIKE ? LIMIT ?, ?";
        String searchParam = "%" + (keyword != null ? keyword : "") + "%";
        return template.query(sql, new BeanPropertyRowMapper<>(Teacher.class),
                searchParam, searchParam, searchParam, start, rows);
    }

    @Override
    public int findTotalCount(String keyword) {
        String sql = "SELECT COUNT(*) FROM teacher WHERE teacher_no LIKE ? OR name LIKE ? OR subject LIKE ?";
        String searchParam = "%" + (keyword != null ? keyword : "") + "%";
        Integer count = template.queryForObject(sql, Integer.class, searchParam, searchParam, searchParam);
        return count != null ? count : 0;
    }
}