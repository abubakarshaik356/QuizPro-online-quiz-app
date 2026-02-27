//package com.quizpro.controller;
//
//import java.awt.List;
//import java.io.IOException;
//import java.util.ArrayList;
//
//import com.quizpro.dao.SubjectDAO;
//import com.quizpro.dao.SubjectDAOImpl;
//import com.quizpro.dto.Quizzes;
//
//import jakarta.servlet.RequestDispatcher;
//import jakarta.servlet.ServletException;
//import jakarta.servlet.annotation.WebServlet;
//import jakarta.servlet.http.HttpServlet;
//import jakarta.servlet.http.HttpServletRequest;
//import jakarta.servlet.http.HttpServletResponse;
//@WebServlet("/quizes")
//public class QuizesServlet extends HttpServlet{
//	@Override
//	protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
//		SubjectDAO subjectDAO=new SubjectDAOImpl();
//		int userid=Integer.parseInt(req.getParameter("userId"));
//		int subid=Integer.parseInt(req.getParameter("subId"));
//		ArrayList<Quizzes> quizes=(ArrayList<Quizzes>) subjectDAO.getAllQuizes(subid, userid);
//		if(quizes == null) {
//			quizes=new ArrayList<Quizzes>();
//		}
//		req.setAttribute("quizes", quizes);
//		req.setAttribute("title", req.getParameter("title"));
//		req.getRequestDispatcher("Quizes.jsp").forward(req, resp);
//	}
//}


package com.quizpro.controller;

import java.awt.List;
import java.io.IOException;
import java.util.ArrayList;

import com.quizpro.dao.SubjectDAO;
import com.quizpro.dao.SubjectDAOImpl;
import com.quizpro.dto.Quizzes;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
@WebServlet("/quizes")
public class QuizesServlet extends HttpServlet{
	@Override
	protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		SubjectDAO subjectDAO=new SubjectDAOImpl();
		int userid=Integer.parseInt(req.getParameter("userId"));
		int subid=Integer.parseInt(req.getParameter("subId"));
//		System.out.println();
//		System.out.println();
		ArrayList<Quizzes> quizes=(ArrayList<Quizzes>) subjectDAO.getAllQuizes(subid, userid);
		if(quizes == null) {
			quizes=new ArrayList<Quizzes>();
		}
		req.setAttribute("quizes", quizes);
		req.setAttribute("title", req.getParameter("title"));
		req.setAttribute("desc", req.getParameter("desc"));
		req.getRequestDispatcher("Quizes.jsp").forward(req, resp);
	}
}

