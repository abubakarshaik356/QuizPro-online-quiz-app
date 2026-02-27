package com.quizpro.controller;

import java.io.IOException;
import java.util.ArrayList;

import com.quizpro.dto.UserAnswer;
import com.quizpro.dto.Questions;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/QuestionNavigation")
public class QuestionNavigationServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void service(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
    	
    	System.out.println("it's coming");
    	
		/*
		 * HttpSession session = request.getSession(false); if (session == null) {
		 * response.sendRedirect("index.jsp"); return; }
		 * 
		 * // get parameters String qidStr = request.getParameter("questionId"); String
		 * ans = request.getParameter("answer"); String action =
		 * request.getParameter("action");
		 * 
		 * if (qidStr == null) { response.sendRedirect("TestPage.jsp"); return; }
		 * 
		 * int questionId = Integer.parseInt(qidStr);
		 * 
		 * // get or create userAnswers list ArrayList<UserAnswer> userAnswers =
		 * (ArrayList<UserAnswer>) session.getAttribute("UserAnswers"); if (userAnswers
		 * == null) { userAnswers = new ArrayList<>();
		 * session.setAttribute("UserAnswers", userAnswers); }
		 * 
		 * // update if existing, else add new (ensure not adding null answers
		 * repeatedly) boolean updated = false; for (UserAnswer ua : userAnswers) { if
		 * (ua.getQuestionId() == questionId) { ua.setChosenAnswer(ans); updated = true;
		 * break; } } if (!updated) { userAnswers.add(new UserAnswer(questionId, ans));
		 * } session.setAttribute("UserAnswers", userAnswers);
		 * 
		 * Integer idxObj = (Integer) session.getAttribute("qIndex"); int idx = (idxObj
		 * == null) ? 0 : idxObj;
		 * 
		 * ArrayList<Questions> questions = (ArrayList<Questions>)
		 * session.getAttribute("Questions"); int total = (questions == null) ? 0 :
		 * questions.size();
		 * 
		 * if ("next".equalsIgnoreCase(action)) { if (idx < total - 1) idx++; } else if
		 * ("prev".equalsIgnoreCase(action)) { if (idx > 0) idx--; } else if
		 * ("finish".equalsIgnoreCase(action)) { response.sendRedirect("FinishTest");
		 * return; } System.out.println("goneee"); session.setAttribute("currentIndex",
		 * idx); response.sendRedirect("TestPage.jsp");
		 */
    	 int qIndex = Integer.parseInt(req.getParameter("qIndex"));
    	 System.out.println(qIndex);

         // Handle Mark for Review
         String mark = req.getParameter("mark");
         if (mark != null) {
             req.getSession().setAttribute("mark_q" + qIndex, true);
         }

         // Redirect to TestPage.jsp
         System.out.println("122");
         HttpSession session = req.getSession(false);
         session.setAttribute("qIndex", qIndex);
         RequestDispatcher rd = req.getRequestDispatcher("TestWindow.jsp");
         rd.forward(req, resp);
    }
}

