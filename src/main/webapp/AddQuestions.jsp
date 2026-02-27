<%@page import="com.quizpro.dto.Questions"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
	int quizId = (int) session.getAttribute("QuizId");
    String quizTitle = (String) session.getAttribute("QuizName");
    String quizCategory = (String) session.getAttribute("QuizCategory");
	int noOfQues = (int) session.getAttribute("NoOfQuestions");
    ArrayList<Questions> questions = (ArrayList<Questions>) session.getAttribute("ListQuestions");
    int questionCount = questions.size();
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>QuizPro - Add Questions</title>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;600;800&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">

    <style>
:root {
    --primary-color: #0077B6;
    --accent-color: #FFB700;
    --dark-bg: #F0F2F5;
    --light-text: #212529;
    --card-bg: #FFFFFF;
    --subtle-gray: #6C757D;
    --shadow-light: rgba(0, 0, 0, 0.08);
    --success-color: #28a745;
    --danger-color: #dc3545;
}

body {
    font-family: 'Inter', sans-serif;
    margin: 0;
    padding: 0;
    background-color: var(--dark-bg);
    color: var(--light-text);
}

.admin-layout {
    display: flex;
    min-height: 100vh;
}

.sidebar {
    width: 250px;
    background-color: var(--primary-color);
    color: white;
    padding: 20px;
    height: 100vh;
    position: sticky;
    top: 0;
}

.sidebar .logo {
    font-size: 2em;
    font-weight: 800;
    text-align: center;
    color: white;
    text-decoration: none;
    display: block;
    margin-bottom: 30px;
}

.sidebar .logo span {
    color: var(--accent-color);
}

.sidebar nav a {
    display: block;
    padding: 15px 10px;
    margin-bottom: 5px;
    border-radius: 8px;
    color: rgba(255,255,255,0.9);
    text-decoration: none;
    font-weight: 600;
}

.sidebar nav a.active,
.sidebar nav a:hover {
    background-color: rgba(255,255,255,0.15);
}

.main-content {
    flex-grow: 1;
    padding: 30px;
}

.page-header {
    border-bottom: 1px solid #ddd;
    margin-bottom: 20px;
}

.quiz-summary {
    background: var(--card-bg);
    border-left: 5px solid var(--accent-color);
    padding: 15px 25px;
    border-radius: 8px;
    box-shadow: 0 2px 4px var(--shadow-light);
    margin-bottom: 25px;
}

/* ******************************
   FULL-WIDTH QUESTION SECTION
******************************** */
.editor-container {
    display: block !important;
    width: 100% !important;
}

.question-form-card {
    background: var(--card-bg);
    padding: 30px;
    border-radius: 10px;
    box-shadow: 0 4px 10px var(--shadow-light);
    width: 94% !important;
    max-width: 100% !important;
}

.form-group {
    margin-bottom: 20px;
}

.form-group label {
    font-weight: 600;
    display: block;
    margin-bottom: 8px;
}


.form-group select,
.form-group input[type="text"] {
    width: 100%;
    padding: 12px;
    border-radius: 6px;
    border: 1px solid #ccc;
    font-size: 1em;
}
.form-group textarea{
	width: 97%;
    padding: 12px;
    border-radius: 6px;
    border: 1px solid #ccc;
    font-size: 1em;
}

.answer-option {
    display: flex;
    align-items: center;
    gap: 10px;
    margin-bottom: 10px;
    background: #f0f0f0;
    padding: 10px;
    border-radius: 6px;
}

.answer-option input[type="text"] {
    flex: 1;
}

.add-option-btn,
.remove-option-btn {
    border: none;
    background: none;
    cursor: pointer;
    font-size: 1.3em;
}

.add-option-btn {
    color: var(--success-color);
}

.remove-option-btn {
    color: var(--danger-color);
}

.save-button {
    background: var(--success-color);
    padding: 15px;
    width: 100%;
    border: none;
    color: white;
    border-radius: 8px;
    font-size: 1.1em;
    cursor: pointer;
    font-weight: 700;
}

.question-list-card {
    background: var(--card-bg);
    padding: 20px;
    border-radius: 10px;
    box-shadow: 0 4px 10px var(--shadow-light);
}

.question-list-card ul {
    list-style: none;
    padding: 0;
}

.question-list li {
    padding: 10px;
    border-bottom: 1px dashed #ddd;
    cursor: pointer;
}

.question-list li:hover {
    background: #f5f5f5;
}

.finish-quiz-btn {
    display: block;
    margin-top: 20px;
    text-align: center;
    padding: 12px;
    background: var(--accent-color);
    border-radius: 8px;
    text-decoration: none;
    font-weight: 700;
    color: black;
}
</style>
    
</head>

<body>

<div class="admin-layout">

<%@ include file="adminSideBar.jsp" %>

<main class="main-content">

    <div class="page-header">
        <h1>Add / Edit Questions</h1>
    </div>

    <div class="quiz-summary">
        <p>Quiz: <strong><%= quizTitle != null ? quizTitle : "Sample Quiz" %></strong></p>
        <p>Category: <strong><%= quizCategory != null ? quizCategory : "General" %></strong></p>
        <p>Total Questions: <strong><%= questionCount + 1 %> of <%= noOfQues %></strong></p>
    </div>

    <div class="editor-container">

        <!-- QUESTION FORM -->
        <div class="question-form-card">

            <h2>Add New Question</h2>

            <form action="ADDQuestion" method="post">

                <div class="form-group">
                    <label>Question Text</label>
                    <textarea name="question_text" required></textarea>
                </div>

                <div class="form-group">
                <input type = "hidden" value="<%=quizId  %>" name="QuizId">
                    <label>Question Type</label>
                    <select id="type" name="type" onchange="updateOptions()" required>
                        <option value="mcq">Multiple Choice</option>
                        <option value="multi-select">Multi-Select</option>
                        <option value="true-false">True/False</option>
                    </select>
                </div>

                <div class="form-group">
                    <label>Answer Options</label>
                    <div id="optionsContainer"></div>

                    <button type="button" class="add-option-btn" id="addOptionUIBtn" onclick="addOption()">
                        <i class="fas fa-plus-circle"></i>
                    </button>
                </div>

                <button class="save-button" type="submit">
                    <i class="fas fa-save"></i> Save Question
                </button>

            </form>
        </div>

       <%--  <!-- QUESTION LIST -->
        <div class="question-list-card">
            <h3>Current Questions</h3>

            <ul class="question-list">
                <% int i = 1; for (Questions q : questions) { %>
                    <li><%= i %>. <%= q.getQuestion() %></li>
                <% i++; } %>
            </ul>

            <a class="finish-quiz-btn" href="#">Finish</a>
        </div> --%>

    </div>

</main>
</div>

<script>

/* ---------------------------
   UPDATED OPTION LOGIC (Answer text instead of number)
----------------------------*/

function updateOptions() {
    const type = document.getElementById("type").value;
    const container = document.getElementById("optionsContainer");

    container.innerHTML = "";

    let optionCount = (type === "true-false") ? 2 : 4;
    let inputType = (type === "multi-select") ? "checkbox" : "radio";

    document.getElementById("addOptionUIBtn").style.display =
        (type === "true-false") ? "none" : "inline-block";

    for (let i = 1; i <= optionCount; i++) {
        const label = (type === "true-false") ? (i === 1 ? "True" : "False") : "Option " + i;

        const div = document.createElement("div");
        div.className = "answer-option";

        div.innerHTML = `
            <input type="${inputType}" 
                   name="${type === 'multi-select' ? 'correct_answers' : 'correct_answer'}" 
                   value="${label}"
                   class="correctOption">

            <input type="text" 
                   name="option${i}" 
                   value="${label}" 
                   ${type === "true-false" ? "readonly" : ""}
                   oninput="this.previousElementSibling.value = this.value;"
                   required>
        `;

        container.appendChild(div);
    }
}

let dynamicOptionCount = 4;

function addOption() {
    const type = document.getElementById("type").value;
    if (type === "true-false") return;

    dynamicOptionCount++;

    const container = document.getElementById("optionsContainer");
    const inputType = type === "multi-select" ? "checkbox" : "radio";

    const div = document.createElement("div");
    div.className = "answer-option";

    div.innerHTML = `
        <input type="${inputType}" 
               name="${type === 'multi-select' ? 'correct_answers' : 'correct_answer'}" 
               value="Option ${dynamicOptionCount}"
               class="correctOption">

        <input type="text" 
               name="option${dynamicOptionCount}" 
               placeholder="Option ${dynamicOptionCount}"
               oninput="this.previousElementSibling.value = this.value;"
               required>

        <button type="button" class="remove-option-btn" 
                onclick="this.parentElement.remove()">
            <i class="fas fa-times-circle"></i>
        </button>
    `;

    container.appendChild(div);
}

document.addEventListener("DOMContentLoaded", updateOptions);
</script>

</body>
</html>
