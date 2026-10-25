package com.student.servlet;

import com.student.domain.Notice;
import com.student.domain.PageBean;
import com.student.service.NoticeService;
import com.student.service.impl.NoticeServiceImpl;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.Date;
import java.util.List;

@WebServlet("/admin/notice/*")
public class AdminNoticeServlet extends HttpServlet {
    private NoticeService noticeService = new NoticeServiceImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doPost(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("utf-8");
        resp.setContentType("text/html;charset=utf-8");

        // 权限校验
        if (req.getSession().getAttribute("admin") == null) {
            resp.sendRedirect(req.getContextPath() + "/login.jsp");
            return;
        }

        // 分发请求
        String uri = req.getRequestURI();
        String action = uri.substring(uri.lastIndexOf("/") + 1);
        switch (action) {
            case "findAll":
                findAll(req, resp);
                break;
            case "findById":
                findById(req, resp);
                break;
            case "add":
                add(req, resp);
                break;
            case "update":
                update(req, resp);
                break;
            case "delete":
                delete(req, resp);
                break;
            case "deleteBatch":  // 新增批量删除
                deleteBatch(req, resp);
                break;
            default:
                resp.sendRedirect(req.getContextPath() + "/error/404.jsp");
        }
    }

    private void findAll(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String currentPageStr = req.getParameter("currentPage");
        String rowsStr = req.getParameter("rows");
        String keyword = req.getParameter("keyword");

        int currentPage = 1;
        int rows = 5;
        if (currentPageStr != null && !"".equals(currentPageStr)) {
            currentPage = Integer.parseInt(currentPageStr);
        }
        if (rowsStr != null && !"".equals(rowsStr)) {
            rows = Integer.parseInt(rowsStr);
        }

        PageBean<Notice> pb = noticeService.findByPage(currentPage, rows, keyword);

        req.setAttribute("pb", pb);
        req.setAttribute("keyword", keyword);
        req.getRequestDispatcher("/admin/noticeList.jsp").forward(req, resp);
    }

    private void findById(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String idStr = req.getParameter("id");
        Integer id = Integer.parseInt(idStr);
        Notice notice = noticeService.findById(id);
        // 获取操作类型（view 或 edit）
        String action = req.getParameter("action");
        if (action != null) {
            req.setAttribute("action", action);
        }
        req.setAttribute("notice", notice);
        req.getRequestDispatcher("/admin/noticeEdit.jsp").forward(req, resp);
    }

    private void add(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        String title = req.getParameter("title");
        String content = req.getParameter("content");

        Notice notice = new Notice();
        notice.setTitle(title);
        notice.setContent(content);
        notice.setCreateTime(new Date());

        noticeService.add(notice);
        resp.sendRedirect(req.getContextPath() + "/admin/notice/findAll");
    }

    private void update(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        String idStr = req.getParameter("id");
        Integer id = Integer.parseInt(idStr);
        String title = req.getParameter("title");
        String content = req.getParameter("content");

        Notice notice = new Notice();
        notice.setId(id);
        notice.setTitle(title);
        notice.setContent(content);
        notice.setCreateTime(new Date());

        noticeService.update(notice);
        resp.sendRedirect(req.getContextPath() + "/admin/notice/findAll");
    }

    private void delete(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        String idStr = req.getParameter("id");
        Integer id = Integer.parseInt(idStr);
        noticeService.delete(id);
        resp.sendRedirect(req.getContextPath() + "/admin/notice/findAll");
    }

    // 添加批量删除方法
    private void deleteBatch(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        String[] idArray = req.getParameterValues("ids");
        if (idArray == null || idArray.length == 0) {
            resp.sendRedirect(req.getContextPath() + "/admin/notice/findAll");
            return;
        }

        try {
            // 转换为Integer数组
            Integer[] ids = new Integer[idArray.length];
            for (int i = 0; i < idArray.length; i++) {
                ids[i] = Integer.parseInt(idArray[i]);
            }

            // 调用批量删除服务
            noticeService.deleteBatch(ids);

            // 重定向回列表页
            resp.sendRedirect(req.getContextPath() + "/admin/notice/findAll");
        } catch (NumberFormatException e) {
            resp.sendRedirect(req.getContextPath() + "/admin/notice/findAll");
        }
    }
}