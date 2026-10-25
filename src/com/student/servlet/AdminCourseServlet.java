package com.student.servlet;

import com.student.domain.Course;
import com.student.domain.PageBean;
import com.student.service.CourseService;
import com.student.service.impl.CourseServiceImpl;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

@WebServlet("/admin/course/*")
public class AdminCourseServlet extends HttpServlet {
    private CourseService courseService = new CourseServiceImpl();

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

        PageBean<Course> pb = courseService.findByPage(currentPage, rows, keyword);

        req.setAttribute("pb", pb);
        req.setAttribute("keyword", keyword);
        req.getRequestDispatcher("/admin/courseList.jsp").forward(req, resp);
    }

    private void findById(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String idStr = req.getParameter("id");
        Integer id = Integer.parseInt(idStr);
        Course course = courseService.findById(id);
        // 获取操作类型（view 或 edit）
        String action = req.getParameter("action");
        if (action != null) {
            req.setAttribute("action", action);
        }
        req.setAttribute("course", course);
        req.getRequestDispatcher("/admin/courseEdit.jsp").forward(req, resp);
    }

    private void add(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        String courseNo = req.getParameter("courseNo");
        String name = req.getParameter("name");
        String creditStr = req.getParameter("credit");
        Integer credit = Integer.parseInt(creditStr);
        String teacherIdStr = req.getParameter("teacherId");
        Integer teacherId = Integer.parseInt(teacherIdStr);
        String description = req.getParameter("description");

        Course course = new Course();
        course.setCourseNo(courseNo);
        course.setName(name);
        course.setCredit(credit);
        course.setTeacherId(teacherId);
        course.setDescription(description);

        courseService.add(course);
        resp.sendRedirect(req.getContextPath() + "/admin/course/findAll");
    }

    private void update(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        String idStr = req.getParameter("id");
        Integer id = Integer.parseInt(idStr);
        String courseNo = req.getParameter("courseNo");
        String name = req.getParameter("name");
        String creditStr = req.getParameter("credit");
        Integer credit = Integer.parseInt(creditStr);
        String teacherIdStr = req.getParameter("teacherId");
        Integer teacherId = Integer.parseInt(teacherIdStr);
        String description = req.getParameter("description");

        Course course = new Course();
        course.setId(id);
        course.setCourseNo(courseNo);
        course.setName(name);
        course.setCredit(credit);
        course.setTeacherId(teacherId);
        course.setDescription(description);

        courseService.update(course);
        resp.sendRedirect(req.getContextPath() + "/admin/course/findAll");
    }

    private void delete(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        String idStr = req.getParameter("id");
        Integer id = Integer.parseInt(idStr);
        courseService.delete(id);
        resp.sendRedirect(req.getContextPath() + "/admin/course/findAll");
    }
}