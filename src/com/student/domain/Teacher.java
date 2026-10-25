package com.student.domain;

import java.util.Date;

public class Teacher {
    private Integer id;
    private String teacherNo;
    private String name;
    private String gender;
    private String subject;
    private String phone;
    private Date updateTime;

    public Date getUpdateTime() {
        return updateTime;
    }

    public void setUpdateTime(Date updateTime) {
        this.updateTime = updateTime;
    }

    public Teacher() {
    }

    public Teacher(Integer id, String teacherNo, String name, String gender, String subject, String phone) {
        this.id = id;
        this.teacherNo = teacherNo;
        this.name = name;
        this.gender = gender;
        this.subject = subject;
        this.phone = phone;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getTeacherNo() {
        return teacherNo;
    }

    public void setTeacherNo(String teacherNo) {
        this.teacherNo = teacherNo;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getGender() {
        return gender;
    }

    public void setGender(String gender) {
        this.gender = gender;
    }

    public String getSubject() {
        return subject;
    }

    public void setSubject(String subject) {
        this.subject = subject;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    @Override
    public String toString() {
        return "Teacher{" +
                "id=" + id +
                ", teacherNo='" + teacherNo + '\'' +
                ", name='" + name + '\'' +
                ", gender='" + gender + '\'' +
                ", subject='" + subject + '\'' +
                ", phone='" + phone + '\'' +
                '}';
    }
}