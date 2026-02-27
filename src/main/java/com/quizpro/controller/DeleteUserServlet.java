package com.quizpro.controller;

import java.io.IOException;

import com.quizpro.dao.AdminDAO;
import com.quizpro.dao.AdminDAOImpl;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/DeleteUser")
public class DeleteUserServlet extends HttpServlet{

	AdminDAO adDAO;
	
	public DeleteUserServlet() {
		adDAO = new AdminDAOImpl();
	}
	@Override
	protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		int id = Integer.parseInt(req.getParameter("UserId"));
		
		boolean res = adDAO.deleteUser(id);
		if(res) {
			req.getRequestDispatcher("UserManagement").forward(req, resp);
		}else {
			req.getRequestDispatcher("UserManagement").forward(req, resp);
		}
		
		
	}
}
