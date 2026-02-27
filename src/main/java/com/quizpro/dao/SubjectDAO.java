package com.quizpro.dao;

import java.util.List;

import com.quizpro.dto.Quizzes;
import com.quizpro.dto.Subject;

public interface SubjectDAO {
    List<Subject> getAllSubjects();
    List<Quizzes> getAllQuizes(int subId, int userid);
}