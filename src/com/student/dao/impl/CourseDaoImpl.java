package com.student.dao.impl;

import com.student.dao.CourseDao;
import com.student.domain.Course;
import com.student.util.JDBCUtils;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;

import java.util.List;

public class CourseDaoImpl implements CourseDao {
    private JdbcTemplate template = new JdbcTemplate(JDBCUtils.getDataSource());

    @Override
    public List<Course> findAll() {
        String sql = "SELECT c.*, t.name as teacherName FROM course c " +
                "LEFT JOIN teacher t ON c.teacher_id = t.id";
        return template.query(sql, new BeanPropertyRowMapper<>(Course.class));
    }

    @Override
    public Course findById(Integer id) {
        String sql = "SELECT c.*, t.name as teacherName FROM course c " +
                "LEFT JOIN teacher t ON c.teacher_id = t.id " +
                "WHERE c.id = ?";
        return template.queryForObject(sql, new BeanPropertyRowMapper<>(Course.class), id);
    }

    @Override
    public void add(Course course) {
        String sql = "INSERT INTO course(course_no, name, credit, teacher_id, description) " +
                "VALUES(?, ?, ?, ?, ?)";
        template.update(sql,
                course.getCourseNo(),
                course.getName(),
                course.getCredit(),
                course.getTeacherId(),
                course.getDescription());
    }

    @Override
    public void update(Course course) {
        String sql = "UPDATE course SET course_no = ?, name = ?, credit = ?, teacher_id = ?, description = ? " +
                "WHERE id = ?";
        template.update(sql,
                course.getCourseNo(),
                course.getName(),
                course.getCredit(),
                course.getTeacherId(),
                course.getDescription(),
                course.getId());
    }

    @Override
    public void delete(Integer id) {
        String sql = "DELETE FROM course WHERE id = ?";
        template.update(sql, id);
    }

    @Override
    public int count() {
        String sql = "SELECT COUNT(*) FROM course";
        Integer count = template.queryForObject(sql, Integer.class);
        return count != null ? count : 0;
    }

    @Override
    public List<Course> findByPage(Integer start, Integer rows, String keyword) {
        String sql = "SELECT c.*, t.name as teacherName FROM course c " +
                "LEFT JOIN teacher t ON c.teacher_id = t.id " +
                "WHERE c.course_no LIKE ? OR c.name LIKE ? OR t.name LIKE ? " +
                "LIMIT ?, ?";
        String searchParam = "%" + (keyword != null ? keyword : "") + "%";
        return template.query(sql, new BeanPropertyRowMapper<>(Course.class),
                searchParam, searchParam, searchParam, start, rows);
    }

    @Override
    public int findTotalCount(String keyword) {
        String sql = "SELECT COUNT(*) FROM course c " +
                "LEFT JOIN teacher t ON c.teacher_id = t.id " +
                "WHERE c.course_no LIKE ? OR c.name LIKE ? OR t.name LIKE ?";
        String searchParam = "%" + (keyword != null ? keyword : "") + "%";
        Integer count = template.queryForObject(sql, Integer.class, searchParam, searchParam, searchParam);
        return count != null ? count : 0;
    }
}