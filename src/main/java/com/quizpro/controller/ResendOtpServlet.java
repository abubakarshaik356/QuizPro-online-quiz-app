package com.quizpro.controller;

import java.io.IOException;

import com.quizpro.util.EmailUtil;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest; 
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/resendOtp")
public class ResendOtpServlet extends HttpServlet {
    @Override
    protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        HttpSession session = req.getSession();
        String email = (String)session.getAttribute("email");

        int otp = (int)(Math.random()*900000)+100000;

        session.setAttribute("otp", otp);
        session.setAttribute("otp_time", System.currentTimeMillis());

        EmailUtil.sendOtp(email, otp);

        resp.sendRedirect("verifyOtp.jsp?msg=OTP Resent");
    }
}
