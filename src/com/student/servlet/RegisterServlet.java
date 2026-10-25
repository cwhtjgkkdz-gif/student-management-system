package com.student.servlet;

import com.student.domain.Student;
import com.student.service.StudentService;
import com.student.service.impl.StudentServiceImpl;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/register")
public class RegisterServlet extends HttpServlet {
    private StudentService studentService = new StudentServiceImpl();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // 获取参数
        String studentNo = request.getParameter("studentNo");
        String name = request.getParameter("name");
        String password = request.getParameter("password");
        String confirmPassword = request.getParameter("confirmPassword");
        String gender = request.getParameter("gender");
        String ageStr = request.getParameter("age");
        String phone = request.getParameter("phone");

        // 基本验证
        if (studentNo == null || studentNo.trim().isEmpty() ||
                name == null || name.trim().isEmpty() ||
                password == null || password.trim().isEmpty()) {
            request.setAttribute("error", "请填写所有必填字段！");
            request.getRequestDispatcher("/student/register.jsp").forward(request, response);
            return;
        }

        // 验证密码和确认密码
        if (!password.equals(confirmPassword)) {
            request.setAttribute("error", "两次输入的密码不一致！");
            request.getRequestDispatcher("/student/register.jsp").forward(request, response);
            return;
        }

        // 检查密码长度
        if (password.length() < 6) {
            request.setAttribute("error", "密码长度至少6位！");
            request.getRequestDispatcher("/student/register.jsp").forward(request, response);
            return;
        }

        // 检查学号是否已存在
        if (studentService.isStudentNoExists(studentNo)) {
            request.setAttribute("error", "该学号已被注册！");
            request.getRequestDispatcher("/student/register.jsp").forward(request, response);
            return;
        }

        // 创建学生对象
        Student student = new Student();
        student.setStudentNo(studentNo);
        student.setName(name);
        student.setPassword(password);
        student.setGender(gender != null ? gender : "男");

        try {
            student.setAge(Integer.parseInt(ageStr));
        } catch (NumberFormatException e) {
            student.setAge(18); // 默认年龄
        }

        student.setPhone(phone);

        // 注册用户
        boolean success = studentService.register(student);

        if (success) {
            // 注册成功，跳转到登录页面
            response.sendRedirect(request.getContextPath() + "/login.jsp?message=注册成功，请登录");
        } else {
            request.setAttribute("error", "注册失败，请稍后重试！");
            request.getRequestDispatcher("/student/register.jsp").forward(request, response);
        }
    }
}