package com.student.domain;

import java.util.List;

public class PageBean<T> {
    private int currentPage; // 当前页码
    private int rows;        // 每页条数
    private int totalCount;  // 总记录数
    private int totalPage;   // 总页数
    private List<T> list;    // 当前页数据列表

    // 构造方法
    public PageBean() {
        this.currentPage = 1;
        this.rows = 5;
    }

    public void setTotalCount(int totalCount) {
        this.totalCount = totalCount;
        this.totalPage = (totalCount + rows - 1) / rows;
    }

    public int getCurrentPage() { return currentPage; }
    public void setCurrentPage(int currentPage) { this.currentPage = currentPage; }
    public int getRows() { return rows; }
    public void setRows(int rows) { this.rows = rows; }
    public int getTotalCount() { return totalCount; }
    public int getTotalPage() { return totalPage; }
    public List<T> getList() { return list; }
    public void setList(List<T> list) { this.list = list; }
}