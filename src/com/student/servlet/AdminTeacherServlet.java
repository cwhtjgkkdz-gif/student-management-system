package com.student.servlet;

import com.student.domain.PageBean;
import com.student.domain.Teacher;
import com.student.service.TeacherService;
import com.student.service.impl.TeacherServiceImpl;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

@WebServlet("/admin/teacher/*")
public class AdminTeacherServlet extends HttpServlet {
    private TeacherService teacherService = new TeacherServiceImpl();

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
            default:
                resp.sendRedirect(req.getContextPath() + "/admin/error.jsp");
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

        PageBean<Teacher> pb = teacherService.findByPage(currentPage, rows, keyword);

        req.setAttribute("pb", pb);
        req.setAttribute("keyword", keyword);
        req.getRequestDispatcher("/admin/teacherList.jsp").forward(req, resp);
    }

    private void findById(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String idStr = req.getParameter("id");
        Integer id = Integer.parseInt(idStr);
        Teacher teacher = teacherService.findById(id);
        // 获取操作类型（view 或 edit）
        String action = req.getParameter("action");
        if (action != null) {
            req.setAttribute("action", action);
        }
        req.setAttribute("teacher", teacher);
        req.getRequestDispatcher("/admin/teacherEdit.jsp").forward(req, resp);
    }

    private void add(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        String teacherNo = req.getParameter("teacherNo");
        String name = req.getParameter("name");
        String gender = req.getParameter("gender");
        String subject = req.getParameter("subject");
        String phone = req.getParameter("phone");

        Teacher teacher = new Teacher();
        teacher.setTeacherNo(teacherNo);
        teacher.setName(name);
        teacher.setGender(gender);
        teacher.setSubject(subject);
        teacher.setPhone(phone);

        teacherService.add(teacher);
        resp.sendRedirect(req.getContextPath() + "/admin/teacher/findAll");
    }

    private void update(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        String idStr = req.getParameter("id");
        Integer id = Integer.parseInt(idStr);
        String teacherNo = req.getParameter("teacherNo");
        String name = req.getParameter("name");
        String gender = req.getParameter("gender");
        String subject = req.getParameter("subject");
        String phone = req.getParameter("phone");

        Teacher teacher = new Teacher();
        teacher.setId(id);
        teacher.setTeacherNo(teacherNo);
        teacher.setName(name);
        teacher.setGender(gender);
        teacher.setSubject(subject);
        teacher.setPhone(phone);

        teacherService.update(teacher);
        resp.sendRedirect(req.getContextPath() + "/admin/teacher/findAll");
    }

    private void delete(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        String idStr = req.getParameter("id");
        Integer id = Integer.parseInt(idStr);
        teacherService.delete(id);
        resp.sendRedirect(req.getContextPath() + "/admin/teacher/findAll");
    }
}