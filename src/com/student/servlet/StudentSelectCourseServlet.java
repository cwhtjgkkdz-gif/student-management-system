package com.student.servlet;

import com.student.domain.*;
import com.student.service.CourseService;
import com.student.service.SelectCourseService;
import com.student.service.TeacherService;
import com.student.service.impl.CourseServiceImpl;
import com.student.service.impl.SelectCourseServiceImpl;
import com.student.service.impl.TeacherServiceImpl;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

@WebServlet("/student/selectCourse/*")
public class StudentSelectCourseServlet extends HttpServlet {
    private SelectCourseService selectCourseService = new SelectCourseServiceImpl();
    private CourseService courseService = new CourseServiceImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doPost(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("utf-8");
        resp.setContentType("application/json;charset=utf-8");

        // 权限校验
        Student student = (Student) req.getSession().getAttribute("student");
        if (student == null) {
            resp.sendRedirect(req.getContextPath() + "/login.jsp");
            return;
        }

        // 分发请求
        String uri = req.getRequestURI();
        String action = uri.substring(uri.lastIndexOf("/") + 1);
        switch (action) {
            case "select":
                selectCourse(req, resp, student.getId());
                break;
            case "drop":
                dropCourse(req, resp, student.getId());
                break;
            case "findMyCourses":
                findMyCourses(req, resp, student.getId());
                break;
            case "findAllCourses":
                findAllCourses(req, resp);
                break;
            default:
                resp.getWriter().write("{\"success\":false,\"msg\":\"无效操作\"}");
        }
    }

    // 选课
    private void selectCourse(HttpServletRequest req, HttpServletResponse resp, Integer studentId) throws IOException {
        String courseIdStr = req.getParameter("courseId");
        Integer courseId = Integer.parseInt(courseIdStr);
        boolean success = selectCourseService.selectCourse(studentId, courseId);
        PrintWriter out = resp.getWriter();
        if (success) {
            out.write("{\"success\":true,\"msg\":\"选课成功\"}");
        } else {
            out.write("{\"success\":false,\"msg\":\"该课程已选或不存在\"}");
        }
    }

    // 退课
    private void dropCourse(HttpServletRequest req, HttpServletResponse resp, Integer studentId) throws IOException {
        String courseIdStr = req.getParameter("courseId");
        Integer courseId = Integer.parseInt(courseIdStr);
        boolean success = selectCourseService.dropCourse(studentId, courseId);
        PrintWriter out = resp.getWriter();
        if (success) {
            out.write("{\"success\":true,\"msg\":\"退课成功\"}");
        } else {
            out.write("{\"success\":false,\"msg\":\"未选该课程或课程不存在\"}");
        }
    }

    // 查询我的课程
    private void findMyCourses(HttpServletRequest req, HttpServletResponse resp, Integer studentId) throws ServletException, IOException {
        List<SelectCourse> myCourses = selectCourseService.findByStudentId(studentId);
        // 计算总学分
        int totalCredits = selectCourseService.calculateTotalCredits(studentId);
        // 统计已选课程数
        int selectedCourseCount = myCourses.size();

        // 设置属性到request
        req.setAttribute("myCourses", myCourses);
        req.setAttribute("totalCredits", totalCredits);
        req.setAttribute("selectedCourseCount", selectedCourseCount);

        req.getRequestDispatcher("/student/myCourse.jsp").forward(req, resp);
    }

    // 查询所有可选课程
    private void findAllCourses(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // 获取所有课程
        List<Course> allCourses = courseService.findAll();

        // 获取分页参数
        String currentPageStr = req.getParameter("currentPage");
        String rowsStr = req.getParameter("rows");
        int currentPage = currentPageStr == null ? 1 : Integer.parseInt(currentPageStr);
        int rows = rowsStr == null ? 8 : Integer.parseInt(rowsStr);
        String keyword = req.getParameter("keyword");
        // 调用分页查询服务
        PageBean<Course> pb = courseService.findByPage(currentPage, rows, keyword);
        req.setAttribute("pb",pb);

        // 获取当前登录学生的ID
        Student student = (Student) req.getSession().getAttribute("student");
        Integer studentId = student.getId();

        // 获取该学生已选的课程
        List<SelectCourse> selectedCourses = selectCourseService.findByStudentId(studentId);
        req.setAttribute("selectedCourses",selectedCourses.size());

        // 创建已选课程ID的集合
        Set<Integer> selectedCourseIds = new HashSet<>();
        for (SelectCourse sc : selectedCourses) {
            // 确保courseId不为空再添加
            if (sc.getCourseId() != null) {
                selectedCourseIds.add(sc.getCourseId());
            }
        }

        // 为每个课程设置是否已选状态
        for (Course course : pb.getList()) {
            // 比较课程ID是否在已选集合中
            boolean isSelected = selectedCourseIds.contains(course.getId());
            course.setSelected(isSelected);
        }

        // 将课程列表传递给JSP
        req.setAttribute("allCourses", allCourses);
        req.getRequestDispatcher("/student/courseList.jsp").forward(req, resp);
    }
}