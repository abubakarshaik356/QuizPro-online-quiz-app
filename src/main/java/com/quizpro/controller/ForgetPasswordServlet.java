package com.quizpro.controller;

import java.io.IOException;

import com.quizpro.dao.UserDAO;
import com.quizpro.dao.UserDAOImpl;
import com.quizpro.util.EmailUtil;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/ForgotPassword")
public class ForgetPasswordServlet extends HttpServlet{
	
	UserDAO userDAO;
	public ForgetPasswordServlet() {
		userDAO=new UserDAOImpl();
	}
	@Override
	protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String email=req.getParameter("email");
		boolean isEmailExits=userDAO.isEmailExist(email);
		if(isEmailExits) {
			int otp = (int) (Math.random() * 900000) + 100000;
	        HttpSession session = req.getSession();
	        session.setAttribute("otp", otp);
	        session.setAttribute("email", email);
	        EmailUtil.sendOtp(email, otp);
			resp.sendRedirect("NewPassword.jsp");
		} else {
			resp.sendRedirect("ForgetPassword.jsp?status=error&message=Error%3A+No+account+found+with+that+email+address.");
		}
	}
}
