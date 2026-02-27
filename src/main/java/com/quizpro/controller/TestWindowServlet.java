package com.quizpro.controller;

import java.io.IOException;
import java.util.ArrayList;

import com.quizpro.dao.AdminDAO;
import com.quizpro.dao.AdminDAOImpl;
import com.quizpro.dto.Questions;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/TestWindow")
public class TestWindowServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private AdminDAO adDAO = null;

    public TestWindowServlet() {
        adDAO = new AdminDAOImpl();
    }

    @Override
    protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // Get quizId from request param
        String qid = req.getParameter("quizId");
        if (qid == null) {
            resp.sendRedirect("index.jsp"); // or error page
            return;
        }

        int quizId = Integer.parseInt(qid);
        System.out.println(quizId);

        ArrayList<Questions> questions = adDAO.getQuestions(quizId);

        System.out.println(questions);
        // Save questions & initial state in session (so they persist across requests)
        HttpSession session = req.getSession();
        session.setAttribute("Questions", questions);
        session.setAttribute("qIndex", 0);             // start at first question
        session.setAttribute("UserAnswers", new ArrayList<>()); // empty list to collect answers

        // Redirect to the test page (JSP will read from session)
        resp.sendRedirect("TestWindow.jsp");
    }
}

