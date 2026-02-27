package com.quizpro.controller;

import java.io.IOException;
import java.util.ArrayList;

import com.quizpro.dao.AdminDAO;
import com.quizpro.dao.AdminDAOImpl;
import com.quizpro.dto.Subject;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/AddNewQuiz")
public class GetCategory extends HttpServlet{
	
	@Override
	protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		AdminDAO admin = new AdminDAOImpl();
		ArrayList<Subject> data = admin.getSubNames();
		
		req.setAttribute("subject", data);
		req.getRequestDispatcher("AddQuiz.jsp").forward(req, resp);
		 
		
	}
	
}
