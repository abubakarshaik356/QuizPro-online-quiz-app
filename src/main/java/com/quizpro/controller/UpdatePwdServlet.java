package com.quizpro.controller;

import java.io.IOException;

import com.quizpro.dao.UserDAO;
import com.quizpro.dao.UserDAOImpl;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/UpdatePasswordServlet")
public class UpdatePwdServlet extends HttpServlet {
	UserDAO userDAO;
	public UpdatePwdServlet() {
		userDAO = new UserDAOImpl();
	}
    
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        int id = Integer.parseInt(req.getParameter("userId"));
        String newPass = req.getParameter("newPass");
        
        Boolean updatePass = userDAO.updatePassword(id, newPass);
        
        if(updatePass) {
        	System.out.println("Updte Password successfully");
        	resp.sendRedirect("ViewProfile.jsp");
        }else {
        	resp.sendRedirect("ViewProfile.jsp");
        }
        
    }
}