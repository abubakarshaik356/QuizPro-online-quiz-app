package com.quizpro.dto;

public class User {
	private int userid;
	private String name;
	private String email;
	private long phone;
	private String role;
	private String password;
	public User(int userid, String name, String email, long phone,String role, String password) {
		super();
		this.userid = userid;
		this.name = name;
		this.email = email;
		this.phone = phone;
		this.password = password;
		this.role=role;
	}
	public String getRole() {
		return role;
	}
	public void setRole(String role) {
		this.role = role;
	}
	public int getUserid() {
		return userid;
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
	public long getPhone() {
		return phone;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public void setUserid(int userid) {
		this.userid = userid;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public void setPhone(long phone) {
		this.phone = phone;
	}
	public User() {
		super();
	}
	
}
