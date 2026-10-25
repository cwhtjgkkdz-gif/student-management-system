package com.student.domain;

import java.util.Date;

public class SelectCourse {
    private Integer id;
    private Integer studentId;
    private Integer courseId;
    private Date selectTime;

    // 扩展的属性
    private String studentName;
    private String courseName;
    private Integer credit;
    private Integer teacherId;
    private String teacherName;
    private String courseNo;

    public SelectCourse() {
    }

    public SelectCourse(Integer id, Integer studentId, Integer courseId, Date selectTime) {
        this.id = id;
        this.studentId = studentId;
        this.courseId = courseId;
        this.selectTime = selectTime;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Integer getStudentId() {
        return studentId;
    }

    public void setStudentId(Integer studentId) {
        this.studentId = studentId;
    }

    public Integer getCourseId() {
        return courseId;
    }

    public void setCourseId(Integer courseId) {
        this.courseId = courseId;
    }

    public Date getSelectTime() {
        return selectTime;
    }

    public void setSelectTime(Date selectTime) {
        this.selectTime = selectTime;
    }

    public String getStudentName() {
        return studentName;
    }

    public void setStudentName(String studentName) {
        this.studentName = studentName;
    }

    public String getCourseName() {
        return courseName;
    }

    public void setCourseName(String courseName) {
        this.courseName = courseName;
    }

    public Integer getCredit() {
        return credit;
    }

    public void setCredit(Integer credit) {
        this.credit = credit;
    }

    public Integer getTeacherId() {
        return teacherId;
    }

    public void setTeacherId(Integer teacherId) {
        this.teacherId = teacherId;
    }

    public String getTeacherName() {
        return teacherName;
    }

    public void setTeacherName(String teacherName) {
        this.teacherName = teacherName;
    }

    public String getCourseNo() {
        return courseNo;
    }

    public void setCourseNo(String courseNo) {
        this.courseNo = courseNo;
    }

    @Override
    public String toString() {
        return "SelectCourse{" +
                "id=" + id +
                ", studentId=" + studentId +
                ", courseId=" + courseId +
                ", selectTime=" + selectTime +
                '}';
    }
}