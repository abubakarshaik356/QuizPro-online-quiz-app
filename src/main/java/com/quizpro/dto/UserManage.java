package com.quizpro.dto;

public class UserManage {

	private int id;
	private String name;
	private String email;
	private String role;
	private int TotalQuizAttend;
	private int CertificateAchieve;
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getRole() {
		return role;
	}
	public void setRole(String role) {
		this.role = role;
	}
	public int getTotalQuizAttend() {
		return TotalQuizAttend;
	}
	public void setTotalQuizAttend(int totalQuizAttend) {
		TotalQuizAttend = totalQuizAttend;
	}
	public int getCertificateAchieve() {
		return CertificateAchieve;
	}
	public void setCertificateAchieve(int certificateAchieve) {
		CertificateAchieve = certificateAchieve;
	}
	public UserManage(int id, String name, String email, String role, int totalQuizAttend, int certificateAchieve) {
		super();
		this.id = id;
		this.name = name;
		this.email = email;
		this.role = role;
		TotalQuizAttend = totalQuizAttend;
		CertificateAchieve = certificateAchieve;
	}
	public UserManage() {
		super();
	}
	
	
	
}
