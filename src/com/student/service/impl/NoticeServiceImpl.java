package com.student.service.impl;

import com.student.dao.NoticeDao;
import com.student.dao.impl.NoticeDaoImpl;
import com.student.domain.Notice;
import com.student.domain.PageBean;
import com.student.service.NoticeService;
import java.util.List;

public class NoticeServiceImpl implements NoticeService {
    private NoticeDao noticeDao = new NoticeDaoImpl();

    @Override
    public List<Notice> findAll() {
        return noticeDao.findAll();
    }

    @Override
    public Notice findById(Integer id) {
        return noticeDao.findById(id);
    }

    @Override
    public void add(Notice notice) {
        noticeDao.add(notice);
    }

    @Override
    public void update(Notice notice) {
        noticeDao.update(notice);
    }

    @Override
    public void delete(Integer id) {
        noticeDao.delete(id);
    }

    @Override
    public int count() {
        return noticeDao.count();
    }

    @Override
    public PageBean<Notice> findByPage(Integer currentPage, Integer rows, String keyword) {
        PageBean<Notice> pb = new PageBean<>();
        pb.setCurrentPage(currentPage);
        pb.setRows(rows);

        int totalCount = noticeDao.findTotalCount(keyword);
        pb.setTotalCount(totalCount);

        int start = (currentPage - 1) * rows;
        List<Notice> list = noticeDao.findByPage(start, rows, keyword);
        pb.setList(list);

        return pb;
    }

    @Override
    public void deleteBatch(Integer[] ids) {
        noticeDao.deleteBatch(ids);
    }
}