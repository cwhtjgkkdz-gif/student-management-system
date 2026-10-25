package com.student.servlet;

import com.student.domain.Admin;
import com.student.domain.Student;
import com.student.service.LoginService;
import com.student.service.impl.LoginServiceImpl;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet("/loginServlet")
public class LoginServlet extends HttpServlet {
    private LoginService loginService = new LoginServiceImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doPost(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("utf-8");
        resp.setContentType("text/html;charset=utf-8");

        String username = req.getParameter("username");
        String password = req.getParameter("password");
        String role = req.getParameter("role");
        String inputCheckCode = req.getParameter("checkCode");
        HttpSession session = req.getSession();

        // ========== 1. 基础空值校验 ==========
        if (username == null || username.trim().isEmpty()) {
            req.setAttribute("error", "请输入用户名/学号！");
            req.getRequestDispatcher("/login.jsp").forward(req, resp);
            return;
        }
        if (password == null || password.trim().isEmpty()) {
            req.setAttribute("error", "请输入密码！");
            req.getRequestDispatcher("/login.jsp").forward(req, resp);
            return;
        }
        if (role == null || (!"admin".equals(role) && !"student".equals(role))) {
            req.setAttribute("error", "请选择正确的角色！");
            req.getRequestDispatcher("/login.jsp").forward(req, resp);
            return;
        }

        // ========== 2. 验证码校验 ==========
        String sessionCheckCode = (String) session.getAttribute("checkCode_session");
        Long codeTime = (Long) session.getAttribute("checkCode_time");
        Integer errorCount = (Integer) session.getAttribute("login_error_count");

        if (codeTime != null) {
            long currentTime = System.currentTimeMillis();
            // 设置5分钟有效期
            if (currentTime - codeTime > 5 * 60 * 1000) {
                session.removeAttribute("checkCode_session");
                session.removeAttribute("checkCode_time");
                req.setAttribute("error", "验证码已过期，请刷新重试！");
                req.getRequestDispatcher("/login.jsp").forward(req, resp);
                return;
            }
        }
        if (sessionCheckCode == null) {
            req.setAttribute("error", "验证码已过期，请刷新重试！");
            req.getRequestDispatcher("/login.jsp").forward(req, resp);
            return;
        }

        if (inputCheckCode == null || inputCheckCode.trim().isEmpty()) {
            req.setAttribute("error", "请输入验证码！");
            req.getRequestDispatcher("/login.jsp").forward(req, resp);
            return;
        }

        if (!sessionCheckCode.equalsIgnoreCase(inputCheckCode.trim())) {
            req.setAttribute("error", "验证码错误！");
            // 移除错误验证码，防止暴力破解
            session.removeAttribute("checkCode_session");
            req.getRequestDispatcher("/login.jsp").forward(req, resp);
            return;
        }
        // 录错误次数
        if (errorCount == null) errorCount = 0;

        if (!sessionCheckCode.equalsIgnoreCase(inputCheckCode.trim())) {
            errorCount++;
            session.setAttribute("login_error_count", errorCount);

            // 错误超过3次需要刷新验证码
            if (errorCount >= 3) {
                session.removeAttribute("checkCode_session");
                req.setAttribute("error", "验证码错误次数过多，请刷新验证码！");
            } else {
                req.setAttribute("error", "验证码错误！");
            }
            req.getRequestDispatcher("/login.jsp").forward(req, resp);
            return;
        }
        // 验证成功时重置错误计数
        session.removeAttribute("login_error_count");

        // ========== 3. 验证成功后立即移除验证码 ==========

        session.removeAttribute("checkCode_session");

        // ========== 4. 后续登录逻辑... ==========

        if ("admin".equals(role)) {
            // 管理员登录
            Admin admin = loginService.adminLogin(username, password);
            if (admin != null) {
                // 登录成功，存入Session
                session.setAttribute("admin", admin);
                session.setAttribute("role", "admin");
                resp.sendRedirect(req.getContextPath() + "/admin/countServlet");
            } else {
                // 登录失败
                req.setAttribute("loginMsg", "用户名或密码错误！");
                req.getRequestDispatcher("/login.jsp").forward(req, resp);
            }
        } else if ("student".equals(role)) {
            // 学生登录
            Student student = loginService.studentLogin(username, password);
            if (student != null) {
                // 登录成功，存入Session
                session.setAttribute("student", student);
                session.setAttribute("role", "student");
                resp.sendRedirect(req.getContextPath() + "/student/countServlet");
            } else {
                // 登录失败
                req.setAttribute("loginMsg", "学号或密码错误！");
                req.getRequestDispatcher("/login.jsp").forward(req, resp);
            }
        } else {
            // 角色错误
            req.setAttribute("loginMsg", "请选择正确的角色！");
            req.getRequestDispatcher("/login.jsp").forward(req, resp);
        }
    }
}