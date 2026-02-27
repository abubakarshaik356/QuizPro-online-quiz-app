package com.quizpro.controller;

import com.quizpro.dao.SubjectDAO;
import com.quizpro.dao.SubjectDAOImpl;
import com.quizpro.dto.Subject;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet("/categories")
public class CategoryServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        SubjectDAO dao = new SubjectDAOImpl();
        List<Subject> list = dao.getAllSubjects();

        // Check if list is null
        if (list == null) {
            list = new java.util.ArrayList<>(); // prevent NPE
        }

        // Set the list as request attribute
        req.setAttribute("list", list);

        // Forward to JSP
        req.setAttribute("activePage", "categories");
        req.getRequestDispatcher("categories.jsp").forward(req, resp);
    }
}
