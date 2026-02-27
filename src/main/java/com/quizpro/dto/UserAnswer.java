package com.quizpro.dto;

import java.io.Serializable;

public class UserAnswer implements Serializable {
    private static final long serialVersionUID = 1L;

    private int questionId;
    private String chosenAnswer;

    public UserAnswer() {}

    public UserAnswer(int questionId, String chosenAnswer) {
        this.questionId = questionId;
        this.chosenAnswer = chosenAnswer;
    }

    public int getQuestionId() {
        return questionId;
    }

    public void setQuestionId(int questionId) {
        this.questionId = questionId;
    }

    public String getChosenAnswer() {
        return chosenAnswer;
    }

    public void setChosenAnswer(String chosenAnswer) {
        this.chosenAnswer = chosenAnswer;
    }
}
