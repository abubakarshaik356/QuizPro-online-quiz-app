<%@page import="com.quizpro.dto.Quizzes"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<% 
	Quizzes quiz = (Quizzes)request.getAttribute("QuizDetails");
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>QuizPro - Test Overview</title>
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
            --danger-color: #dc3545;
        }

        /* Basic Setup (Reused) */
        body {
            font-family: 'Inter', sans-serif;
            margin: 0;
            padding: 0;
            background-color: var(--dark-bg);
            color: var(--light-text);
            line-height: 1.6;
        }

        .container {
            max-width: 900px;
            margin: 0 auto;
            padding: 0 15px;
        }

        /* --- Test Overview Specific Styling --- */
        .overview-header {
            text-align: center;
            padding: 50px 0 30px;
        }
        .overview-header h1 {
            font-size: 2.8em;
            margin-bottom: 5px;
            color: var(--primary-color);
        }
        .overview-header p {
            font-size: 1.1em;
            color: var(--subtle-gray);
        }
        
        .overview-grid {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 20px;
            margin-bottom: 40px;
        }

        .info-card, .rules-card {
            background-color: var(--card-bg);
            padding: 30px;
            border-radius: 12px;
            box-shadow: 0 4px 10px var(--shadow-light);
            height: 100%; /* Ensures cards in the grid are the same height */
        }
        
        .info-card h3, .rules-card h3 {
            font-size: 1.5em;
            margin-top: 0;
            margin-bottom: 20px;
            padding-bottom: 10px;
            border-bottom: 2px solid var(--dark-bg);
        }

        /* Test Metrics */
        .metric-item {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 12px 0;
            border-bottom: 1px dashed #E9ECEF;
            font-size: 1em;
        }
        .metric-item:last-child {
            border-bottom: none;
        }
        .metric-item strong {
            display: flex;
            align-items: center;
            font-weight: 700;
        }
        .metric-item strong i {
            margin-right: 10px;
            color: var(--primary-color);
            font-size: 1.2em;
        }
        .metric-value {
            font-weight: 800;
            color: var(--light-text);
        }
        .metric-value.pass {
            color: var(--danger-color); 
        }

        /* Rules List */
        .rules-card ul {
            list-style: none;
            padding: 0;
        }
        .rules-card li {
            margin-bottom: 15px;
            display: flex;
            align-items: flex-start;
            font-size: 1em;
        }
        .rules-card li i {
            color: var(--primary-color);
            margin-right: 10px;
            margin-top: 3px;
        }

        /* Action Buttons */
        .action-area {
            text-align: center;
            padding: 20px 0 60px;
        }
        .start-button {
            background-color: var(--primary-color);
            color: white;
            padding: 15px 40px;
            border-radius: 8px;
            text-decoration: none;
            font-weight: 800;
            font-size: 1.2em;
            transition: background-color 0.2s;
            margin: 0 15px;
        }
        .start-button:hover {
            background-color: #005691;
        }
        .back-button {
            background-color: var(--subtle-gray);
            color: white;
            padding: 15px 40px;
            border-radius: 8px;
            text-decoration: none;
            font-weight: 700;
            font-size: 1.2em;
            transition: opacity 0.2s;
        }
        .back-button:hover {
            opacity: 0.8;
        }

        /* Responsive adjustments */
        @media (max-width: 768px) {
            .overview-grid {
                grid-template-columns: 1fr;
            }
            .action-area {
                display: flex;
                flex-direction: column;
                gap: 15px;
            }
            .start-button, .back-button {
                margin: 0;
                width: 100%;
            }
        }
    </style>
</head>
<body>

    <header class="overview-header">
        <h1>Test Setup: <%=quiz.getTitle() %></h1>
        <p>Review the details and rules before beginning the assessment.</p>
    </header>

    <div class="container">
        
        <div class="overview-grid">
            
            <div class="info-card">
                <h3>Test Details</h3>
                
                <div class="metric-item">
                    <strong><i class="fas fa-list-ol"></i> Total Questions</strong>
                    <span class="metric-value"><%=quiz.getQuestions() %></span>
                </div>
                
                <div class="metric-item">
                    <strong><i class="fas fa-clock"></i> Time Allowed</strong>
                    <span class="metric-value">1 Min perQues</span>
                </div>
                
                <div class="metric-item">
                    <strong><i class="fas fa-signal"></i> Difficulty Level</strong>
                    <span class="metric-value" style="color: var(--accent-color);"><%=quiz.getQuizLevel() %></span>
                </div>
                
                <div class="metric-item">
                    <strong><i class="fas fa-percent"></i> Passing Score</strong>
                    <span class="metric-value pass">80%</span>
                </div>
                
                <div class="metric-item">
                    <strong><i class="fas fa-redo"></i> Retakes Available</strong>
                    <span class="metric-value">Available</span>
                </div>
            </div>

            <div class="rules-card">
                <h3>Rules and Format</h3>
                <ul>
                    <li><i class="fas fa-check-circle"></i> Multiple Choice: All questions are multiple-choice with only one correct answer.</li>
                    <li><i class="fas fa-check-circle"></i> No Penalty: There is no penalty for incorrect answers.</li>
                    <li><i class="fas fa-check-circle"></i> Navigation: You can navigate freely between questions using the sidebar navigator.</li>
                    <li><i class="fas fa-times-circle" style="color: var(--danger-color);"></i> Once Submitted: The test cannot be resumed or reset once you click "End Test."</li>
                </ul>
            </div>
            
        </div>
        
        <div class="action-area">
            <a href="categories" class="back-button">
                <i class="fas fa-arrow-left"></i> Change Quiz
            </a>
            <a href="Test?quizId=<%=quiz.getQuizId() %>" class="start-button">
                <i class="fas fa-play"></i> Start Test Now
            </a>
        </div>
        
    </div>
	
	
</body>
</html>
