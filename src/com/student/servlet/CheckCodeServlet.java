package com.student.servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import javax.imageio.ImageIO;
import java.awt.*;
import java.awt.image.BufferedImage;
import java.io.IOException;
import java.util.Random;

@WebServlet("/CheckCodeServlet")
public class CheckCodeServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // 设置响应头，禁止缓存
        resp.setHeader("Pragma", "no-cache");
        resp.setHeader("Cache-Control", "no-cache");
        resp.setHeader("Expires", "0");
        resp.setContentType("image/jpeg");

        // 调整大小，更和谐
        int width = 120;
        int height = 40;

        // 1. 创建验证码图片对象
        BufferedImage image = new BufferedImage(width, height, BufferedImage.TYPE_INT_RGB);

        // 2. 美化图片
        Graphics2D g = (Graphics2D) image.getGraphics();

        // 2.1 填充背景色 - 使用与登录界面协调的浅色背景
        g.setColor(new Color(248, 249, 254)); // 浅灰紫色，与登录界面协调
        g.fillRect(0, 0, width, height);

        // 2.2 画边框 - 使用登录界面的主色调
        g.setColor(new Color(118, 75, 162)); // 与登录界面的紫色协调
        g.drawRoundRect(0, 0, width - 1, height - 1, 8, 8); // 圆角边框

        // 2.3 生成验证码文字
        String str = "ABCDEFGHJKLMNPQRSTUVWXYZabcdefghjkmnpqrstuvwxyz23456789"; // 移除易混淆字符
        Random ran = new Random();
        StringBuilder sb = new StringBuilder();

        // 设置字体 - 更清晰易读
        Font font = new Font("Arial", Font.BOLD, 22);
        g.setFont(font);

        // 字符间距更均匀
        int charSpacing = width / 5;
        int startX = 15;

        for (int i = 0; i < 4; i++) {
            int index = ran.nextInt(str.length());
            char ch = str.charAt(index);
            sb.append(ch);

            // 使用登录界面的渐变色中的颜色
            Color textColor;
            if (i % 2 == 0) {
                textColor = new Color(102, 126, 234); // #667eea
            } else {
                textColor = new Color(118, 75, 162); // #764ba2
            }
            g.setColor(textColor);

            // 计算位置
            int x = startX + i * charSpacing;
            int y = height / 2 + ran.nextInt(6) - 3; // 轻微上下偏移

            // 轻微随机旋转，增加可读性同时防止机器识别
            double angle = ran.nextDouble() * 0.3 - 0.15; // -0.15 ~ 0.15弧度
            g.rotate(angle, x, y);

            // 添加文字阴影效果
            g.setColor(new Color(200, 200, 220, 80));
            g.drawString(String.valueOf(ch), x + 1, y + 1);

            g.setColor(textColor);
            // 绘制文字
            g.drawString(String.valueOf(ch), x, y);

            // 恢复旋转
            g.rotate(-angle, x, y);
        }

        // 将验证码存入session
        String checkCode_session = sb.toString();
        req.getSession().setAttribute("checkCode_session", checkCode_session);
        // 设置验证码生成时间
        req.getSession().setAttribute("checkCode_time", System.currentTimeMillis());

        // 2.4 画干扰线 - 使用柔和颜色
        g.setColor(new Color(200, 190, 220, 80)); // 半透明浅紫色
        for (int i = 0; i < 4; i++) {
            int x1 = ran.nextInt(width / 4);
            int y1 = ran.nextInt(height);
            int x2 = ran.nextInt(width * 3 / 4) + width / 4;
            int y2 = ran.nextInt(height);

            // 使用抗锯齿让线条更平滑
            g.setStroke(new BasicStroke(1.2f));
            g.drawLine(x1, y1, x2, y2);
        }

        // 2.5 添加噪点 - 使用柔和颜色
        g.setColor(new Color(180, 170, 200, 50)); // 更淡的紫色噪点
        for (int i = 0; i < 30; i++) {
            int x = ran.nextInt(width);
            int y = ran.nextInt(height);
            int dotSize = ran.nextInt(3) + 1;
            g.fillOval(x, y, dotSize, dotSize);
        }

        // 2.6 添加渐变覆盖层，使整体更和谐
        GradientPaint gradient = new GradientPaint(
                0, 0, new Color(255, 255, 255, 20),
                width, height, new Color(230, 230, 240, 10)
        );
        g.setPaint(gradient);
        g.fillRect(0, 0, width, height);

        // 3. 将图片输出到页面
        ImageIO.write(image, "jpg", resp.getOutputStream());

        g.dispose(); // 释放资源
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        this.doGet(req, resp);
    }
}