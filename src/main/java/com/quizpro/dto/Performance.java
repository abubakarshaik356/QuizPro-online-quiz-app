package com.quizpro.dto;

public class Performance {
	
	private int quizesTaken;
	private double averageScore;
	private int quesAnswered;
	private int certificates;
	public int getCertificates() {
		return certificates;
	}
	public void setCertificates(int certificates) {
		this.certificates = certificates;
	}
	public int getQuizesTaken() {
		return quizesTaken;
	}
	public void setQuizesTaken(int quizesTaken) {
		this.quizesTaken = quizesTaken;
	}
	public double getAverageScore() {
		return averageScore;
	}
	public void setAverageScore(double averageScore) {
		this.averageScore = averageScore;
	}
	public int getQuesAnswered() {
		return quesAnswered;
	}
	public void setQuesAnswered(int quesAnswered) {
		this.quesAnswered = quesAnswered;
	}
	
	
}
