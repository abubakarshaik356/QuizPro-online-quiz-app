package com.quizpro.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

import com.quizpro.dao.AdminDAO;
import com.quizpro.dao.AdminDAOImpl;
import com.quizpro.dto.Questions;
import com.quizpro.util.DBConnection;

@WebServlet("/ADDQuestion")
public class AddQuestionServlet extends HttpServlet {
	
	AdminDAO adDAO = null;
	public AddQuestionServlet() {
		adDAO = new AdminDAOImpl();
	}

    private static final long serialVersionUID = 1L;
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("text/html;charset=UTF-8");

        System.out.println("1");
        int quizId = Integer.parseInt(request.getParameter("QuizId"));
        String question_type = request.getParameter("type");
        String question_text = request.getParameter("question_text");
		/*
		 * String rack_category = request.getParameter("rack_category"); String
		 * difficulty = request.getParameter("difficulty");
		 */
        System.out.println("2");
        System.out.println("4");
     // Instead of parsing option_count
        List<String> options = new ArrayList<>();
        for (int i = 1; i <= 10; i++) { // max 10 options
            String opt = request.getParameter("option" + i);
            if (opt != null && !opt.trim().isEmpty()) {
                options.add(opt);
            }
        }


        System.out.println("3");
              
        String correctAnswer = null;
        System.out.println(question_type);
        if ("mcq".equalsIgnoreCase(question_type) ||
            "true-false".equalsIgnoreCase(question_type)) {

            correctAnswer = request.getParameter("correct_answer");
        } else  if ("multi-select".equalsIgnoreCase(question_type)){
        	System.out.println("multi");
            String[] correctAnsArr = request.getParameterValues("correct_answers");
            if (correctAnsArr != null) {
                correctAnswer = String.join(",", correctAnsArr);
                
            }
        }


        System.out.println("Correct Answer is:" + correctAnswer);
        // --- DB insert ---
        Connection con = null;
        PreparedStatement pst = null;
        System.out.println("narendra");
        System.out.println("Question Type Received: " + question_type);
        System.out.println("Correct Answer raw: " + request.getParameter("correct_answer"));
        System.out.println("Correct Answers raw[]: " + java.util.Arrays.toString(request.getParameterValues("correct_answers")));

        try {
            con = DBConnection.getConnector();
            String sql = "INSERT INTO questions ( quesdesc, option1, option2, option3, option4, answer, quizId, optionType ) "
                    + "VALUES ( ?, ?, ?, ?, ?, ?, ?,?)";

            pst = con.prepareStatement(sql);

            
            pst.setString(1, question_text);

            // --- Map options ---
            // Fill missing options as NULL
            for (int i = 0; i < 4; i++) {
                if (i < options.size()) {
                    pst.setString(2 + i, options.get(i));
                } else {
                    pst.setNull(2 + i, Types.VARCHAR);
                }
            }

            pst.setString(6, correctAnswer);
            pst.setInt(7, quizId);
            pst.setString(8, question_type);
            int rows = pst.executeUpdate();

            if (rows > 0) {
				HttpSession session = request.getSession();

            	String quizTitle = (String) session.getAttribute("QuizName");
            	String quizCategory = (String) session.getAttribute("QuizCategory");

    			int noOfQues = (int) session.getAttribute("NoOfQuestions");
            	ArrayList<Questions> questions = adDAO.getQuestions(quizId);

            	session.setAttribute("QuizId", quizId);
            	session.setAttribute("QuizName", quizTitle);
            	session.setAttribute("QuizCategory", quizCategory);
            	session.setAttribute("ListQuestions", questions);
            	session.setAttribute("NoOfQuestions", noOfQues);
            	if(questions.size() != noOfQues) {
            		request.getRequestDispatcher("AddQuestions.jsp").forward(request, response);
            	}
            	else {
            		request.getRequestDispatcher("ViewAllQuestions.jsp").forward(request, response);
            	}

            } else {
                response.getWriter().println("<h3>Error inserting question!</h3>");
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("<h3>Error: " + e.getMessage() + "</h3>");
        } finally {
            try { if (pst != null) pst.close(); } catch (Exception ignored) {}
            try { if (con != null) con.close(); } catch (Exception ignored) {}
        }
    }
}
