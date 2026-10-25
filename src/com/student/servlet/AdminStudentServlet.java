package com.student.servlet;

import com.student.domain.PageBean;
import com.student.domain.Student;
import com.student.service.StudentService;
import com.student.service.impl.StudentServiceImpl;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

@WebServlet("/admin/student/*")
public class AdminStudentServlet extends HttpServlet {
    private StudentService studentService = new StudentServiceImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doPost(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("utf-8");
        resp.setContentType("text/html;charset=utf-8");

        // 获取请求路径
        String uri = req.getRequestURI();
        String action = uri.substring(uri.lastIndexOf("/") + 1);

        // 权限校验（是否登录+是否管理员）
        if (req.getSession().getAttribute("admin") == null) {
            resp.sendRedirect(req.getContextPath() + "/login.jsp");
            return;
        }

        // 分发请求
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

    // 查询所有学生
    private void findAll(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // 获取分页参数
        String currentPageStr = req.getParameter("currentPage");
        String rowsStr = req.getParameter("rows");
        String keyword = req.getParameter("keyword");

        // 处理默认值
        int currentPage = 1;
        int rows = 5;
        if (currentPageStr != null && !"".equals(currentPageStr)) {
            currentPage = Integer.parseInt(currentPageStr);
        }
        if (rowsStr != null && !"".equals(rowsStr)) {
            rows = Integer.parseInt(rowsStr);
        }

        // 调用服务查询分页数据
        PageBean<Student> pb = studentService.findByPage(currentPage, rows, keyword);

        // 存储数据并转发
        req.setAttribute("pb", pb);
        req.setAttribute("keyword", keyword);
        req.getRequestDispatcher("/admin/studentList.jsp").forward(req, resp);
    }

    // 根据ID查询学生
    private void findById(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String idStr = req.getParameter("id");
        Integer id = Integer.parseInt(idStr);
        Student student = studentService.findById(id);
        // 获取操作类型
        String action = req.getParameter("action");
        if (action != null) {
            req.setAttribute("action", action);
        }
        req.setAttribute("student", student);
        req.getRequestDispatcher("/admin/studentEdit.jsp").forward(req, resp);
    }

    // 添加学生
    private void add(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        // 获取参数
        String studentNo = req.getParameter("studentNo");
        String name = req.getParameter("name");
        String password = req.getParameter("password");
        String gender = req.getParameter("gender");
        String ageStr = req.getParameter("age");
        Integer age = Integer.parseInt(ageStr);
        String phone = req.getParameter("phone");

        // 封装对象
        Student student = new Student();
        student.setStudentNo(studentNo);
        student.setName(name);
        student.setPassword(password);
        student.setGender(gender);
        student.setAge(age);
        student.setPhone(phone);

        // 调用服务
        studentService.add(student);

        // 重定向到列表页
        resp.sendRedirect(req.getContextPath() + "/admin/student/findAll");
    }

    // 修改学生
    private void update(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        // 获取参数
        String idStr = req.getParameter("id");
        Integer id = Integer.parseInt(idStr);
        String studentNo = req.getParameter("studentNo");
        String name = req.getParameter("name");
        String password = req.getParameter("password");
        String gender = req.getParameter("gender");
        String ageStr = req.getParameter("age");
        Integer age = Integer.parseInt(ageStr);
        String phone = req.getParameter("phone");

        // 封装对象
        Student student = new Student();
        student.setId(id);
        student.setStudentNo(studentNo);
        student.setName(name);
        student.setPassword(password);
        student.setGender(gender);
        student.setAge(age);
        student.setPhone(phone);

        // 调用服务
        studentService.update(student);

        // 重定向到列表页
        resp.sendRedirect(req.getContextPath() + "/admin/student/findAll");
    }

    // 删除学生
    private void delete(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        String idStr = req.getParameter("id");
        Integer id = Integer.parseInt(idStr);
        studentService.delete(id);
        resp.sendRedirect(req.getContextPath() + "/admin/student/findAll");
    }
}