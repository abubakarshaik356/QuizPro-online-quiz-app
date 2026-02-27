package com.quizpro.controller;

import java.io.IOException;

import com.quizpro.dao.AdminDAO;
import com.quizpro.dao.AdminDAOImpl;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/EditUser")
public class EditUserServlet extends HttpServlet {
	AdminDAO adminDAO;
	public EditUserServlet() {
		adminDAO=new AdminDAOImpl();
	}
	
	@Override
	protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String name=req.getParameter("name");
		String email=req.getParameter("email");
		String password=req.getParameter("password");
		long phone=Long.parseLong(req.getParameter("phone"));
		int userId=Integer.parseInt(req.getParameter("userId"));
		boolean result=adminDAO.updateUser(userId, name, email, phone, password);
		if(result) {
			String targetPage = "UserManagement";
			String successMessage = "User Details Updated Successfully!";
			String encodedMessage = java.net.URLEncoder.encode(successMessage, "UTF-8");
			resp.sendRedirect(targetPage + "?status=success&message=" + encodedMessage);
		}
		else {
			String targetPage = "UserManagement";
			String successMessage = "Something went wrong, User Details Not Updated Successfully";
			String encodedMessage = java.net.URLEncoder.encode(successMessage, "UTF-8");
			resp.sendRedirect(targetPage + "?status=failed&message=" + encodedMessage);
		}
	}
}
