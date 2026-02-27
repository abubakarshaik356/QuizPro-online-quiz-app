package com.quizpro.controller;

import java.io.IOException;
import java.util.ArrayList;

import com.quizpro.dao.UserDAO;
import com.quizpro.dao.UserDAOImpl;
import com.quizpro.dto.Quizzes;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/ViewAllQuizes")
public class ViewAllQuizesServlet extends HttpServlet {

    private UserDAO userDAO;

    public ViewAllQuizesServlet() {
        userDAO = new UserDAOImpl();
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        int categoryId = Integer.parseInt(req.getParameter("categoryId"));
        String categoryName = req.getParameter("categoryName");

        ArrayList<Quizzes> quizes = userDAO.getQuizzesByCategory(categoryId);

        req.setAttribute("quizes", quizes);
        req.setAttribute("categoryName", categoryName);

        req.getRequestDispatcher("ViewAllQuizes.jsp").forward(req, resp);
    }
}
