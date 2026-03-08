package com.quizpro.controller;

import java.io.IOException;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;

import com.quizpro.dao.AdminDAO;
import com.quizpro.dao.AdminDAOImpl;
import com.quizpro.util.EmailUtil;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

@WebServlet("/CreateUser")
public class CreateUserServlet extends HttpServlet {

    AdminDAO adminDAO;

    private static final ExecutorService executor = Executors.newFixedThreadPool(2);

    public CreateUserServlet() {
        adminDAO = new AdminDAOImpl();
    }

    @Override
    protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        String name = req.getParameter("name");
        String email = req.getParameter("email");
        String password = req.getParameter("password");
        long phone = Long.parseLong(req.getParameter("phone"));
        String role = req.getParameter("role");

        boolean result = adminDAO.createNewUser(name, email, role, phone, password);

        if (result) {

            String targetPage = "UserManagement";
            String successMessage = "New user successfully created!";
            String encodedMessage = java.net.URLEncoder.encode(successMessage, "UTF-8");
            try {
                EmailUtil.sendCreateMail(email, name, password);
            } 
            catch (Exception e) {
                e.printStackTrace();
                resp.sendRedirect(targetPage + "?status=success&message=" + encodedMessage);
            }

            resp.sendRedirect(targetPage + "?status=success&message=" + encodedMessage);

        } else {

            String targetPage = "UserManagement";
            String successMessage = "Account Already Exist or Invalid Details";
            String encodedMessage = java.net.URLEncoder.encode(successMessage, "UTF-8");

            resp.sendRedirect(targetPage + "?status=failed&message=" + encodedMessage);
        }
    }
}