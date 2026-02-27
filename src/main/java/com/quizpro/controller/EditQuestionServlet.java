package com.quizpro.controller;

import java.io.IOException;

import com.quizpro.dao.AdminDAO;
import com.quizpro.dao.AdminDAOImpl;
import com.quizpro.dto.Questions;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/EditQuestion")
public class EditQuestionServlet extends HttpServlet{
	
	AdminDAO adDAO = null;
	public EditQuestionServlet() {
		adDAO = new AdminDAOImpl();
	}
	
	@Override
	protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		int id = Integer.parseInt(req.getParameter("id"));
		String category = req.getParameter("quizCategory");
		String quizName = req.getParameter("quizName");
		
		Questions qs = adDAO.getQuestionDetails(id);
		if(qs != null) {
			req.setAttribute("QuestionDetails", qs);
			System.out.println(quizName+"-"+category);
			req.setAttribute("category", category);
			req.setAttribute("quizName", quizName);
			req.getRequestDispatcher("EditQuestion.jsp").forward(req, resp);
		}
		
	}

}
