package com.quizpro.dto;

public class UserTestHis {

	private String quizName;
	private String category;
	private String dateTaken;
	private double scorePer;
	private String status;
	private int quizId;

	public int getQuizId() {
		return quizId;
	}

	public void setQuizId(int quizId) {
		this.quizId = quizId;
	}

	public UserTestHis(String quizName, String category, String dateTaken, double scorePer, String status) {
		super();
		this.quizName = quizName;
		this.category = category;
		this.dateTaken = dateTaken;
		this.scorePer = scorePer;
		this.status = status;
	}

	public String getQuizName() {
		return quizName;
	}

	public void setQuizName(String quizName) {
		this.quizName = quizName;
	}

	public String getCategory() {
		return category;
	}

	public void setCategory(String category) {
		this.category = category;
	}

	public String getDateTaken() {
		return dateTaken;
	}

	public void setDateTaken(String dateTaken) {
		this.dateTaken = dateTaken;
	}

	public double getScorePer() {
		return scorePer;
	}

	public void setScorePer(double scorePer) {
		this.scorePer = scorePer;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public UserTestHis() {
		super();
	}

	
}
