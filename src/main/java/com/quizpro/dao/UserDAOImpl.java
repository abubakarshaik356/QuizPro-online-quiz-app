package com.quizpro.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.DecimalFormat;
import java.util.ArrayList;
import java.util.Date;

import com.quizpro.dto.Performance;
import com.quizpro.dto.Quizzes;
import com.quizpro.dto.Subject;
import com.quizpro.dto.User;
import com.quizpro.dto.UserManage;
import com.quizpro.dto.UserTestHis;
import com.quizpro.util.DBConnection;

public class UserDAOImpl implements UserDAO {
	static User user;

	@Override
	public boolean signup(String name, String email, String role, long phone, String password) {
		Connection conn = DBConnection.getConnector();
		String qry = "INSERT into emps values(?,?,?,?,?,?)";
		PreparedStatement ps;
		try {
			ps = conn.prepareStatement(qry);
			int userid = (int) (Math.random() * 100000000);
			ps.setInt(1, userid);
			ps.setString(2, name);
			ps.setString(3, email);
			ps.setLong(4, phone);
			ps.setString(5, role);
			ps.setString(6, password);
			int result = ps.executeUpdate();
			if (result > 0) {
				return true;
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return false;
	}

	public boolean isEmailExist(String email) {
		Connection conn = DBConnection.getConnector();
		String qry = "SELECT * FROM emps WHERE email=?";
		try {
			PreparedStatement ps = conn.prepareStatement(qry);
			ps.setString(1, email);
			ResultSet rs = ps.executeQuery();
			return rs.next();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return false;
	}

	public User login(String email, String password) {
		Connection conn = DBConnection.getConnector();
		String qry = "select * from emps where email=? and password=?";
		PreparedStatement ps;
		try {
			ps = conn.prepareStatement(qry);
			ps.setString(1, email);
			ps.setString(2, password);
			ResultSet rs = ps.executeQuery();
			if (rs.next()) {
				user = new User(rs.getInt(1), rs.getString(2), rs.getString(3), rs.getLong(4), rs.getString(5),
						rs.getString(6));
				return user;
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return null;
	}

	@Override
	public boolean updatePassword(int id, String password) {
		Connection conn = DBConnection.getConnector();
		String qry = "update emps set password = ? where eid = ?";
		PreparedStatement ps;
		try {
			ps = conn.prepareStatement(qry);
			ps.setString(1, password);
			ps.setInt(2, id);
			int res = ps.executeUpdate();

			if (res > 0) {
				return true;
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return false;
	}

	@Override
	public ArrayList<UserTestHis> userTestHistory(int id) {
		String query = "SELECT q.quizname AS quiz_name, s.subname AS subject_name, "
				+ "r.percentage AS percentage, r.resstatus AS result_status, r.date AS date_taken, q.quizId as quizId " + "FROM result r "
				+ "JOIN quizzs q ON r.quizId = q.quizId " + "JOIN subjects s ON q.subId = s.subId "
				+ "JOIN emps e ON r.userId = e.eid " + "WHERE r.userId = ?";

		Connection con = DBConnection.getConnector();
		PreparedStatement pst;
		ArrayList<UserTestHis> list = null;
		try {
			pst = con.prepareStatement(query);
			pst.setInt(1, id);
			ResultSet rs = pst.executeQuery();
			list = new ArrayList<UserTestHis>();
			while (rs.next()) {
				UserTestHis uth = new UserTestHis();
				uth.setQuizName(rs.getString("quiz_name"));
				uth.setCategory(rs.getString("subject_name"));
				uth.setScorePer(rs.getDouble("percentage"));
				uth.setStatus(rs.getString("result_status"));
				uth.setQuizId(rs.getInt("quizId"));

				// Convert Date to String (safe)
				Date dt = rs.getDate("date_taken");
				uth.setDateTaken(dt != null ? dt.toString() : "N/A");

				list.add(uth);
			}
			return list;
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return list;
	}

	@Override
	public ArrayList<UserManage> getUsers() {
		Connection con = DBConnection.getConnector();

		String str = "SELECT e.eid AS empid, e.name AS ename, e.email AS email, e.role AS erole, "
				+ "SUM(CASE WHEN r.resstatus = 'pass' THEN 1 ELSE 0 END) AS total_certificates, "
				+ "COUNT(r.userId) AS total_quizzes_attended " + "FROM emps e LEFT JOIN result r ON e.eid = r.userid "
				+ "WHERE e.role != 'Admin' "+ "GROUP BY e.eid, e.name, e.email, e.role";
		ArrayList<UserManage> list = null;
		try {
			PreparedStatement ps = con.prepareStatement(str);
			ResultSet rs = ps.executeQuery();
			list = new ArrayList<>();
			while (rs.next()) {
				UserManage usr = new UserManage();
				usr.setId(rs.getInt(1));
				usr.setName(rs.getString(2));
				usr.setEmail(rs.getString(3));
				usr.setRole(rs.getString(4));
				usr.setTotalQuizAttend(rs.getInt(5));
				usr.setCertificateAchieve(rs.getInt(6));

				list.add(usr);

			}
			return list;
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return null;
	}

	@Override
	public ArrayList<Subject> getSubjects() {

		ArrayList<Subject> sub = new ArrayList<>();

		Connection conn = DBConnection.getConnector();

		String str = "SELECT sb.subId AS subid, sb.subname AS subName, COUNT(q.quizid) AS total_quizzes "
				+ "FROM subjects sb " + "LEFT JOIN quizzs q ON sb.subId = q.subid " + "GROUP BY sb.subId, sb.subname";

		try {
			PreparedStatement pstmt = conn.prepareStatement(str);
			ResultSet rs = pstmt.executeQuery();

			while (rs.next()) {
				Subject subject = new Subject();
				subject.setSubId(rs.getInt("subid"));
				subject.setSubname(rs.getString("subName"));
				subject.setQuizCount(rs.getInt("total_quizzes"));
				sub.add(subject);
			}

		} catch (SQLException e) {
			e.printStackTrace();
		}

		return sub;
	}

	@Override
	public ArrayList<Quizzes> getQuizzes() {
		ArrayList<Quizzes> quiz = new ArrayList<Quizzes>();
		Connection conn = DBConnection.getConnector();
		String str = "SELECT q.quizid AS ID, q.quizname AS Title, s.subname AS SubjectName, "
				+ "COUNT(ques.quesid) AS Total_Questions, q.quizmarks AS Marks " + "FROM quizzs q "
				+ "JOIN subjects s ON q.subid = s.subid " + "LEFT JOIN questions ques ON q.quizid = ques.quizid "
				+ "GROUP BY q.quizid, q.quizname, s.subname, q.quizmarks";

		try {
			PreparedStatement pstmt = conn.prepareStatement(str);
			ResultSet rs = pstmt.executeQuery();
			while (rs.next()) {
				Quizzes qz = new Quizzes();
				qz.setUserId(rs.getInt(1));
				qz.setTitle(rs.getString(2));
				qz.setCategory(rs.getString(3));
				qz.setQuestions(rs.getInt(4));
				qz.setMarks(rs.getInt(5));
				quiz.add(qz);
			}

		} catch (SQLException e) {
			e.printStackTrace();
		}
		return quiz;
	}

	@Override
	public ArrayList<Quizzes> getQuizzesByCategory(int categoryId) {

		ArrayList<Quizzes> list = new ArrayList<>();

		Connection conn = DBConnection.getConnector();

		String sql = "SELECT q.quizid AS quiz_id, q.quizname AS title, "
				+ "COUNT(ques.quesid) AS total_questions, q.quizmarks AS marks " + "FROM quizzs q "
				+ "LEFT JOIN questions ques ON q.quizid = ques.quizid " + "WHERE q.subid = ? "
				+ "GROUP BY q.quizid, q.quizname, q.quizmarks";

		try {
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setInt(1, categoryId);

			ResultSet rs = ps.executeQuery();

			while (rs.next()) {
				Quizzes q = new Quizzes();
				q.setUserId(rs.getInt("quiz_id"));
				q.setTitle(rs.getString("title"));
				q.setQuestions(rs.getInt("total_questions"));
				q.setMarks(rs.getInt("marks"));

				list.add(q);
			}

		} catch (Exception e) {
			e.printStackTrace();
		}

		return list;
	}

	@Override
	public Performance getPerformance(int userId) {
		Connection conn = DBConnection.getConnector();
		Performance performance=new Performance();
		try {
			String qry="SELECT COUNT(DISTINCT r.resid) AS total_attempts, AVG(r.percentage) AS avg_percentage, COUNT(q.quesId) AS total_questions FROM result r JOIN questions q  ON r.quizId = q.quizId WHERE r.userId = ?";
			PreparedStatement pStatement=conn.prepareStatement(qry);
			pStatement.setInt(1, userId);
			ResultSet rSet=pStatement.executeQuery();
			if(rSet.next()) {
				performance.setQuizesTaken(rSet.getInt(1));
				performance.setAverageScore(Math.round(rSet.getDouble(2) * 100.0) / 100.0);
				performance.setQuesAnswered(rSet.getInt(3));
			}
			qry="SELECT count(*) FROM result WHERE userId=? AND resstatus='PASS'";
			pStatement=conn.prepareStatement(qry);
			pStatement.setInt(1, userId);
			ResultSet rSet2=pStatement.executeQuery();
			if(rSet2.next()) {
				performance.setCertificates(rSet2.getInt(1));
			}
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return performance;
	}
	
	public boolean newPassword(String email, String password) {
		Connection conn = DBConnection.getConnector();
		String qry = "update emps set password = ? where email = ?";
		System.out.println(email+" "+password);
		PreparedStatement ps;
		try {
			ps = conn.prepareStatement(qry);
			ps.setString(1, password);
			ps.setString(2, email);
			int res = ps.executeUpdate();
			System.out.println("res-"+res);
			if (res > 0) {
				return true;
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return false;
	}

	@Override
	public String getResultId(int userId, int quizId) {
		Connection conn = DBConnection.getConnector();
		String qry="SELECT resid from result where userId=? and quizId=?";
		try {
			PreparedStatement pStatement=conn.prepareStatement(qry);
			pStatement.setInt(1, userId);
			pStatement.setInt(2, quizId);
			ResultSet rSet=pStatement.executeQuery();
			if(rSet.next()) {
				return rSet.getString(1);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return null;
	}
}