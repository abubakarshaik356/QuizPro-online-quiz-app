package com.quizpro.dao;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

import com.quizpro.dto.Quizzes;
import com.quizpro.dto.Subject;
import com.quizpro.util.DBConnection;

public class SubjectDAOImpl implements SubjectDAO {
    static Connection con = DBConnection.getConnector();

    @Override
    public List<Subject> getAllSubjects() {
        List<Subject> list = new ArrayList<>();
        String sql = "SELECT subId, subname, subDesc FROM subjects";

        try {
            PreparedStatement ps = con.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();

            while(rs.next()) {
                Subject s = new Subject();
                s.setSubId(rs.getInt("subId"));
                s.setSubname(rs.getString("subname"));
                s.setSubDesc(rs.getString("subDesc"));
                
                // --- Fetch quiz count for this subject ---
                String quizSql = "SELECT COUNT(*) FROM quizzs WHERE subId=?";
                try (PreparedStatement ps2 = con.prepareStatement(quizSql)) {
                    ps2.setInt(1, s.getSubId());
                    ResultSet rs2 = ps2.executeQuery();
                    if(rs2.next()) {
                        s.setQuizCount(rs2.getInt(1)); // <-- new field in Subject DTO
                    }
                }
                
                list.add(s);
            }
        } catch(Exception e) {
            e.printStackTrace();
        }
        return list;
    }

	@Override
	public List<Quizzes> getAllQuizes(int subId, int userid) {
		List<Quizzes> quizes=new ArrayList<Quizzes>();
		String qry = "SELECT q.quizid, q.quizname, q.description, q.quizmarks, r.percentage, q.quizlevel " +
	             "FROM quizzs q " +
	             "LEFT JOIN result r ON q.quizId = r.quizid AND r.userid = ? " +
	             "WHERE q.subId = ?";

		try {
			PreparedStatement ps=con.prepareStatement(qry);
			ps.setInt(1, userid);
			ps.setInt(2, subId);
			ResultSet rSet=ps.executeQuery();
			while(rSet.next()) {
				System.out.println("1");
				Quizzes quiz=new Quizzes();
				quiz.setQuizId(rSet.getInt(1));
				quiz.setTitle(rSet.getString(2));
				quiz.setDesc(rSet.getString(3));
				quiz.setQuestions(rSet.getInt(4));
				quiz.setMarks((int)rSet.getFloat(5));
				quiz.setQuizLevel(rSet.getString(6));
				quizes.add(quiz);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		
		return quizes;
	}
}
