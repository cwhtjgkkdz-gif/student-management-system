package com.student.dao.impl;

import com.student.dao.AdminDao;
import com.student.domain.Admin;
import com.student.util.JDBCUtils;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;

public class AdminDaoImpl implements AdminDao {
    private JdbcTemplate template = new JdbcTemplate(JDBCUtils.getDataSource());

    @Override
    public Admin findByUsernameAndPassword(String username, String password) {
        try {
            String sql = "SELECT * FROM admin WHERE username = ? AND password = ?";
            return template.queryForObject(sql,
                    new BeanPropertyRowMapper<>(Admin.class),
                    username, password);
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }
}