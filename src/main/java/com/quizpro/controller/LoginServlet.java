package com.quizpro.controller;

import java.awt.List;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import com.quizpro.dao.UserDAO;
import com.quizpro.dao.UserDAOImpl;
import com.quizpro.dto.Subject;
import com.quizpro.dto.User;
import com.quizpro.util.DBConnection;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {

    private UserDAO userDAO;

    public LoginServlet() {
        userDAO = new UserDAOImpl();
    }

    @Override
    protected void service(HttpServletRequest req, HttpServletResponse resp) 
            throws ServletException, IOException {

        String email = req.getParameter("email");
        String pwd = req.getParameter("password");

        // Fetch user from database
        User result = userDAO.login(email, pwd);

        if (result != null) {
            // login success
            HttpSession session = req.getSession();
            session.setAttribute("user", result);
            session.setAttribute("name", result.getName());
            session.setAttribute("id", result.getUserid());
            session.setAttribute("email", result.getEmail());
            session.setAttribute("phone", result.getPhone());
            session.setAttribute("role", result.getRole());
            
            Connection con=DBConnection.getConnector();
            try {
            	String qryString="select * from subjects";
				PreparedStatement ps=con.prepareStatement(qryString);
				ResultSet rSet=ps.executeQuery();
				ArrayList<Subject> subjects=new ArrayList<>();
				while(rSet.next()) {
					Subject subject=new Subject();
					subject.setSubId(rSet.getInt(1));
					subject.setSubname(rSet.getString(2));
					subject.setSubDesc(rSet.getString(3));
					subjects.add(subject);
				}
				session.setAttribute("subjects", subjects);
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}

            System.out.println("Login Successful: " + result.getRole());

            // Redirect based on role
            if ("ADMIN".equalsIgnoreCase(result.getRole())) {
                resp.sendRedirect("adminDashboard");
            } else {
                req.setAttribute("activePage", "home");
                req.getRequestDispatcher("dashboard.jsp").forward(req, resp);
            }

        } else {
            // login failed
            System.out.println("Login Failed");

            req.setAttribute("msg", "Invalid Credentials");
            RequestDispatcher rd = req.getRequestDispatcher("login.jsp");
            rd.forward(req, resp);
        }
    }
}
