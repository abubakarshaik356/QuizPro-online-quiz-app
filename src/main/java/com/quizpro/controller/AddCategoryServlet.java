package com.quizpro.controller;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import com.quizpro.dao.AdminDAO;
import com.quizpro.dao.AdminDAOImpl;

@WebServlet("/AddCategoryServlet")
public class AddCategoryServlet extends HttpServlet {

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		String categoryId = request.getParameter("categoryID");
		String categoryName = request.getParameter("categoryName");
		String description = request.getParameter("description");

		AdminDAO dao = new AdminDAOImpl();
		boolean result = dao.addCategories(categoryId, categoryName, description);

		if (result) {
			response.sendRedirect("ContentManagement?msg=success");
		} else {
			response.sendRedirect("AddCategory.jsp?msg=error");
		}
	}
}
