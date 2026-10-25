package com.student.dao.impl;

import com.student.dao.NoticeDao;
import com.student.domain.Notice;
import com.student.util.JDBCUtils;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;

import java.util.List;

public class NoticeDaoImpl implements NoticeDao {
    private JdbcTemplate template = new JdbcTemplate(JDBCUtils.getDataSource());

    @Override
    public List<Notice> findAll() {
        String sql = "SELECT * FROM notice ORDER BY create_time DESC";
        return template.query(sql, new BeanPropertyRowMapper<>(Notice.class));
    }

    @Override
    public Notice findById(Integer id) {
        String sql = "SELECT * FROM notice WHERE id = ?";
        return template.queryForObject(sql, new BeanPropertyRowMapper<>(Notice.class), id);
    }

    @Override
    public void add(Notice notice) {
        String sql = "INSERT INTO notice(title, content, create_time) VALUES(?, ?, ?)";
        template.update(sql,
                notice.getTitle(),
                notice.getContent(),
                notice.getCreateTime());
    }

    @Override
    public void update(Notice notice) {
        String sql = "UPDATE notice SET title = ?, content = ?, create_time = ? WHERE id = ?";
        template.update(sql,
                notice.getTitle(),
                notice.getContent(),
                notice.getCreateTime(),
                notice.getId());
    }

    @Override
    public void delete(Integer id) {
        String sql = "DELETE FROM notice WHERE id = ?";
        template.update(sql, id);
    }

    @Override
    public int count() {
        String sql = "SELECT COUNT(*) FROM notice";
        Integer count = template.queryForObject(sql, Integer.class);
        return count != null ? count : 0;
    }
    @Override
    public List<Notice> findByPage(Integer start, Integer rows, String keyword) {
        String sql = "SELECT * FROM notice WHERE title LIKE ? OR content LIKE ? ORDER BY create_time DESC LIMIT ?, ?";
        String searchParam = "%" + (keyword != null ? keyword : "") + "%";
        return template.query(sql, new BeanPropertyRowMapper<>(Notice.class),
                searchParam, searchParam, start, rows);
    }

    @Override
    public int findTotalCount(String keyword) {
        String sql = "SELECT COUNT(*) FROM notice WHERE title LIKE ? OR content LIKE ?";
        String searchParam = "%" + (keyword != null ? keyword : "") + "%";
        Integer count = template.queryForObject(sql, Integer.class, searchParam, searchParam);
        return count != null ? count : 0;
    }

    @Override
    public void deleteBatch(Integer[] ids) {
        if (ids == null || ids.length == 0) {
            return;
        }

        // 构建IN语句的参数占位符
        StringBuilder sqlBuilder = new StringBuilder("DELETE FROM notice WHERE id IN (");
        for (int i = 0; i < ids.length; i++) {
            sqlBuilder.append("?");
            if (i < ids.length - 1) {
                sqlBuilder.append(",");
            }
        }
        sqlBuilder.append(")");

        template.update(sqlBuilder.toString(), ids);
    }
}