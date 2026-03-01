package com.quizpro.controller;

import java.io.IOException;
import java.net.URLEncoder;

import com.quizpro.dao.UserDAO;
import com.quizpro.dao.UserDAOImpl;
import com.quizpro.util.EmailUtil;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

@WebServlet("/signup")
public class SignupServlet extends HttpServlet {

	UserDAO dao = new UserDAOImpl();

	@Override
	protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		req.setCharacterEncoding("UTF-8");

		String name = req.getParameter("name");
		String email = req.getParameter("email");
		String password = req.getParameter("password");
		String phoneStr = req.getParameter("phone");

		long phone = 0;
		try {
			phone = Long.parseLong(phoneStr.trim());
		} catch (Exception e) {
			String msg = URLEncoder.encode("Invalid phone number", "UTF-8");
			resp.sendRedirect("signup.jsp?msg=" + msg + "&redirect=signup.jsp");
			return;
		}

		// Checking email existance
		if (dao.isEmailExist(email)) {

			String msg = URLEncoder.encode("Account already exists", "UTF-8");

			resp.sendRedirect("signup.jsp?msg=" + msg + "&redirect=login.jsp");
			return;
		}

		int otp = (int) (Math.random() * 900000) + 100000;

		HttpSession session = req.getSession();
		session.setAttribute("otp", otp);
		session.setAttribute("otp_time", System.currentTimeMillis());
		session.setAttribute("name", name);
		session.setAttribute("email", email);
		session.setAttribute("password", password);
		session.setAttribute("phone", phone);

		String emailRegex = "^[A-Za-z0-9+_.-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}$";

		if (email == null || !email.matches(emailRegex)) {
			String msg = URLEncoder.encode("Invalid email format", "UTF-8");
			resp.sendRedirect("signup.jsp?msg=" + msg + "&redirect=signup.jsp");
			return;
		}
		
		new Thread(() -> {
		    try {
		        EmailUtil.sendOtp(email, otp);
		    } catch (Exception e) {
		        e.printStackTrace();
		    }
		}).start();

		resp.sendRedirect("verifyOtp.jsp");
	}
}
