package com.quizpro.controller;

import java.io.IOException;

import com.quizpro.util.EmailUtil;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/sendQuery")
public class SupportQueryServlet extends HttpServlet {

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
	        throws ServletException, IOException {

	    String message = request.getParameter("message");
	    String userEmail = request.getParameter("userEmail");
	    String username = request.getParameter("username");
	    String userId = request.getParameter("userId");
	    String redirectPage = request.getParameter("redirectPage");

	    if (redirectPage == null || redirectPage.isEmpty()) {
	        redirectPage = "dashboard.jsp";
	    }

	    if (message == null || message.trim().isEmpty()) {
	        response.sendRedirect(redirectPage + "?queryStatus=empty");
	        return;
	    }

	    try {
	        EmailUtil.sendSupportQueryFromUser(
	                userEmail,
	                username,
	                userId,
	                message
	        );
	        response.sendRedirect(redirectPage + "?queryStatus=sent");
	    } catch (Exception e) {
	        e.printStackTrace();
	        response.sendRedirect(redirectPage + "?queryStatus=error");
	    }
	}
}
