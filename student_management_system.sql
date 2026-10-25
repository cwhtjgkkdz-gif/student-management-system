-- ============================================================
-- 学生选课管理系统 数据库初始化脚本
-- 适用：MySQL 5.7+ / 8.0
-- ============================================================
CREATE DATABASE IF NOT EXISTS student_management_system DEFAULT CHARACTER SET utf8mb4;
USE student_management_system;

-- ------------------------------------------------------------
-- 1. 管理员表
-- ------------------------------------------------------------
CREATE TABLE admin (
    id INT PRIMARY KEY AUTO_INCREMENT,
    username VARCHAR(50) NOT NULL UNIQUE,
    password VARCHAR(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ------------------------------------------------------------
-- 2. 学生表
-- ------------------------------------------------------------
CREATE TABLE student (
    id INT PRIMARY KEY AUTO_INCREMENT,
    student_no VARCHAR(20) NOT NULL UNIQUE,
    name VARCHAR(50) NOT NULL,
    password VARCHAR(50) NOT NULL,
    gender VARCHAR(10),
    age INT,
    phone VARCHAR(20)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ------------------------------------------------------------
-- 3. 教师表
-- ------------------------------------------------------------
CREATE TABLE teacher (
    id INT PRIMARY KEY AUTO_INCREMENT,
    teacher_no VARCHAR(20) NOT NULL UNIQUE,
    name VARCHAR(50) NOT NULL,
    gender VARCHAR(10),
    subject VARCHAR(50),
    phone VARCHAR(20),
    update_time DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ------------------------------------------------------------
-- 4. 课程表
-- ------------------------------------------------------------
CREATE TABLE course (
    id INT PRIMARY KEY AUTO_INCREMENT,
    course_no VARCHAR(20) NOT NULL UNIQUE,
    name VARCHAR(100) NOT NULL,
    credit INT,
    teacher_id INT,
    description TEXT,
    FOREIGN KEY (teacher_id) REFERENCES teacher(id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ------------------------------------------------------------
-- 5. 通知公告表
-- ------------------------------------------------------------
CREATE TABLE notice (
    id INT PRIMARY KEY AUTO_INCREMENT,
    title VARCHAR(200) NOT NULL,
    content TEXT,
    create_time DATETIME DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ------------------------------------------------------------
-- 6. 选课表
-- ------------------------------------------------------------
CREATE TABLE select_course (
    id INT PRIMARY KEY AUTO_INCREMENT,
    student_id INT NOT NULL,
    course_id INT NOT NULL,
    select_time DATETIME,
    FOREIGN KEY (student_id) REFERENCES student(id),
    FOREIGN KEY (course_id) REFERENCES course(id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ============================================================
-- 初始化示例数据
-- ============================================================
-- 默认管理员账号：admin / 123456
INSERT INTO admin(username, password) VALUES ('admin', '123456');

-- 示例学生账号：2021001 / 123456、2021002 / 123456
INSERT INTO student(student_no, name, password, gender, age, phone) VALUES
('2021001', '张三', '123456', '男', 20, '13800138000'),
('2021002', '李四', '123456', '女', 21, '13900139000');

INSERT INTO teacher(teacher_no, name, gender, subject, phone) VALUES
('T001', '王老师', '男', '计算机', '13700137000'),
('T002', '陈老师', '女', '数学', '13600136000');

INSERT INTO course(course_no, name, credit, teacher_id, description) VALUES
('C001', 'Java程序设计', 4, 1, 'Java 语言基础与面向对象编程'),
('C002', '数据库原理', 3, 2, '关系型数据库基础与 SQL'),
('C003', '数据结构', 4, 1, '常用数据结构与算法');

INSERT INTO notice(title, content, create_time) VALUES
('开学通知', '新学期选课系统已开放，请同学们及时完成选课。', NOW()),
('选课提醒', '选课截止时间为本月底，逾期将无法补选。', NOW());
