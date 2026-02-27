package com.quizpro.controller;

import java.io.IOException;
import java.util.ArrayList;

import com.quizpro.dao.UserDAO;
import com.quizpro.dao.UserDAOImpl;
import com.quizpro.dto.Quizzes;
import com.quizpro.dto.Subject;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/ContentManagement")
public class ContentManagementServlet extends HttpServlet{
	
	private UserDAO userDAO;

    public ContentManagementServlet() {
        userDAO = new UserDAOImpl();
    }

	@Override
	protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		ArrayList<Quizzes> quizzes = userDAO.getQuizzes();
		ArrayList<Subject> subjects = userDAO.getSubjects();
		req.setAttribute("Subjects", subjects);
		req.setAttribute("Quizzes", quizzes); 
		req.setAttribute("activePage", "content");
		req.getRequestDispatcher("ContentManagement.jsp").forward(req, resp);
	}
}
