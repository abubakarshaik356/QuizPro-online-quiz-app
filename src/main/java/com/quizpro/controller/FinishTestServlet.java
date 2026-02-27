package com.quizpro.controller;

import java.io.IOException;
import java.util.ArrayList;

import com.quizpro.dto.UserAnswer;
import com.quizpro.dto.Questions;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/FinishTest")
public class FinishTestServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
    	System.out.println("hji");
        HttpSession session = request.getSession(false);
        if (session == null) {
            response.sendRedirect("index.jsp");
            return;
        }

        ArrayList<UserAnswer> answers = (ArrayList<UserAnswer>) session.getAttribute("UserAnswers");
        System.out.println(answers);
        ArrayList<Questions> questions = (ArrayList<Questions>) session.getAttribute("Questions");

        // Put both in request to show in results page
        request.setAttribute("AllAnswers", answers);
        request.setAttribute("Questions", questions);

        // Optionally: clear session attributes if you want to end the attempt
        // session.removeAttribute("Questions");
        // session.removeAttribute("currentIndex");
        // session.removeAttribute("UserAnswers");

        System.out.println("Done");
        request.getRequestDispatcher("Results.jsp").forward(request, response);
    }
}

