package com.student.dao.impl;

import com.student.dao.StudentDao;
import com.student.domain.Student;
import com.student.util.JDBCUtils;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import java.util.List;

public class StudentDaoImpl implements StudentDao {
    private JdbcTemplate template = new JdbcTemplate(JDBCUtils.getDataSource());

    @Override
    public Student findByStudentNoAndPassword(String studentNo, String password) {
        try {
            String sql = "SELECT * FROM student WHERE student_no = ? AND password = ?";
            return template.queryForObject(sql,
                    new BeanPropertyRowMapper<>(Student.class),
                    studentNo, password);
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

    @Override
    public List<Student> findAll() {
        String sql = "SELECT * FROM student";
        return template.query(sql, new BeanPropertyRowMapper<>(Student.class));
    }

    @Override
    public Student findById(Integer id) {
        String sql = "SELECT * FROM student WHERE id = ?";
        try {
            return template.queryForObject(sql, new BeanPropertyRowMapper<>(Student.class), id);
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

    @Override
    public void add(Student student) {
        String sql = "INSERT INTO student(student_no, name, password, gender, age, phone) " +
                "VALUES(?, ?, ?, ?, ?, ?)";
        template.update(sql,
                student.getStudentNo(),
                student.getName(),
                student.getPassword(),
                student.getGender(),
                student.getAge(),
                student.getPhone());
    }

    @Override
    public void update(Student student) {
        String sql = "UPDATE student SET student_no = ?, name = ?, password = ?, gender = ?, age = ?, phone = ? " +
                "WHERE id = ?";
        template.update(sql,
                student.getStudentNo(),
                student.getName(),
                student.getPassword(),
                student.getGender(),
                student.getAge(),
                student.getPhone(),
                student.getId());
    }

    @Override
    public void delete(Integer id) {
        String sql = "DELETE FROM student WHERE id = ?";
        template.update(sql, id);
    }

    @Override
    public int count() {
        String sql = "SELECT COUNT(*) FROM student";
        Integer count = template.queryForObject(sql, Integer.class);
        return count != null ? count : 0;
    }

    @Override
    public List<Student> findByPage(Integer start, Integer rows, String keyword) {
        String sql = "SELECT * FROM student WHERE student_no LIKE ? OR name LIKE ? LIMIT ?, ?";
        String searchParam = "%" + (keyword != null ? keyword : "") + "%";
        return template.query(sql, new BeanPropertyRowMapper<>(Student.class),
                searchParam, searchParam, start, rows);
    }

    @Override
    public int findTotalCount(String keyword) {
        String sql = "SELECT COUNT(*) FROM student WHERE student_no LIKE ? OR name LIKE ?";
        String searchParam = "%" + (keyword != null ? keyword : "") + "%";
        Integer count = template.queryForObject(sql, Integer.class, searchParam, searchParam);
        return count != null ? count : 0;
    }

    // ============ 实现新增方法 ============

    @Override
    public boolean updatePassword(Integer id, String newPassword) {
        try {
            String sql = "UPDATE student SET password = ? WHERE id = ?";
            int rows = template.update(sql, newPassword, id);
            return rows > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    @Override
    public boolean isStudentNoExists(String studentNo) {
        try {
            String sql = "SELECT COUNT(*) FROM student WHERE student_no = ?";
            Integer count = template.queryForObject(sql, Integer.class, studentNo);
            return count != null && count > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    @Override
    public Student findByStudentNo(String studentNo) {
        try {
            String sql = "SELECT * FROM student WHERE student_no = ?";
            return template.queryForObject(sql, new BeanPropertyRowMapper<>(Student.class), studentNo);
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }
}