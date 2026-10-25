// 首先补全类定义
package com.student.servlet;

import com.student.domain.PageBean;
import com.student.domain.SelectCourse;
import com.student.service.SelectCourseService;
import com.student.service.impl.SelectCourseServiceImpl;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/admin/selectCourse/*")
public class AdminSelectCourseServlet extends HttpServlet {
    private SelectCourseService selectCourseService = new SelectCourseServiceImpl();

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
            case "delete":
                delete(req, resp);
                break;
            default:
                resp.sendRedirect(req.getContextPath() + "/error/404.jsp");
        }
    }

    private void findAll(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String currentPageStr = req.getParameter("currentPage");
        String rowsStr = req.getParameter("rows");
        String keyword = req.getParameter("keyword");
        int distinctStudents = selectCourseService.countDistinctStudents();
        int distinctCourses = selectCourseService.countDistinctCourses();

        int currentPage = 1;
        int rows = 5;
        if (currentPageStr != null && !"".equals(currentPageStr)) {
            currentPage = Integer.parseInt(currentPageStr);
        }
        if (rowsStr != null && !"".equals(rowsStr)) {
            rows = Integer.parseInt(rowsStr);
        }

        PageBean<SelectCourse> pb = selectCourseService.findByPage(currentPage, rows, keyword);

        req.setAttribute("pb", pb);
        req.setAttribute("keyword", keyword);
        req.setAttribute("distinctStudents", distinctStudents);
        req.setAttribute("distinctCourses", distinctCourses);
        req.getRequestDispatcher("/admin/selectCourseList.jsp").forward(req, resp);
    }

    private void delete(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        String studentIdStr = req.getParameter("studentId");
        String courseIdStr = req.getParameter("courseId");
        Integer studentId = Integer.parseInt(studentIdStr);
        Integer courseId = Integer.parseInt(courseIdStr);

        selectCourseService.dropCourse(studentId, courseId);
        resp.sendRedirect(req.getContextPath() + "/admin/selectCourse/findAll");
    }
}