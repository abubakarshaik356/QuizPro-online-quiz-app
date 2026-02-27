package com.quizpro.controller;

import java.io.IOException;
import java.util.ArrayList;

import com.quizpro.dao.AdminDAO;
import com.quizpro.dao.AdminDAOImpl;
import com.quizpro.dto.Questions;
import com.quizpro.dto.Quizzes;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/Test")
public class TestServlet extends HttpServlet {
	AdminDAO adminDAO;
	public TestServlet() {
		adminDAO=new AdminDAOImpl();
	}
	@Override
	protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		int quizId=Integer.parseInt(req.getParameter("quizId"));
		ArrayList<Questions> questions=adminDAO.getQuestions(quizId);
		Quizzes quiz=adminDAO.getQuizDetails(quizId);
		req.setAttribute("questions", questions);
		req.setAttribute("quizId", quiz.getQuizId());
		req.setAttribute("quizName", quiz.getTitle());
		req.setAttribute("category", quiz.getCategory());
		req.setAttribute("difficulty", quiz.getQuizLevel());
		req.setAttribute("quescount", quiz.getQuestions());
		req.setAttribute("activePage", "tests");
		req.getRequestDispatcher("Test.jsp").forward(req, resp);
	}
}
