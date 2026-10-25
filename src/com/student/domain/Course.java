package com.student.domain;

public class Course {
    private Integer id;
    private String courseNo;
    private String name;
    private Integer credit;
    private Integer teacherId;
    private String description;
    private String teacherName;  //教师姓名
    private boolean selected;    //是否已选（用于前端显示）

    public Course() {
    }

    public String getTeacherName() {
        return teacherName;
    }

    public void setTeacherName(String teacherName) {
        this.teacherName = teacherName;
    }

    public boolean isSelected() {
        return selected;
    }

    public void setSelected(boolean selected) {
        this.selected = selected;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getCourseNo() {
        return courseNo;
    }

    public void setCourseNo(String courseNo) {
        this.courseNo = courseNo;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
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

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public Course(Integer id, String courseNo, String name, Integer credit, Integer teacherId, String description) {
        this.id = id;
        this.courseNo = courseNo;
        this.name = name;
        this.credit = credit;
        this.teacherId = teacherId;
        this.description = description;
    }

    @Override
    public String toString() {
        return "Course{" +
                "id=" + id +
                ", courseNo='" + courseNo + '\'' +
                ", name='" + name + '\'' +
                ", credit=" + credit +
                ", teacherId=" + teacherId +
                ", description='" + description + '\'' +
                '}';
    }
}