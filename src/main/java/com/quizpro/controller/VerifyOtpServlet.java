package com.quizpro.controller;

import java.io.IOException;

import com.quizpro.dao.UserDAO;
import com.quizpro.dao.UserDAOImpl;
import com.quizpro.util.EmailUtil;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

@WebServlet("/verifyOtp")
public class VerifyOtpServlet extends HttpServlet {

    UserDAO dao = new UserDAOImpl();

    @Override
    protected void service(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        HttpSession session = req.getSession();
        int userOtp = Integer.parseInt(req.getParameter("otp"));
        int sessionOtp = (int) session.getAttribute("otp");
        long otpTime = (long) session.getAttribute("otp_time");
        long now = System.currentTimeMillis();

        String redirectUrl = "verifyOtp.jsp";

        if (now - otpTime > 2 * 60 * 1000) {
            resp.sendRedirect(redirectUrl + "?msg=OTP expired&type=warning");
            return;
        }

        if (userOtp != sessionOtp) {
            resp.sendRedirect(redirectUrl + "?msg=Invalid OTP&type=error");
            return;
        }

        String name = (String) session.getAttribute("name");
        String email = (String) session.getAttribute("email");
        String password = (String) session.getAttribute("password");
        long phone = (long) session.getAttribute("phone");

        boolean result = dao.signup(name, email, "user", phone, password);

        if (!result) {
            resp.sendRedirect(redirectUrl + "?msg=Mobile Number is Linked to other Account&type=info&redirect=login.jsp");
            return;
        }

        EmailUtil.sendSuccessMail(email);

        resp.sendRedirect(redirectUrl + "?msg=Account created successfully&type=success&redirect=login.jsp");
    }
}
