package com.quizpro.util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBConnection {
	public static Connection getConnector() {
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			Connection con=DriverManager.getConnection("jdbc:mysql://localhost:3306/onlinequiz","root","root");
//			Connection con=DriverManager.getConnection("jdbc:mysql://localhost:3306/onlinequiz","root","tiger");
//			Connection con=DriverManager.getConnection("jdbc:mysql://localhost:3306/onlinequiz","root","Narendra@2002");
			return con;
		} catch (SQLException | ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return null;
	}
}
