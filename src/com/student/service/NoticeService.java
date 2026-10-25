package com.student.service;

import com.student.domain.Notice;
import com.student.domain.PageBean;

import java.util.List;

public interface NoticeService {
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

    // 分页查询方法
    PageBean<Notice> findByPage(Integer currentPage, Integer rows, String keyword);

    // 批量删除公告
    void deleteBatch(Integer[] ids);
}