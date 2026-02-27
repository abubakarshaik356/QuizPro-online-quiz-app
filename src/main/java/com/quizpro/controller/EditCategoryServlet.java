package com.quizpro.controller;

import java.io.IOException;

import com.quizpro.dao.AdminDAO;
import com.quizpro.dao.AdminDAOImpl;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
@WebServlet("/EditCategory")
public class EditCategoryServlet extends HttpServlet {
	@Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String categoryId = request.getParameter("categoryID");
        String categoryName = request.getParameter("categoryName");
        String description = request.getParameter("description");

        AdminDAO dao = new AdminDAOImpl();
        boolean result = dao.editCategories(categoryId, categoryName, description);

        response.sendRedirect("ContentManagement?");
    }
}
