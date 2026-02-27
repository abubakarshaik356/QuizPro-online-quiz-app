package com.quizpro.dto;

public class Quizzes {

	@Override
	public String toString() {
		return "Quizzes [quizId=" + quizId + ", desc=" + desc + ", userId=" + userId + ", title=" + title
				+ ", category=" + category + ", questions=" + questions + ", marks=" + marks + ", date=" + date + "]";
	}
	private int quizId;
	private String desc;
	public String getDesc() {
		return desc;
	}

	public void setDesc(String desc) {
		this.desc = desc;
	}

	public int getQuizId() {
		return quizId;
	}

	public void setQuizId(int quizId) {
		this.quizId = quizId;
	}
	private int userId;
	private String title;
	private String category;
	private int questions;
	private int marks;
	private String date;
	private String quizLevel;
	public String getQuizLevel() {
		return quizLevel;
	}

	public void setQuizLevel(String quizLevel) {
		this.quizLevel = quizLevel;
	}

	public Quizzes(int userId, String title, String category, int questions,int marks, String date) {
		super();
		this.userId = userId;
		this.title = title;
		this.category = category;
		this.questions = questions;
		this.date = date;
	}
	
	public int getMarks() {
		return marks;
	}

	public void setMarks(int marks) {
		this.marks = marks;
	}

	public Quizzes() {
		super();
	}
	public int getUserId() {
		return userId;
	}
	public void setUserId(int userId) {
		this.userId = userId;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getCategory() {
		return category;
	}
	public void setCategory(String category) {
		this.category = category;
	}
	public int getQuestions() {
		return questions;
	}
	public void setQuestions(int questions) {
		this.questions = questions;
	}
	public String getDate() {
		return date;
	}
	public void setDate(String date) {
		this.date = date;
	}
	
}
