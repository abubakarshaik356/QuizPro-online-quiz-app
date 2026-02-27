package com.quizpro.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import com.quizpro.dao.UserDAO;
import com.quizpro.dao.UserDAOImpl;
import com.quizpro.dto.UserManage;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/UserManagement")
public class UserManagementServlet extends HttpServlet {

    private UserDAO userDAO;

    public UserManagementServlet() {
        userDAO = new UserDAOImpl();
    }

    @Override
    protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		ArrayList<UserManage> user = userDAO.getUsers();
		req.setAttribute("Users", user);
		req.getRequestDispatcher("UserManagement.jsp").forward(req, resp);
//        int page = 1;
//        int recordsPerPage = 10;
//
//        // Get page number from URL
//        if (req.getParameter("page") != null) {
//            page = Integer.parseInt(req.getParameter("page"));
//        }
//
//        // Fetch all users
//        ArrayList<UserManage> allUsers = userDAO.getUsers();
//        int totalRecords = allUsers.size();
//
//        // Pagination logic
//        int startIndex = (page - 1) * recordsPerPage;
//        int endIndex = Math.min(startIndex + recordsPerPage, totalRecords);
//
//        List<UserManage> paginatedUsers = allUsers.subList(startIndex, endIndex);
//
//        int totalPages = (int) Math.ceil(totalRecords * 1.0 / recordsPerPage);
//
//        // Pass data to JSP
//        req.setAttribute("Users", paginatedUsers);
//        req.setAttribute("currentPage", page);
//        req.setAttribute("totalPages", totalPages);
//        req.setAttribute("activePage", "user");
//        req.getRequestDispatcher("UserManagement.jsp").forward(req, resp);
    }
}

