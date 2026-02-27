package com.quizpro.controller;

import java.io.IOException;

import com.quizpro.dao.AdminDAO;
import com.quizpro.dao.AdminDAOImpl;
import com.quizpro.dto.Quizzes;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/TestPreview")
public class TestPreviewServlet extends HttpServlet{

	AdminDAO adDAO = null;
	
	public TestPreviewServlet() {
		adDAO = new AdminDAOImpl();
	}
	@Override
	protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
//		System.out.println("21");
		int quizId = Integer.parseInt(req.getParameter("quizId"));
//		System.out.println("22");
		Quizzes quiz = adDAO.getQuizDetails(quizId);
//		System.out.println("23");
		if(quiz != null) {
			req.setAttribute("QuizDetails",quiz);
			req.getRequestDispatcher("TestPreview.jsp").forward(req, resp);
		}
		
	}
}

