package com.quizpro.controller;

import java.io.IOException;
import java.util.ArrayList;

import com.quizpro.dao.AdminDAO;
import com.quizpro.dao.AdminDAOImpl;
import com.quizpro.dto.Questions;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/ViewAllQuestions")
public class ViewQuestionServlet extends HttpServlet{
	
	AdminDAO adDAO = null;
	
	public ViewQuestionServlet() {
		adDAO = new AdminDAOImpl();
	}
	
	@Override
	protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		System.out.println("23");
		int quizId = Integer.parseInt(req.getParameter("quizId"));
		String quizName = req.getParameter("quizName");
		String quizCategory = req.getParameter("quizCategory");
		System.out.println(quizName + " " + quizCategory);
		
		ArrayList<Questions> questions = adDAO.getQuestions(quizId);
		
		HttpSession session = req.getSession();
		session.setAttribute("ListQuestions", questions);
    	session.setAttribute("QuizId", quizId);
    	session.setAttribute("QuizName", quizName);
    	session.setAttribute("QuizCategory", quizCategory);
    	
		
		req.getRequestDispatcher("ViewAllQuestions.jsp").forward(req, resp);
	}
}
