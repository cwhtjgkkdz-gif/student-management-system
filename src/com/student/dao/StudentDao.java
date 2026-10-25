package com.student.dao;

import com.student.domain.Student;
import java.util.List;

public interface StudentDao {
    // 根据学号和密码查询学生
    Student findByStudentNoAndPassword(String studentNo, String password);

    // 查询所有学生
    List<Student> findAll();

    // 根据ID查询学生
    Student findById(Integer id);

    // 添加学生
    void add(Student student);

    // 修改学生
    void update(Student student);

    // 删除学生
    void delete(Integer id);

    int count();

    // 分页和搜索方法
    List<Student> findByPage(Integer start, Integer rows, String keyword);
    int findTotalCount(String keyword);

    // 更新密码
    boolean updatePassword(Integer id, String newPassword);

    // 检查学号是否已存在
    boolean isStudentNoExists(String studentNo);

    // 根据学号查询学生
    Student findByStudentNo(String studentNo);
}