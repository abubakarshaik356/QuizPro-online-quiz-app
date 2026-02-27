package com.quizpro.controller;

import java.io.IOException;

import com.quizpro.dao.AdminDAO;
import com.quizpro.dao.AdminDAOImpl;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/adminDashboard")
public class AdminDashboardServlet extends HttpServlet {

    private AdminDAO adminDAO;

    public AdminDashboardServlet() {
        adminDAO = new AdminDAOImpl();
    }

    @Override
    protected void service(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        int userCount = adminDAO.totalUsers();
        int quizCount = adminDAO.totalQuizzes();
        int subjectCount = adminDAO.totalSubjects();
        int attemptCount = adminDAO.totalTestAttempts();

        req.setAttribute("userCount", userCount);
        req.setAttribute("quizCount", quizCount);
        req.setAttribute("subjectCount", subjectCount);
        req.setAttribute("attemptCount", attemptCount);

        RequestDispatcher rd = req.getRequestDispatcher("adminDashboard.jsp");
        rd.forward(req, resp);
    }
}
