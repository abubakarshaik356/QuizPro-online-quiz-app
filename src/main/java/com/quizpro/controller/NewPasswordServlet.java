package com.quizpro.controller;

import java.io.IOException;

import com.quizpro.dao.UserDAO;
import com.quizpro.dao.UserDAOImpl;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/NewPassword")
public class NewPasswordServlet extends HttpServlet {
	
	UserDAO userDAO;
	public NewPasswordServlet() {
		userDAO=new UserDAOImpl();
	}
	@Override
	protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String email=req.getParameter("email");
		String password=req.getParameter("newPassword");
		boolean result=userDAO.newPassword(email, password);
		if(result) {
			resp.sendRedirect("login.jsp?msg=Password Reset Successfully. Login with new Password.");
		}
		else {
			resp.sendRedirect("ForgotPassword.jsp?status=error&message=Error%3A+Something+went+wrong.+Try again!");
		}
	}
}
