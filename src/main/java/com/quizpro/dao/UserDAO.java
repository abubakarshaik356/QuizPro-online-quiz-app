package com.quizpro.dao;

import java.util.ArrayList;

import com.quizpro.dto.Performance;
import com.quizpro.dto.Quizzes;
import com.quizpro.dto.Subject;
import com.quizpro.dto.User;
import com.quizpro.dto.UserManage;
import com.quizpro.dto.UserTestHis;

public interface UserDAO {
	public boolean signup(String name, String email,String role, long phone, String password);
	public User login(String email, String password);
	public boolean updatePassword(int id,String password);
	public ArrayList<UserTestHis> userTestHistory(int id);
	public ArrayList<UserManage> getUsers();
	public ArrayList<Subject> getSubjects();
	public ArrayList<Quizzes> getQuizzes();
	ArrayList<Quizzes> getQuizzesByCategory(int categoryId);
	public boolean isEmailExist(String email);
	Performance getPerformance(int userId);
	boolean newPassword(String email, String password);
	String getResultId(int userId, int quizId);
}
