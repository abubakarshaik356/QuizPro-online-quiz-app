package com.quizpro.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import com.quizpro.dao.SubjectDAO;
import com.quizpro.dao.SubjectDAOImpl;
import com.quizpro.dao.UserDAO;
import com.quizpro.dao.UserDAOImpl;
import com.quizpro.dto.Quizzes;
import com.quizpro.dto.Subject;
import com.quizpro.dto.User;
import com.quizpro.dto.UserTestHis;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/ViewTestHis")
public class ViewTestHisServlet extends HttpServlet{

	UserDAO userDAO;
	SubjectDAO sub ;
	public ViewTestHisServlet() {
		userDAO = new UserDAOImpl();
		sub = new SubjectDAOImpl();
	}
	@Override
	protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
			
		HttpSession session = req.getSession();
        User loggedInUser = (User) session.getAttribute("user");
        
        List<Subject> subject = sub.getAllSubjects();
        
        List<UserTestHis> list = userDAO.userTestHistory(loggedInUser.getUserid());
        req.setAttribute("usertesthis", list);
        req.setAttribute("subjects", subject);
        req.getRequestDispatcher("ViewTestHistory.jsp").forward(req, resp);

	}
}
