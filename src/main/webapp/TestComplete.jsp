<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quiz Result</title>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;600;800&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
    
    <style>
        :root {
            --primary-color: #0077B6; 
            --accent-color: #FFB700; 
            --dark-bg: #F0F2F5; 
            --light-text: #212529; 
            --card-bg: #FFFFFF; 
            --success-color: #28a745;
            --danger-color: #dc3545;
            --info-color: #17a2b8;
            --shadow-strong: rgba(0, 0, 0, 0.15);
        }

        body {
            font-family: 'Inter', sans-serif;
            margin: 0;
            padding: 0;
            background-color: var(--dark-bg);
            color: var(--light-text);
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
        }

        .result-container {
            width: 90%;
            max-width: 700px;
            background-color: var(--card-bg);
            padding: 40px;
            border-radius: 12px;
            box-shadow: 0 10px 25px var(--shadow-strong);
            text-align: center;
        }

        /* Result Status Box */
        .status-box {
            padding: 25px;
            border-radius: 8px;
            margin-bottom: 30px;
            color: white;
        }

        .status-box h1 {
            font-weight: 800;
            margin-top: 0;
            font-size: 2.5em;
        }
        
        /* Pass Styles */
        .status-pass {
            background-color: var(--success-color);
        }
        
        /* Fail Styles */
        .status-fail {
            background-color: var(--danger-color);
        }

        /* Score Details */
        .score-details {
            display: flex;
            justify-content: space-around;
            margin: 20px 0 40px;
            border-top: 1px solid #eee;
            border-bottom: 1px solid #eee;
            padding: 20px 0;
        }

        .metric {
            text-align: center;
        }

        .metric strong {
            display: block;
            font-size: 2.5em;
            font-weight: 800;
            color: var(--primary-color);
            margin-bottom: 5px;
        }

        .metric span {
            color: var(--subtle-gray);
            font-weight: 600;
            font-size: 0.9em;
        }

        /* Certificate Button */
        .certificate-btn {
            display: inline-block;
            background-color: var(--accent-color);
            color: var(--light-text); 
            padding: 15px 30px;
            border-radius: 8px;
            text-decoration: none;
            font-size: 1.1em;
            font-weight: 700;
            margin-top: 20px;
            transition: background-color 0.3s, transform 0.1s;
        }
        .certificate-btn:hover {
            background-color: #ffc830;
            transform: translateY(-2px);
        }
        .certificate-btn i {
            margin-right: 10px;
        }
        
        /* Action Buttons */
        .action-links {
            margin-top: 30px;
        }
        .action-links a {
            color: var(--info-color);
            text-decoration: none;
            margin: 0 15px;
            font-weight: 600;
        }
        .action-links a:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>
	<%
    String quizName = (String) request.getAttribute("quizName");
    int score = (int) request.getAttribute("score");
    int total = (int) request.getAttribute("totalQuestions");
    double perc = (score * 100.0) / total;
    int quizId = (int) request.getAttribute("quizId");
%>
	
    <div class="result-container">
        
        <div class="status-box" id="statusBox">
            </div>

        <h2 style="color: var(--primary-color); margin-bottom: 30px;"><i class="fas fa-clipboard-list"></i> Quiz: <span id="quizName">Loading Quiz...</span></h2>
        
        <div class="score-details">
            <div class="metric">
                <strong><span id="finalScore">--</span>%</strong>
                <span>Final Score</span>
            </div>
            <div class="metric">
                <strong><span id="questionsCorrect">--</span>/<span id="questionsTotal">--</span></strong>
                <span>Questions Correct</span>
            </div>
        </div>
        
        <div id="certificateArea">
            </div>

        <div class="action-links">
            <a href="dashboard.jsp"><i class="fas fa-home"></i> Back to Dashboard</a>
        </div>
        
    </div>

    <script>
    const quizName = "<%=quizName%>";
    const score = <%=score%>;
    const quizId = <%=quizId%>;
    const total = <%=total%>;
    const finalPerc = <%=perc%>.toFixed(2);

    document.getElementById("quizName").textContent = quizName;
    document.getElementById("finalScore").textContent = finalPerc;
    document.getElementById("questionsCorrect").textContent = score;
    document.getElementById("questionsTotal").textContent = total;

    const statusBox = document.getElementById("statusBox");
    const certificateArea = document.getElementById("certificateArea");

    if (finalPerc >= 80) {
        statusBox.classList.add("status-pass");
        statusBox.innerHTML = `
            <h1><i class="fas fa-check-circle"></i> PASS</h1>
            <p>Great job! You cleared the quiz.</p>
        `;

        certificateArea.innerHTML = `
            <a href="GenerateCertificate?quizId=${quizId}" class="certificate-btn" target="blank">
                <i class="fas fa-award"></i> Download Certificate
            </a>
        `;
    } else {
        statusBox.classList.add("status-fail");
        statusBox.innerHTML = `
            <h1><i class="fas fa-times-circle"></i> FAIL</h1>
            <p>You can try again to improve your score.</p>
        `;

        // No certificate on fail
        certificateArea.innerHTML = "";
    }
</script>


</body>
</html>