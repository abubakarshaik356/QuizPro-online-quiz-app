package com.quizpro.controller;

import java.io.IOException;

import com.quizpro.dao.UserDAO;
import com.quizpro.dao.UserDAOImpl;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/ViewProfile")
public class ViewProfileServlet extends HttpServlet {
	
	UserDAO userDAO;
	public ViewProfileServlet() {
		userDAO=new UserDAOImpl();
	}
	
	@Override
	protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		HttpSession session=req.getSession();
		int userId=(int) session.getAttribute("id");
		req.setAttribute("performance", userDAO.getPerformance(userId));
		req.getRequestDispatcher("ViewProfile.jsp").forward(req, resp);
	}
}
