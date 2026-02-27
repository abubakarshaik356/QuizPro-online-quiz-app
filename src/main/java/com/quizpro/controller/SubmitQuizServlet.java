package com.quizpro.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.json.JSONArray;

import com.quizpro.dao.AdminDAO;
import com.quizpro.dao.AdminDAOImpl;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/SubmitQuiz")
public class SubmitQuizServlet extends HttpServlet {
	
	AdminDAO adminDAO;
	public SubmitQuizServlet() {
		adminDAO=new AdminDAOImpl();
	}
	@Override
	protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		int quizId=Integer.parseInt(req.getParameter("quizId"));
		String quizName=req.getParameter("quizName");
		Map<Integer, String> answers=adminDAO.getAnswers(quizId);
		ArrayList<Integer> quesids=adminDAO.getQuesIds(quizId);
		int score=0;
		for(Integer i:quesids) {
			String answer=req.getParameter(i+"");
			if(answer==null) {
				continue;
			}
			if(answer.startsWith("[")) {
				JSONArray arr = new JSONArray(answer);
				List<String> temp = new ArrayList<>();

				for (int j = 0; j < arr.length(); j++) {
				    temp.add(arr.getString(j));
				}

				String joined = String.join(",", temp);
				answer=joined;

			}
			answer=answer.replace("\"", "");
			answer = answer.replace("&", "&amp;")
		               .replace("<", "&lt;")
		               .replace(">", "&gt;")
		               .replace("\"", "&quot;")
		               .replace("'", "&#x27;");
			if(answer.equalsIgnoreCase(answers.get(i))) {
				score++;
			}
			System.out.println(score+" "+answer+" "+answers.get(i));
		}
		HttpSession session=req.getSession();
		int userId=(int)session.getAttribute("id");
		double perc=((double)score/quesids.size())*100;
		System.out.println(score);
		System.out.println(quesids.size());
		System.out.println(perc);
		String email=(String)session.getAttribute("email");
		boolean res=adminDAO.setScore(userId, quizId, perc, email);
		System.out.println(res);
		req.setAttribute("quizName", quizName);
		req.setAttribute("score", score);
		req.setAttribute("totalQuestions", quesids.size());
		req.setAttribute("quizId", quizId);
		
		req.getRequestDispatcher("TestComplete.jsp").forward(req, resp);
	}
}
