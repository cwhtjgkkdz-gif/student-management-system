package com.student.filter;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebFilter("/*")
public class LoginFilter implements Filter {

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
        // 初始化操作
    }

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {
        HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse resp = (HttpServletResponse) response;

        req.setCharacterEncoding("UTF-8");
        resp.setContentType("text/html;charset=UTF-8");

        // 获取请求路径
        String path = req.getRequestURI();

        // 前提资源
        if (path.contains("/login.jsp") ||
                path.contains("/loginServlet") ||
                path.contains("/css/") ||
                path.contains("/js/") ||
                path.contains("/fonts/") ||
                path.contains("/student/register.jsp") || path.contains("/register")) {
            chain.doFilter(req, resp);
            return;
        }

        // 权限控制
        HttpSession session = req.getSession();
        Object admin = session.getAttribute("admin");
        Object student = session.getAttribute("student");

        // 管理员
        if (path.contains("/admin/")) {
            if (admin != null) {
                chain.doFilter(req, resp);
            } else {
                resp.sendRedirect(req.getContextPath() + "/login.jsp");
            }
        }
        // 学生
        else if (path.contains("/student/")) {
            if (student != null) {
                chain.doFilter(req, resp);
            } else {
                resp.sendRedirect(req.getContextPath() + "/login.jsp");
            }
        }
        // 其他
        else {
            chain.doFilter(req, resp);
        }
    }

    @Override
    public void destroy() {
        // 销毁操作
    }
}