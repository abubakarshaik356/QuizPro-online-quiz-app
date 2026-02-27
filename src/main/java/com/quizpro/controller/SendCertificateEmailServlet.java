package com.quizpro.controller;

import java.io.IOException;
import java.net.Authenticator.RequestorType;

import com.mysql.cj.Session;
import com.quizpro.util.EmailUtil;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/SendCertificateEmail")
public class SendCertificateEmailServlet extends HttpServlet {
	@Override
	protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		HttpSession session=req.getSession();
		String userEmail=(String) session.getAttribute("email");
		String userName=(String) session.getAttribute("name");
		String quizTitle=req.getParameter("title");
		String date=req.getParameter("date");
		String certId=req.getParameter("id");
		EmailUtil.sendCertificateMail(userEmail, userName, quizTitle, certId, date);
		resp.sendRedirect(req.getHeader("referer"));
	}
}
