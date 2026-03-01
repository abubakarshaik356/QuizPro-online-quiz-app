package com.quizpro.util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBConnection {
	public static Connection getConnector() {
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			Connection con = DriverManager.getConnection(
				    "jdbc:mysql://gondola.proxy.rlwy.net:14203/quizpro?useSSL=false&allowPublicKeyRetrieval=true",
				    "root",
				    "EFdjoJKGcwSBVYCZHRNJKROcAwDKIWmW"
				);
			return con;
		} catch (SQLException | ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return null;
	}
}
