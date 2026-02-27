<%@page import="com.quizpro.dto.Quizzes"%>
<%@page import="com.quizpro.dao.AdminDAOImpl"%>
<%@page import="com.quizpro.dao.AdminDAO"%>
<%@page import="com.quizpro.dto.Subject"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>QuizPro - Add New Quiz</title>
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

        /* Basic Setup & Admin Layout (Reused) */
        body {
            font-family: 'Inter', sans-serif;
            margin: 0;
            padding: 0;
            background-color: var(--dark-bg);
            color: var(--light-text);
            line-height: 1.6;
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
            box-shadow: 2px 0 5px rgba(0, 0, 0, 0.1);
            position: sticky;
            top: 0;
            height: 100vh;
            overflow-y: auto;
        }
        .sidebar .logo {
            font-size: 2em;
            font-weight: 800;
            display: block;
            text-align: center;
            margin-bottom: 30px;
            color: white;
            text-decoration: none;
        }
        .sidebar .logo span {
            color: var(--accent-color);
        }
        .sidebar nav a {
            display: block;
            color: rgba(255, 255, 255, 0.85);
            text-decoration: none;
            padding: 15px 10px;
            margin-bottom: 5px;
            border-radius: 8px;
            transition: background-color 0.2s;
            font-weight: 600;
        }
        .sidebar nav a:hover, .sidebar nav a.active {
            background-color: rgba(255, 255, 255, 0.15);
            color: white;
        }
        .sidebar nav a i {
            margin-right: 10px;
            font-size: 1.1em;
        }
        
        .main-content {
            flex-grow: 1;
            padding: 30px;
            background-color: var(--dark-bg);
        }

        /* --- Page Header --- */
        .page-header {
            margin-bottom: 30px;
            border-bottom: 1px solid #dee2e6;
            padding-bottom: 20px;
        }
        .page-header h1 {
            font-size: 2.2em;
            margin: 0;
            font-weight: 800;
        }
        .page-header p {
            color: var(--subtle-gray);
        }

        /* --- Form Container --- */
        .form-card {
            background-color: var(--card-bg);
            padding: 40px;
            border-radius: 10px;
            box-shadow: 0 4px 10px var(--shadow-light);
            max-width: 800px;
            margin: 0 auto;
        }

        .form-card h2 {
            font-size: 1.8em;
            color: var(--primary-color);
            margin-top: 0;
            margin-bottom: 25px;
            border-bottom: 1px solid #E9ECEF;
            padding-bottom: 10px;
        }

        /* Form Inputs */
        .form-group {
            margin-bottom: 20px;
        }
        .form-group label {
            display: block;
            font-weight: 600;
            margin-bottom: 8px;
            font-size: 1.1em;
        }
        .form-group input[type="text"],
        .form-group input[type="number"],
        .form-group textarea,
        .form-group select {
            width: 100%;
            padding: 12px;
            border: 1px solid #CED4DA;
            border-radius: 6px;
            box-sizing: border-box;
            font-size: 1em;
        }
        .form-group textarea {
            min-height: 100px;
            resize: vertical;
        }
        .form-group small {
            color: var(--subtle-gray);
            display: block;
            margin-top: 5px;
        }

        /* Submission Button */
        .cta-button {
            background-color: var(--primary-color);
            color: white;
            padding: 15px 30px;
            border: none;
            border-radius: 8px;
            font-weight: 700;
            font-size: 1.1em;
            cursor: pointer;
            transition: background-color 0.2s;
            width: 100%;
            margin-top: 20px;
        }
        .cta-button:hover {
            background-color: #005691;
        }
        
        /* Two-Column Layout for Settings */
        .setting-grid {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 20px;
        }

        /* Responsive adjustments */
        @media (max-width: 992px) {
            .admin-layout { flex-direction: column; }
            .sidebar { width: 100%; height: auto; position: static; display: flex; flex-direction: row; padding: 15px 0; overflow-x: auto; }
            .sidebar .logo { display: none; }
            .sidebar nav { display: flex; white-space: nowrap; padding: 0 15px; }
            .sidebar nav a { padding: 10px 15px; margin: 0 5px; }
            .main-content { padding: 20px; }
            .setting-grid { grid-template-columns: 1fr; }
            .form-card { padding: 20px; }
        }
    </style>
</head>
<body>
<% 
	AdminDAO admin = new AdminDAOImpl();
	ArrayList<Subject> subject = admin.getSubNames();
	int id=Integer.parseInt(request.getParameter("id"));
	AdminDAO adminDAO=new AdminDAOImpl();
	Quizzes quizzes=adminDAO.getQuizDetails(id);
	request.setAttribute("id", id);
%>
	
    <div class="admin-layout">
        <%@ include file="adminSideBar.jsp" %>
        

        <main class="main-content">
            <div class="page-header">
                <h1>Edit Existing Quiz</h1>
                <p>Define the essential metadata and settings for your new quiz.</p>
            </div>

            <div class="form-card">
                <h2>Quiz Metadata & Settings</h2>
                
                <form action="UpdateQuiz" method="GET"> 
                    
                    <div class="form-group">
                        <label for="title"><i class="fas fa-heading"></i> Quiz Title</label>
                        <input type="text" id="title" name="title" value="<%=quizzes.getTitle() %>" required>
                        <small>The main title visible to users.</small>
                    </div>

                    <div class="form-group">
                        <label for="description"><i class="fas fa-file-alt"></i> Short Description</label>
                        <textarea id="description" name="description" value="<%=quizzes.getDesc() %>" required><%=quizzes.getDesc() %></textarea>
                        <small>Appears on the quiz card and overview page.</small>
                    </div>
                    
                    <div class="form-group">
                        <label for="category"><i class="fas fa-tags"></i> Category</label>
                        <select id="category" name="category" required>
                            <option value="<%=quizzes.getCategory()%>"><%=quizzes.getCategory()%></option>
                            <% for(Subject sub:subject) { %>
                            <option value="<%= sub.getSubname() %>" name="category"><%= sub.getSubname() %></option>
                            <%} %>
                        </select>
                    </div>

                    <hr style="margin: 30px 0;">

                    <div class="setting-grid">
                        
                        <div class="form-group">
                            <label for="time"><i class="fas fa-clock"></i> Time Limit (Minutes)</label>
                            <input type="number" id="time" name="time" min="5" value="30" required>
                            <small>Set to 0 for no time limit.</small>
                        </div>
                        
                        <div class="form-group">
                            <label for="difficulty"><i class="fas fa-signal"></i> Difficulty Level</label>
                            <select id="difficulty" name="difficulty" required>
                                <option value="easy">Easy</option>
                                <option value="intermediate" selected>Intermediate</option>
                                <option value="advanced">Advanced</option>
                            </select>
                        </div>
                        
                        <div class="form-group">
                            <label for="passing_score"> Quiz Marks</label>
                            <input type="number" id="passing_score" name="passing_score" min="0" max="100" value="<%=quizzes.getMarks() %>" required>
                            <small>Total marks quiz can contains</small>
                        </div>
                        
                        <div class="form-group">
                           <!--  <label for="retakes"><i class="fas fa-redo"></i> Retakes Allowed</label>
                            <select id="retakes" name="retakes" required>
                                <option value="-1">Unlimited</option>
                                <option value="1">1</option>
                                <option value="3">3</option>
                                <option value="0">None</option>
                            </select> -->
                            <label for="passing_score">Quiz No Of Questions</label>
                            <input type="number" id="passing_score" name="NoOfQuestions" min="0" max="100" value="<%=quizzes.getQuestions() %>" required>
                            <small>Total No.of Questions quiz can contains</small>
                        </div>

                    </div>
                    
                    <button type="submit" class="cta-button">
                        Save Quiz & Proceed to Add Questions <i class="fas fa-arrow-right"></i>
                    </button>
                </form>
            </div>
            
        </main>
        
    </div>

</body>
</html>