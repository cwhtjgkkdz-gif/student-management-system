package com.student.dao.impl;

import com.student.dao.SelectCourseDao;
import com.student.domain.SelectCourse;
import com.student.util.JDBCUtils;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;

import java.util.List;

public class SelectCourseDaoImpl implements SelectCourseDao {
    private JdbcTemplate template = new JdbcTemplate(JDBCUtils.getDataSource());

    @Override
    public List<SelectCourse> findByStudentId(Integer studentId) {
        String sql = "SELECT sc.id, sc.student_id, sc.course_id, sc.select_time, " +
                "s.name AS student_name, c.name AS course_name, " +
                "c.credit, c.teacher_id, t.name AS teacher_name, " +
                "c.course_no " +
                "FROM select_course sc " +
                "JOIN student s ON sc.student_id = s.id " +
                "JOIN course c ON sc.course_id = c.id " +
                "LEFT JOIN teacher t ON c.teacher_id = t.id " +
                "WHERE sc.student_id = ? " +
                "ORDER BY sc.select_time DESC";
        return template.query(sql, new BeanPropertyRowMapper<>(SelectCourse.class), studentId);
    }

    @Override
    public SelectCourse checkSelected(Integer studentId, Integer courseId) {
        try {
            String sql = "SELECT * FROM select_course WHERE student_id = ? AND course_id = ?";
            return template.queryForObject(sql, new BeanPropertyRowMapper<>(SelectCourse.class), studentId, courseId);
        } catch (Exception e) {
            return null;
        }
    }

    @Override
    public void add(SelectCourse selectCourse) {
        String sql = "INSERT INTO select_course(student_id, course_id, select_time) VALUES(?, ?, ?)";
        template.update(sql,
                selectCourse.getStudentId(),
                selectCourse.getCourseId(),
                selectCourse.getSelectTime());
    }

    @Override
    public void delete(Integer studentId, Integer courseId) {
        String sql = "DELETE FROM select_course WHERE student_id = ? AND course_id = ?";
        template.update(sql, studentId, courseId);
    }

    @Override
    public List<SelectCourse> findAll() {
        String sql = "SELECT sc.id, sc.student_id, sc.course_id, sc.select_time, " +
                "s.name AS student_name, c.name AS course_name " +
                "FROM select_course sc " +
                "JOIN student s ON sc.student_id = s.id " +
                "JOIN course c ON sc.course_id = c.id " +
                "ORDER BY sc.select_time DESC";
        return template.query(sql, new BeanPropertyRowMapper<>(SelectCourse.class));
    }

    @Override
    public List<SelectCourse> findByPage(Integer start, Integer rows, String keyword) {
        String sql = "SELECT sc.id, sc.student_id, sc.course_id, sc.select_time, " +
                "s.name AS student_name, c.name AS course_name " +
                "FROM select_course sc " +
                "JOIN student s ON sc.student_id = s.id " +
                "JOIN course c ON sc.course_id = c.id " +
                "WHERE s.name LIKE ? OR c.name LIKE ? " +
                "ORDER BY sc.select_time DESC LIMIT ?, ?";

        String searchParam = "%" + (keyword != null ? keyword : "") + "%";
        return template.query(sql, new BeanPropertyRowMapper<>(SelectCourse.class),
                searchParam, searchParam, start, rows);
    }

    @Override
    public int findTotalCount(String keyword) {
        String sql = "SELECT COUNT(*) FROM select_course sc " +
                "JOIN student s ON sc.student_id = s.id " +
                "JOIN course c ON sc.course_id = c.id " +
                "WHERE s.name LIKE ? OR c.name LIKE ?";

        String searchParam = "%" + (keyword != null ? keyword : "") + "%";
        return template.queryForObject(sql, Integer.class, searchParam, searchParam);
    }

    @Override
    public int countDistinctCourses() {
        String sql = "SELECT COUNT(DISTINCT course_id) FROM select_course";
        Integer count = template.queryForObject(sql, Integer.class);
        return count != null ? count : 0;
    }

    @Override
    public int countDistinctStudents() {
        String sql = "SELECT COUNT(DISTINCT student_id) FROM select_course";
        Integer count = template.queryForObject(sql, Integer.class);
        return count != null ? count : 0;
    }
}