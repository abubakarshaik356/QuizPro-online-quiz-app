package com.quizpro.dto;

public class Subject {
    private int subId;
    private String subname;
    private String subDesc;

    private int quizCount;

    public int getQuizCount() {
        return quizCount;
    }
    public void setQuizCount(int quizCount) {
        this.quizCount = quizCount;
    }
    
    public int getSubId() {
        return subId;
    }
    public void setSubId(int subId) {
        this.subId = subId;
    }
    public String getSubname() {
        return subname;
    }
    public void setSubname(String subname) {
        this.subname = subname;
    }
    public String getSubDesc() {
        return subDesc;
    }
    public void setSubDesc(String subDesc) {
        this.subDesc = subDesc;
    }
	@Override
	public String toString() {
		return "Subject [subId=" + subId + ", subname=" + subname + ", subDesc=" + subDesc + ", quizCount=" + quizCount
				+ "]";
	}
    
}

