package com.student.test;

import com.student.util.JDBCUtils;
import org.junit.Test;

import java.sql.Connection;
import java.sql.SQLException;

public class JDBCTest {

    @Test
    public void testConnection() {
        try {
            Connection conn = JDBCUtils.getConnection();
            if (conn!=null)
            {
                System.out.println("成功!!!!!");
            }else {
                System.out.println("失败!!!!!");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}