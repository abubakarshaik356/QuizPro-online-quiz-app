package com.quizpro.dto;

public class Questions {

	private int id;
	private String question;
	private String option1;
	private String option2;
	private String option3;
	private String option4;
	private String answer;
	private int quizId;
	private String OptionType;
	public Questions(int id, String question, String option1, String option2, String option3, String option4,
			String answer, int quizId,String quesType) {
		super();
		this.id = id;
		this.question = question;
		this.option1 = option1;
		this.option2 = option2;
		this.option3 = option3;
		this.option4 = option4;
		this.answer = answer;
		this.quizId = quizId;
		this.OptionType = quesType;
	}
	public Questions() {
		super();
	}
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getQuestion() {
		return question;
	}
	public void setQuestion(String question) {
		this.question = question;
	}
	public String getOption1() {
		return option1;
	}
	public void setOption1(String option1) {
		this.option1 = option1;
	}
	public String getOption2() {
		return option2;
	}
	public void setOption2(String option2) {
		this.option2 = option2;
	}
	public String getOption3() {
		return option3;
	}
	public void setOption3(String option3) {
		this.option3 = option3;
	}
	public String getOption4() {
		return option4;
	}
	public void setOption4(String option4) {
		this.option4 = option4;
	}
	public String getAnswer() {
		return answer;
	}
	public void setAnswer(String answer) {
		this.answer = answer;
	}
	public int getQuizId() {
		return quizId;
	}
	public void setQuizId(int quizId) {
		this.quizId = quizId;
	}
	public String getOptionType() {
		return OptionType;
	}
	public void setOptionType(String optionType) {
		OptionType = optionType;
	}
	
	
}
