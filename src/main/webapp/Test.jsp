<%@page import="com.quizpro.dto.Questions"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.quizpro.dao.AdminDAOImpl"%>
<%@page import="com.quizpro.dao.AdminDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>QuizPro - Data Structures Quiz (Question 5/50)</title>
<link
	href="https://fonts.googleapis.com/css2?family=Inter:wght@400;600;800&display=swap"
	rel="stylesheet">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">

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

/* Basic Setup */
body {
	font-family: 'Inter', sans-serif;
	margin: 0;
	padding: 0;
	background-color: var(--dark-bg);
	color: var(--light-text);
	line-height: 1.6;
}

.container {
	max-width: 1200px;
	margin: 0 auto;
	padding: 0 15px;
}

/* --- Test Header (Fixed Top Bar) --- */
.test-header {
	background-color: var(--card-bg);
	padding: 15px 0;
	box-shadow: 0 2px 5px var(--shadow-light);
	position: sticky;
	top: 0;
	z-index: 100;
}

.test-header .container {
	display: flex;
	justify-content: space-between;
	align-items: center;
}

.test-title-area h2 {
	font-size: 1.5em;
	margin: 0;
	font-weight: 700;
}

.test-title-area p {
	font-size: 0.9em;
	color: var(--subtle-gray);
	margin: 0;
}

.test-status-area {
	display: flex;
	align-items: center;
	gap: 30px;
}

.status-box {
	text-align: center;
	font-weight: 600;
}

.status-box i {
	margin-right: 5px;
}

.timer {
	font-size: 1.2em;
	color: var(--danger-color);
}

.end-test-button {
	background-color: var(--danger-color);
	color: white;
	padding: 10px 15px;
	border-radius: 6px;
	text-decoration: none;
	font-weight: 700;
	transition: opacity 0.2s;
	border: none;
	cursor: pointer;
}

.end-test-button:hover {
	opacity: 0.8;
}

/* --- Main Content Layout --- */
.test-grid {
	display: grid;
	grid-template-columns: 3fr 1fr; /* Question | Sidebar */
	gap: 30px;
	padding: 30px 0;
}

/* --- Question Area --- */
.question-area {
	background-color: var(--card-bg);
	padding: 30px;
	border-radius: 12px;
	box-shadow: 0 4px 10px var(--shadow-light);
}

#question-number {
	font-size: 1.1em;
	color: var(--primary-color);
	margin-bottom: 10px;
	font-weight: 600;
}

#question-text {
	font-size: 1.4em;
	font-weight: 600;
	margin-bottom: 25px;
}

.question-code {
	background-color: #f4f4f4;
	padding: 15px;
	border-radius: 8px;
	font-family: 'Courier New', monospace;
	white-space: pre-wrap;
	margin-bottom: 20px;
	border: 1px solid #ddd;
	overflow-x: auto;
}

/* --- Answer Options (MCQ) --- */
.answer-option {
	display: flex;
	flex-direction: row;
	margin-bottom: 15px;
	background-color: var(--dark-bg);
	padding: 15px;
	border-radius: 8px;
	cursor: pointer;
	transition: background-color 0.2s, border 0.2s;
	border: 2px solid transparent;
}

.answer-label {
	display: flex;
	align-items: center;
	background-color: var(--dark-bg);
	/* padding: 15px; */
	border-radius: 8px;
	cursor: pointer;
	transition: background-color 0.2s, border 0.2s;
	border: 2px solid transparent;
}

.answer-label:hover {
	background-color: #e5e5e5;
}

.answer-input[type="radio"] {
	margin-right: 15px;
	transform: scale(1.2);
}

.answer-input:checked+.answer-option {
	border-color: var(--primary-color);
	background-color: #e6f2f9;
}

/* --- Navigation Footer --- */
.test-footer {
	margin-top: 30px;
	padding-top: 20px;
	border-top: 1px solid #E9ECEF;
	display: flex;
	justify-content: space-between;
}

.nav-button {
	padding: 12px 25px;
	border-radius: 8px;
	text-decoration: none;
	font-weight: 700;
	transition: opacity 0.2s;
}

.prev-button {
	background-color: var(--subtle-gray);
	color: white;
}

.next-button {
	background-color: var(--primary-color);
	color: white;
}

.mark-button {
	background-color: var(--accent-color);
	color: var(--light-text);
}

/* --- Sidebar (Question Navigator) --- */
.sidebar-area {
	position: sticky;
	top: 100px; /* Below the fixed header */
	align-self: flex-start;
}

.navigator-card {
	background-color: var(--card-bg);
	padding: 20px;
	border-radius: 12px;
	box-shadow: 0 4px 10px var(--shadow-light);
	margin-bottom: 20px;
}

.navigator-card h3 {
	font-size: 1.2em;
	margin: 0 0 15px 0;
	border-bottom: 1px solid #E9ECEF;
	padding-bottom: 10px;
}

.question-grid {
	display: grid;
	grid-template-columns: repeat(6, 1fr);
	gap: 10px;
}

.q-button {
	padding: 8px 0;
	border: 1px solid #CED4DA;
	border-radius: 6px;
	text-align: center;
	text-decoration: none;
	color: var(--light-text);
	font-weight: 600;
	transition: all 0.2s;
	background-color: white;
	font-size: 0.9em;
}

.q-button.answered {
	background-color: var(--success-color);
	color: white;
	border-color: var(--success-color);
}

.q-button.current {
	background-color: var(--primary-color);
	color: white;
	border-color: var(--primary-color);
	transform: scale(1.1);
	font-weight: 800;
}

.q-button.marked {
	border: 2px solid var(--accent-color);
}

/* Responsive adjustments */
@media ( max-width : 992px) {
	.test-grid {
		grid-template-columns: 1fr; /* Stack main content and sidebar */
	}
	.sidebar-area {
		position: static;
		top: auto;
	}
	.test-header .container {
		flex-direction: column;
		gap: 15px;
	}
}

@media ( max-width : 576px) {
	.test-status-area {
		gap: 15px;
		width: 100%;
		justify-content: space-between;
	}
	.end-test-button {
		padding: 8px 10px;
	}
	.question-grid {
		grid-template-columns: repeat(4, 1fr);
	}
}

.fullscreen-overlay {
	position: fixed; /* MUST be fixed */
	top: 0;
	left: 0;
	width: 100vw;
	height: 100vh;
	background: rgba(0, 0, 0, 0.85);
	display: flex; /* Flexbox centering */
	align-items: center; /* Vertical center */
	justify-content: center; /* Horizontal center */
	z-index: 99999;
}

.overlay-box {
	background: #ffffff;
	padding: 35px 45px;
	width: 420px;
	border-radius: 12px;
	text-align: center;
	/* Prevent top sticking */
	margin: 0;
}

.overlay-box h2 {
	margin-bottom: 15px;
	color: #0077B6;
}

.overlay-box ul {
	text-align: left;
	font-size: 14px;
	color: #333;
	margin-bottom: 25px;
}

.overlay-box li {
	margin-bottom: 8px;
}

.start-test-btn {
	background: #0077B6;
	color: white;
	padding: 12px 28px;
	border: none;
	border-radius: 6px;
	font-size: 15px;
	cursor: pointer;
}

.start-test-btn:hover {
	background: #005f8d;
}

/* Overlay */
#loadingOverlay {
    position: fixed;
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
    background: rgba(255, 255, 255, 0.6);
    backdrop-filter: blur(6px);
    display: none;
    align-items: center;
    justify-content: center;
    flex-direction: column;
    z-index: 9999;
}

/* Loader animation */
.loader {
    width: 50px;
    height: 50px;
    border: 5px solid #ddd;
    border-top: 5px solid #0077B6;
    border-radius: 50%;
    animation: spin 1s linear infinite;
}

#loadingOverlay p {
    margin-top: 15px;
    font-size: 16px;
    font-weight: 500;
    color: #333;
}

@keyframes spin {
    0% { transform: rotate(0deg); }
    100% { transform: rotate(360deg); }
}

/* Blur test content */
.blur {
    filter: blur(5px);
    pointer-events: none;
}

/* Inline code */
#question-text code {
    background-color: #f1f5f9;
    color: #0f172a;
    padding: 2px 6px;
    border-radius: 4px;
    font-family: Consolas, 'Courier New', monospace;
    font-size: 14px;
}

/* Block code */
#question-text pre {
    background: #0f172a;
    color: #e5e7eb;
    padding: 16px;
    border-radius: 10px;
    margin: 12px 0;
    overflow-x: auto;
    line-height: 1.5;
    box-shadow: inset 0 0 0 1px rgba(255,255,255,0.05);
}


#question-text pre code {
    background: none;
    padding: 0;
    color: inherit;
    font-size: 14px;
    white-space: pre;
}
#deviceBlock{
display:none;
position:fixed;
top:0;
left:0;
width:100%;
height:100%;
background:#111;
color:white;
z-index:9999;

flex-direction:column;
justify-content:center;
align-items:center;
text-align:center;
padding:20px;
font-family:Arial;
}

#deviceBlock h2{
font-size:28px;
margin-bottom:10px;
}

#deviceBlock p{
font-size:18px;
margin:6px 0;
}

#deviceBlock button{
margin-top:20px;
padding:12px 25px;
font-size:16px;
border:none;
background:#ff4444;
color:white;
border-radius:6px;
cursor:pointer;
}
</style>
</head>
<body>
<div id="deviceBlock">

<h2>⚠ Test Not Available on Mobile</h2>

<p>This test can only be taken on a Desktop or Laptop.</p>

<p>Please switch to a larger screen device.</p>

<p>Redirecting to dashboard in <span id="timer">10</span> seconds...</p>

<button onclick="window.location.href='dashboard.jsp'">
Go to Dashboard
</button>

</div>
<%
Integer userId = (Integer) session.getAttribute("id");
String name = (String) session.getAttribute("name");

if(userId == null || name == null){
    response.sendRedirect("login.jsp");
    return;
}
%>
	<%
	int quizId = (int) request.getAttribute("quizId");
	String quizName = (String) request.getAttribute("quizName");
	String category = (String) request.getAttribute("category");
	String difficulty= (String) request.getAttribute("difficulty");
	int quescount = (int) request.getAttribute("quescount");
	ArrayList<Questions> ques = (ArrayList<Questions>) request.getAttribute("questions");
	request.setAttribute("quizId", quizId);
	%>
	<div id="fullscreenOverlay" class="fullscreen-overlay">
		<div class="overlay-box">
			<h2>Test Instructions</h2>
			<ul>
				<li>This test must be taken in fullscreen mode.</li>
				<li>Do not switch tabs or exit fullscreen.</li>
				<li>Exiting fullscreen may auto-submit your test.</li>
			</ul>
			<button class="start-test-btn" onclick="startTest()">Start
				Test</button>
		</div>
	</div>
	<!-- Loading Overlay -->
	<div id="loadingOverlay">
		<div class="loader"></div>
		<p>Submitting your test...</p>
	</div>

	<div id="testContent">
		<header class="test-header">
		<div class="container">
			<div class="test-title-area">
				<h2><%=quizName%></h2>
				<p>
					Category:
					<%=category%>
					| Difficulty: <%=difficulty %>
				</p>
			</div>

			<div class="test-status-area">
				<div class="status-box">
					<i class="fas fa-list-ol"></i> Question: <span
						style="color: var(--primary-color);" id="count">5</span> /
					<%=quescount%>
				</div>
				<div class="status-box">
					<i class="fas fa-clock"></i> Time Remaining: <span class="timer"></span>
				</div>
				<button class="end-test-button" onclick="submitQuiz()">End
					Test</button>
			</div>
		</div>
	</header>

	<div class="container test-grid">

		<div class="question-column">
			<div class="question-area">
				<div id="question-number"></div>

				<div id="question-text">
					<!-- What is the time complexity for
					inserting an element into a hash table in the average case? -->
				</div>

				<!-- <pre class="question-code">
// Example Context (optional)
void insert(key, value) {
  // logic here...
}
                </pre> -->

				<div id="optionsBox">
					<!-- <label class="answer-option"> <input type="radio"
						name="answer_q5" value="A" class="answer-input"> <span
						class="answer-label">O(1)</span>
					</label> <label class="answer-option"> <input type="radio"
						name="answer_q5" value="B" class="answer-input"> <span
						class="answer-label">O(n)</span>
					</label> <label class="answer-option"> <input type="radio"
						name="answer_q5" value="C" class="answer-input"> <span
						class="answer-label">O(log n)</span>
					</label> <label class="answer-option"> <input type="radio"
						name="answer_q5" value="D" class="answer-input"> <span
						class="answer-label">O(n²)</span>
					</label> -->
				</div>

				<div class="test-footer">
					<a href="#" class="nav-button prev-button" onclick="previous()"><i
						class="fas fa-chevron-left"></i> Previous</a>

					<div>
						<a href="#" class="nav-button next-button" onclick="next()">Next
							<i class="fas fa-chevron-right"></i>
						</a>
					</div>
				</div>
			</div>
		</div>

		<div class="sidebar-column">
			<div class="sidebar-area">

				<div class="navigator-card">
					<h3>Question Navigator</h3>
					<div class="question-grid">
						<%
						for (int i = 1; i <= quescount; i++) {
						%>
						<a href="#" onclick="loadQuestion(<%=i - 1%>)" class="q-button"
							id="ques<%=i - 1%>"><%=i%></a>
						<%
						}
						%>
						<!-- <a href="#" class="q-button answered">1</a> <a href="#"
							class="q-button answered marked">2</a> <a href="#"
							class="q-button answered">3</a> <a href="#" class="q-button">4</a>
						<a href="#" class="q-button current">5</a> <a href="#"
							class="q-button">6</a> <a href="#" class="q-button">...</a> <a
							href="#" class="q-button">50</a> -->
					</div>
				</div>

				<div class="navigator-card">
					<h3>Legend</h3>
					<p style="font-size: 0.9em; margin-bottom: 5px;">
						<span style="color: var(--primary-color);">Blue/Bold:</span>
						Current Question
					</p>
					<p style="font-size: 0.9em; margin-bottom: 5px;">
						<span style="color: var(--success-color);">Green:</span> Answered
					</p>
					<!-- <p style="font-size: 0.9em; margin-bottom: 5px;">
						<span style="color: var(--accent-color);">Yellow Border:</span>
						Marked for Review
					</p> -->
					<p style="font-size: 0.9em; margin-bottom: 0;">
						<span style="color: var(--subtle-gray);">White:</span>
						Unanswered/Skipped
					</p>
				</div>

			</div>
		</div>
	</div>
		
	</div>
	
	<script>
	
    
let questions = [
<%for (Questions q : ques) {
	System.out.println(q.getOptionType());%>
{
    id: <%=q.getId()%>,
    type: "<%=q.getOptionType()%>",
    question: `<%=q.getQuestion()%>`,
    opt1: `<%=q.getOption1()%>`,
    opt2: `<%=q.getOption2()%>`,
    opt3: `<%=q.getOption3()%>`,
    opt4: `<%=q.getOption4()%>`
},
<%}%>
];
console.log(questions);
let userAnswers = {};  
let currentIndex = 0;
loadQuestion(currentIndex);
function loadQuestion(i) {
    let q = questions[i];
    document.getElementById("question-number").innerHTML = "Question "+(i+1)+" of "+(questions.length) ;
    document.getElementById("question-text").innerHTML = q.question;
    document.getElementById("count").innerHTML = i+1;
    document.getElementById("ques"+i).className = "q-button current";
	console.log("loadquestion");
	console.log(q.opt1);

    let html = "";
    if (q.type === "mcq")
        html = renderMCQ(q);
    else if (q.type === "multi-select")
        html = renderMultiSelect(q);
    else if (q.type === "true-false")
        html = renderTrueFalse(q);

    document.getElementById("optionsBox").innerHTML = html;

    // Prefill if user already answered
    restoreAnswer(q);
}

function renderMCQ(q) {
    return `
       <label class="answer-option"><input type="radio" name="ans" value="${q.opt1}" class="answer-input"><span class="answer-label"> ${q.opt1}</span></label><br>
       <label class="answer-option"><input type="radio" name="ans" value="${q.opt2}" class="answer-input"> <span class="answer-label"> ${q.opt2}</span></label><br>
       <label class="answer-option"><input type="radio" name="ans" value="${q.opt3}" class="answer-input"> <span class="answer-label"> ${q.opt3}</span></label><br>
       <label class="answer-option"><input type="radio" name="ans" value="${q.opt4}" class="answer-input"> <span class="answer-label"> ${q.opt4}</span></label><br>
    `;
}

function renderMultiSelect(q) {
    return `
       <label>Select Multiple Suitable Options</label><br>
       <label class="answer-option"><input type="checkbox" name="ans" value="${q.opt1}" class="answer-input"> <span class="answer-label"> ${q.opt1}</span></label><br>
       <label class="answer-option"><input type="checkbox" name="ans" value="${q.opt2}" class="answer-input"> <span class="answer-label"> ${q.opt2}</span></label><br>
       <label class="answer-option"><input type="checkbox" name="ans" value="${q.opt3}" class="answer-input"> <span class="answer-label"> ${q.opt3}</span></label><br>
       <label class="answer-option"><input type="checkbox" name="ans" value="${q.opt4}" class="answer-input"> <span class="answer-label"> ${q.opt4}</span></label><br>
    `;
}


function renderTrueFalse(q) {
    return `
       <label class="answer-option"><input type="radio" name="ans" value="${q.opt1}" class="answer-input"><span class="answer-label"> True</span></label><br>
       <label class="answer-option"><input type="radio" name="ans" value="${q.opt2}" class="answer-input"><span class="answer-label"> False</span></label><br>
    `;
}

function saveAnswer() {
    let q = questions[currentIndex];

    if (q.type === "mcq" || q.type === "true-false") {
        let selected = document.querySelector("input[name='ans']:checked");
        if (selected)
            userAnswers[q.id] = selected.value;
    }

    if (q.type === "multi-select") {
        let selectedOptions = [];
        document.querySelectorAll("input[name='ans']:checked").forEach(cb => {
            selectedOptions.push(cb.value);
        });
        userAnswers[q.id] = selectedOptions;   // store as array
    }
    document.getElementById("ques"+currentIndex).className = "q-button answered";
}

function restoreAnswer(q) {
    let saved = userAnswers[q.id];
    if (!saved) return;

    if (q.type === "mcq" || q.type === "true-false") {
        let elem = document.querySelector("input[name='ans'][value='" + saved + "']");
        if (elem) elem.checked = true;
    }

    if (q.type === "multi-select") {
        saved.forEach(val => {
            let elem = document.querySelector("input[name='ans'][value='" + val + "']");
            if (elem) elem.checked = true;
        });
    }
}

function next() {
    saveAnswer();

    currentIndex++;
    if (currentIndex >= questions.length) {
        submitQuiz();
        return;
    }
    loadQuestion(currentIndex);
}

function submitQuiz() {
	document.getElementById("loadingOverlay").style.display = "flex";
    document.getElementById("testContent").classList.add("blur");
    let form = document.createElement("form");
    form.method = "post";
    form.action = "SubmitQuiz";
    
    for (let qid in userAnswers) {
        let inp = document.createElement("input");
        inp.type = "hidden";
        inp.name = qid;

        // stringify arrays for multi-select
        inp.value = JSON.stringify(userAnswers[qid]);

        form.appendChild(inp);
    }
    let inp = document.createElement("input");
    inp.type = "hidden";
    inp.name = "quizId";
    inp.value = <%=quizId%>;
    form.appendChild(inp);
    inp = document.createElement("input");
    inp.type = "hidden";
    inp.name = "quizName";
    inp.value = "<%=quizName%>";
    form.appendChild(inp);
    document.body.appendChild(form);
    form.submit();
}

function previous() {
    // Stop if already at the first question
    if (currentIndex === 0) {
        alert("This is the first question");
        return;
    }

    // Save current answer before going back
    saveAnswer();

    // Move back
    currentIndex--;

    // Load the previous question
    loadQuestion(currentIndex);
}

let totalSeconds = <%=quescount%> * 60; // 25:30 → convert to seconds
let timerElement = document.querySelector(".timer");
let minutes = Math.floor(totalSeconds / 60);
let seconds = totalSeconds % 60;

// format
minutes = minutes < 10 ? "0" + minutes : minutes;
seconds = seconds < 10 ? "0" + seconds : seconds;

timerElement.textContent = `${minutes}:${seconds}`;
let timer = setInterval(() => {
    if (totalSeconds <= 0) {
        clearInterval(timer);
        timerElement.textContent = "00:00";
        submitQuiz();
    }

    totalSeconds--;

    let minutes = Math.floor(totalSeconds / 60);
    let seconds = totalSeconds % 60;

    // format
    minutes = minutes < 10 ? "0" + minutes : minutes;
    seconds = seconds < 10 ? "0" + seconds : seconds;

    timerElement.textContent = `${minutes}:${seconds}`;
}, 1000);


function enterFullScreen() {
    const elem = document.documentElement;

    if (elem.requestFullscreen) {
        elem.requestFullscreen();
    } else if (elem.webkitRequestFullscreen) {
        elem.webkitRequestFullscreen();
    } else if (elem.msRequestFullscreen) {
        elem.msRequestFullscreen();
    }
}

function startTest() {
    enterFullScreen();
    document.getElementById("fullscreenOverlay").style.display = "none";
}

document.addEventListener("fullscreenchange", () => {
    if (!document.fullscreenElement) {
        alert("You exited fullscreen. Test will be submitted.");
        submitQuiz();
    }
});
document.addEventListener("visibilitychange", function () {
    if (document.hidden) {
    	alert("You exited fullscreen. Test will be submitted.");
    	submitQuiz();
    }
});



</script>
<script>

	function checkDevice(){

		let width = window.innerWidth;

		let mobile = /Android|iPhone|iPad|iPod/i.test(navigator.userAgent);

		if(width <= 1024 || mobile){

		document.getElementById("deviceBlock").style.display="flex";

		startTimer();

		}

		}

let timeLeft = 10;

function startTimer(){

let timer=setInterval(function(){

document.getElementById("timer").innerHTML=timeLeft;

timeLeft--;

if(timeLeft < 0){

clearInterval(timer);

window.location.href="dashboard.jsp";

}

},1000);

}

window.onload = checkDevice;

</script>

</body>
</html>