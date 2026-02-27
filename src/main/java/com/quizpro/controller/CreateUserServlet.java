package com.quizpro.controller;

import java.io.IOException;

import com.quizpro.dao.AdminDAO;
import com.quizpro.dao.AdminDAOImpl;
import com.quizpro.util.EmailUtil;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/CreateUser")
public class CreateUserServlet extends HttpServlet {
	
	AdminDAO adminDAO;
	public CreateUserServlet() {
		adminDAO=new AdminDAOImpl();
	}
	
	@Override
	protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String name=req.getParameter("name");
		String email=req.getParameter("email");
		String password=req.getParameter("password");
		long phone=Long.parseLong(req.getParameter("phone"));
		String role=req.getParameter("role");
		boolean result=adminDAO.createNewUser(name, email, role, phone, password);
		if(result) {
			String targetPage = "UserManagement";
			String successMessage = "New user successfully created!";
			EmailUtil.sendCreateMail(email, name, password);
			String encodedMessage = java.net.URLEncoder.encode(successMessage, "UTF-8");
			resp.sendRedirect(targetPage + "?status=success&message=" + encodedMessage);
		}
		else {
			String targetPage = "UserManagement";
			String successMessage = "Account Already Exist or Invalid Details";
			String encodedMessage = java.net.URLEncoder.encode(successMessage, "UTF-8");
			resp.sendRedirect(targetPage + "?status=failed&message=" + encodedMessage);
		}
	}
}
