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

import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;

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
		final ExecutorService executor = Executors.newFixedThreadPool(2);
		if(isEmailExits) {
			int otp = (int) (Math.random() * 900000) + 100000;
	        HttpSession session = req.getSession();
	        session.setAttribute("otp", otp);
	        session.setAttribute("email", email);
	        
	        executor.submit(() -> {
	            try {
	            	EmailUtil.sendOtp(email, otp);
	            } catch (Exception e) {
	                e.printStackTrace();
	            }
	        });
			resp.sendRedirect("NewPassword.jsp");
		} else {
			resp.sendRedirect("ForgetPassword.jsp?status=error&message=Error%3A+No+account+found+with+that+email+address.");
		}
	}
}
