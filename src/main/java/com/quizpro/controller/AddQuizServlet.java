package com.quizpro.controller;

import java.io.IOException;
import java.util.ArrayList;

import com.mysql.cj.Session;
import com.quizpro.dao.AdminDAO;
import com.quizpro.dao.AdminDAOImpl;
import com.quizpro.dto.Questions;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/AddNewQuizintoTable")
public class AddQuizServlet extends HttpServlet {

	AdminDAO adDAO = null;

	public AddQuizServlet() {
		adDAO = new AdminDAOImpl();
	}

	@Override
	protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		String quizName = req.getParameter("title");
		String quizDesc = req.getParameter("description");
		String quizCategory = req.getParameter("category");
		String quizLevel = req.getParameter("difficulty");
		int marks = Integer.parseInt(req.getParameter("passing_score"));
		int noOfQuestions = Integer.parseInt(req.getParameter("NoOfQuestions"));
		
		  System.out.println(quizName + " " + quizDesc + " " + quizCategory + " " +
		  marks);
		 
		int res = adDAO.addQuiz(quizName, quizDesc, quizCategory, marks, noOfQuestions,quizLevel);
		if (res != -1) {
			ArrayList<Questions> questions = adDAO.getQuestions(res);
			HttpSession session = req.getSession();
			session.setAttribute("ListQuestions", questions);
			session.setAttribute("QuizId", res);
			session.setAttribute("QuizName", quizName);
			session.setAttribute("QuizCategory", quizCategory);
			session.setAttribute("NoOfQuestions", noOfQuestions);

			req.getRequestDispatcher("AddQuestions.jsp").forward(req, resp);
		} else {
			req.getRequestDispatcher("").forward(req, resp);
		}
	}
}
