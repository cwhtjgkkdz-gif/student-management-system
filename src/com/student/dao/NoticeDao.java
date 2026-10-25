package com.student.dao;

import com.student.domain.Notice;
import java.util.List;

public interface NoticeDao {
    // 查询所有公告
    List<Notice> findAll();

    // 根据ID查询公告
    Notice findById(Integer id);

    // 添加公告
    void add(Notice notice);

    // 修改公告
    void update(Notice notice);

    // 删除公告
    void delete(Integer id);
    int count();

    // 添加分页和搜索方法
    List<Notice> findByPage(Integer start, Integer rows, String keyword);
    int findTotalCount(String keyword);

    // 批量删除公告
    void deleteBatch(Integer[] ids);
}