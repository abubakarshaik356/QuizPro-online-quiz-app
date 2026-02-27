package com.quizpro.controller;


import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import java.io.IOException;

@WebServlet("/FinishQuizServlet")
public class FinishQuizServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String quizId = request.getParameter("quizId");

        // You can mark quiz as completed or just redirect
        response.sendRedirect("admin-dashboard.jsp?quizCompleted=" + quizId);
    }
}

