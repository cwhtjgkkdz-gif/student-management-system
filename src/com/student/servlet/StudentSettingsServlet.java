package com.student.servlet;

import com.student.domain.Student;
import com.student.service.StudentService;
import com.student.service.impl.StudentServiceImpl;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet("/student/settings")
public class StudentSettingsServlet extends HttpServlet {
    private StudentService studentService = new StudentServiceImpl();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        Student student = (Student) session.getAttribute("student");

        if (student == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        request.setAttribute("student", student);
        request.getRequestDispatcher("/student/settings.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        Student student = (Student) session.getAttribute("student");

        if (student == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        String action = request.getParameter("action");

        switch (action) {
            case "changePassword":
                handleChangePassword(request, response, student);
                break;
            case "deactivate":
                handleDeactivateAccount(request, response, student);
                break;
            default:
                response.sendRedirect(request.getContextPath() + "/student/settings");
                break;
        }
    }

    private void handleChangePassword(HttpServletRequest request, HttpServletResponse response, Student student)
            throws ServletException, IOException {
        String oldPassword = request.getParameter("oldPassword");
        String newPassword = request.getParameter("newPassword");
        String confirmPassword = request.getParameter("confirmPassword");

        if (newPassword == null || !newPassword.equals(confirmPassword)) {
            request.setAttribute("error", "新密码和确认密码不一致！");
            request.setAttribute("student", student);
            request.getRequestDispatcher("/student/settings.jsp").forward(request, response);
            return;
        }

        boolean success = studentService.changePassword(student.getId(), oldPassword, newPassword);

        if (success) {
            request.getSession().invalidate();
            response.sendRedirect(request.getContextPath() + "/login.jsp?message=密码修改成功，请重新登录");
        } else {
            request.setAttribute("error", "旧密码不正确！");
            request.setAttribute("student", student);
            request.getRequestDispatcher("/student/settings.jsp").forward(request, response);
        }
    }

    private void handleDeactivateAccount(HttpServletRequest request, HttpServletResponse response, Student student)
            throws ServletException, IOException {
        String password = request.getParameter("password");

        boolean success = studentService.deactivateAccount(student.getId(), password);

        if (success) {
            request.getSession().invalidate();
            response.sendRedirect(request.getContextPath() + "/login.jsp?message=账户已成功注销");
        } else {
            request.setAttribute("error", "密码不正确，注销失败！");
            request.setAttribute("student", student);
            request.getRequestDispatcher("/student/settings.jsp").forward(request, response);
        }
    }
}