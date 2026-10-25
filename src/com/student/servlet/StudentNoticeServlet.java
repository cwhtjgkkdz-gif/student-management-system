package com.student.servlet;

import com.student.domain.Student;
import com.student.service.NoticeService;
import com.student.service.impl.NoticeServiceImpl;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/student/notice/*")
public class StudentNoticeServlet extends HttpServlet {
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
        Student student = (Student) req.getSession().getAttribute("student");
        if (student == null) {
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
            default:
                resp.sendRedirect(req.getContextPath() + "/student/error.jsp");
        }
    }

    // 查询所有公告
    private void findAll(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setAttribute("notices", noticeService.findAll());
        req.setAttribute("noticeCount",noticeService.count());
        req.getRequestDispatcher("/student/noticeList.jsp").forward(req, resp);
    }

    // 根据ID查看公告详情
    private void findById(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String idStr = req.getParameter("id");
        Integer id = Integer.parseInt(idStr);
        req.setAttribute("notice", noticeService.findById(id));
        req.getRequestDispatcher("/student/noticeDetail.jsp").forward(req, resp);
    }
}