package com.quizpro.controller;

import java.io.IOException;
import java.util.ArrayList;

import com.quizpro.dao.UserDAO;
import com.quizpro.dao.UserDAOImpl;
import com.quizpro.dto.Quizzes;
import com.quizpro.dto.Subject;
import com.quizpro.dto.UserManage;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/AnalyticsReports")
public class AnalyticsReports extends HttpServlet {

    private UserDAO userDAO;

    public AnalyticsReports() {
        userDAO = new UserDAOImpl();
    }

    @Override
    protected void service(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        // Fetch lists from DAO
        ArrayList<UserManage> users = userDAO.getUsers();
        ArrayList<Subject> subjects = userDAO.getSubjects();
        ArrayList<Quizzes> quizzes = userDAO.getQuizzes();

        // Analytics Values
        int totalUsers = users != null ? users.size() : 0;
        int totalSubjects = subjects != null ? subjects.size() : 0;
        int totalQuizzes = quizzes != null ? quizzes.size() : 0;

        // Set attributes for JSP
        req.setAttribute("totalUsers", totalUsers);
        req.setAttribute("totalSubjects", totalSubjects);
        req.setAttribute("totalQuizzes", totalQuizzes);

        req.setAttribute("users", users);   
        req.setAttribute("subjects", subjects);
        req.setAttribute("quizzes", quizzes);   
   
        // Forward to JSP
        req.setAttribute("activePage", "analytics");
        RequestDispatcher rd = req.getRequestDispatcher("adAnalyticsReports.jsp");
        rd.forward(req, resp);
    }
}
