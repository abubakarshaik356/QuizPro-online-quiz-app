package com.quizpro.controller;

import java.io.IOException;

import com.mysql.cj.Session;
import com.quizpro.dao.AdminDAO;
import com.quizpro.dao.AdminDAOImpl;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/UpdateQuestionServletPage")
public class UpdateQuestionServlet extends HttpServlet{
	
	AdminDAO adDAO = null;
	
	public UpdateQuestionServlet() {
		adDAO = new AdminDAOImpl();
	}
	
	@Override
	protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		int questionId = Integer.parseInt(req.getParameter("QuesId"));
        int quizId = Integer.parseInt(req.getParameter("quizId"));
        String questionText = req.getParameter("question_text");
        String optionType = req.getParameter("type");
        String quizName = req.getParameter("quizName");
        String quizCategory = req.getParameter("quizCategory");
       
        String option1 = req.getParameter("option1");
        String option2 = req.getParameter("option2");
        String option3 = req.getParameter("option3");
        String option4 = req.getParameter("option4");

        System.out.println(questionId + " " + quizId + " " + questionText + " " + optionType + " " + option1 + " " + option2 + " "
        		+ option3 + " " + option4
        		);
        
        String answer = "";

        if (optionType.equals("mcq")) {
            answer = req.getParameter("correct_answer"); 

        } else if (optionType.equals("true-false")) {
            answer = req.getParameter("correct_answer");

        } else if (optionType.equals("multi-select")) {
            String[] selectedAnswers = req.getParameterValues("correct_answers");

            if (selectedAnswers != null) {
                answer = String.join(",", selectedAnswers);
            }
        }
        
        boolean res = adDAO.updateQuestion(questionId, questionText,option1,option2,option3,option4,answer);
        if(res) {
        	System.out.println("if ondition" + quizId + " " + quizCategory + " " + quizName);
        	req.setAttribute("quizId", quizId);
        	req.setAttribute("quizName", quizName);
        	req.setAttribute("quizCategory", quizCategory);
        	req.getRequestDispatcher("ViewAllQuestions").forward(req, resp);
        }else {
        	System.out.println("Fail");
        }
		
	}
}
