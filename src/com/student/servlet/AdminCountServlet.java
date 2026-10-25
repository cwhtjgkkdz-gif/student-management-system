package com.student.servlet;

import com.student.service.CourseService;
import com.student.service.NoticeService;
import com.student.service.StudentService;
import com.student.service.TeacherService;
import com.student.service.impl.CourseServiceImpl;
import com.student.service.impl.NoticeServiceImpl;
import com.student.service.impl.StudentServiceImpl;
import com.student.service.impl.TeacherServiceImpl;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
@WebServlet("/admin/countServlet")
public class AdminCountServlet extends HttpServlet {
    private StudentService studentService = new StudentServiceImpl();
    private TeacherService teacherService = new TeacherServiceImpl();
    private CourseService courseService = new CourseServiceImpl();
    private NoticeService noticeService = new NoticeServiceImpl();
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        int studentCount = studentService.count();
        int teacherCount = teacherService.count();
        int courseCount = courseService.count();
        int noticeCount = noticeService.count();
        req.setAttribute("studentCount",studentCount);
        req.setAttribute("teacherCount",teacherCount);
        req.setAttribute("courseCount",courseCount);
        req.setAttribute("noticeCount",noticeCount);
        req.getRequestDispatcher("/admin/index.jsp").forward(req,resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        this.doGet(req, resp);
    }
}
