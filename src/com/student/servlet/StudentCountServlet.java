package com.student.servlet;

import com.student.domain.SelectCourse;
import com.student.service.*;
import com.student.service.impl.*;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.List;

@WebServlet("/student/countServlet")
public class StudentCountServlet extends HttpServlet {
    private CourseService courseService = new CourseServiceImpl();
    private NoticeService noticeService = new NoticeServiceImpl();
    private SelectCourseService selectCourseService = new SelectCourseServiceImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // 获取session中的学生ID
        HttpSession session = req.getSession();
        Integer studentId = (Integer) session.getAttribute("studentId");

        // 如果session中没有学生ID
        if (studentId == null) {
            Object studentObj = session.getAttribute("student");
            if (studentObj != null) {
                try {
                    studentId = (Integer) studentObj.getClass().getMethod("getId").invoke(studentObj);
                } catch (Exception e) {
                    e.printStackTrace();
                }
            }
        }

        // 获取各项统计数据
        int courseCount = courseService.count();
        int noticeCount = noticeService.count();
        int selectedCourseCount = 0;
        int totalCredits = 0;

        // 如果学生ID不为空，则获取该学生的统计数据
        if (studentId != null) {
            // 获取已选课程数
            List<SelectCourse> selectedCourses = selectCourseService.findByStudentId(studentId);
            selectedCourseCount = selectedCourses.size();

            // 获取总学分
            totalCredits = selectCourseService.calculateTotalCredits(studentId);
        }

        // 设置属性到request
        req.setAttribute("courseCount", courseCount);
        req.setAttribute("noticeCount", noticeCount);
        req.setAttribute("selectedCourseCount", selectedCourseCount);
        req.setAttribute("totalCredits", totalCredits);

        // 转发到index.jsp
        req.getRequestDispatcher("/student/index.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        this.doGet(req, resp);
    }
}