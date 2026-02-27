<%@page import="java.time.LocalDate"%>
<%@page import="com.quizpro.dto.Quizzes"%>
<%@page import="com.quizpro.dto.User"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
LocalDate currentDate = LocalDate.now();
    User user = (User) request.getAttribute("User");
    Quizzes quiz = (Quizzes) request.getAttribute("Quiz");
    String date = request.getAttribute("Date") != null
            ? (String) request.getAttribute("Date")
            : currentDate.toString();

    
    String resId = (String) request.getAttribute("resId");
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8" />
<title>Certificate of Mastery</title>
<link href="https://fonts.googleapis.com/css2?family=Great+Vibes&family=Montserrat:wght@300;400;600;700&display=swap" rel="stylesheet">

<style>

/* ================= PAGE ================= */
@page {
    size: A4 landscape;
    margin: 0;
}

html, body {
    margin: 0;
    padding: 0;
    font-family: 'Montserrat', sans-serif;

}

/* ================= SCREEN PREVIEW ================= */
@media screen {
    body {
        background: #d0d0d0;
        display: flex;
        flex-direction: column;
        justify-content: center;
        align-items: center;
        min-height: 100vh;
    }

    .certificate-container {
        max-width: 900px;
    }
}

/* ================= CERTIFICATE ================= */
.certificate-container {
    width: 297mm;
    height: 178mm;
    background: #f7f4e4;
    border: 12px solid #c8a853;
    padding: 20mm 25mm;
    box-sizing: border-box;
    text-align: center;
}

/* ================= LOGO ================= */
.logo {
    font-size: 46px;
    font-weight: bold;
    margin-bottom: 10mm;
}

.logo-quiz { color: #2b6b7f; }
.logo-pro  { color: #d4a429; }

/* ================= TITLE ================= */
.certificate-title {
    font-family: 'Great Vibes', cursive;
    font-size: 54px;
    margin-bottom: 6mm;
}

/* ================= BODY ================= */
.certifies-text {
    font-size: 17px;
    margin-bottom: 5mm;
}

.recipient-banner {
    font-size: 40px;
    font-weight: bold;
    margin: 6mm 0 3mm;
}

.completion-text {
    font-size: 16px;
    margin-bottom: 5mm;
}

.course-name {
    width: 75%;
    margin: 0 auto 18mm;
    font-size: 28px;
    font-weight: bold;
    letter-spacing: 2px;
    line-height: 1.25;
}

/* ================= FOOTER ================= */
.certificate-footer {
    display: table;
    width: 100%;
    table-layout: fixed;
    margin-top: -6mm;
}

.footer-cell {
    display: table-cell;
    vertical-align: middle;
}

.footer-left {
    width: 25%;
    text-align: left;
}

.footer-center {
    width: 50%;
    text-align: left;
    font-size: 14px;
}

.footer-right {
    width: 35%;
    text-align: right;
}

/* ================= SEAL ================= */
.gold-seal {
    width: 105px;
    height: 105px;
    border-radius: 50%;
    background: #d4a429;
    border: 4px solid #c8a853;
    text-align: center;
}

.seal-text {
    color: white;
    font-size: 13px;
    font-weight: bold;
    padding-top: 32px;
}

/* ================= SIGNATURE ================= */
.signature {
    font-family: 'Great Vibes', cursive;
    font-size: 36px;
    color: #2b6b7f;
}

.signature-title {
    font-size: 14px;
}

/* ================= BUTTON ================= */
.btn-center {
    text-align: center;
    margin: 10px 0;
}

.btn-center a {
	text-decoration: none;
}

.download-btn {
    background: #d4af37;
    color: #2b1b00;
    padding: 14px 32px;
    font-size: 15px;
    font-weight: 600;
    border: none;
    border-radius: 40px;
    cursor: pointer;
    margin: 20px;
}

/* ================= PRINT ================= */
@media print {

    html, body {
        width: 297mm;
        height: 210mm;
        margin: 0;
        padding: 0;
        background: #ffffff;
    }

    body * {
        visibility: hidden;
    }

    #elite-certificate,
    #elite-certificate * {
        visibility: visible;
    }

    #elite-certificate {
        position: absolute;
        left: 0;
        top: 0;
        margin: 0;
        box-shadow: none;
    }

    .btn-center {
        display: none !important;
    }
}

</style>
</head>

<body>

<div class="certificate-container" id="elite-certificate">

    <div class="logo">
        <span class="logo-quiz">Quiz</span><span class="logo-pro">Pro</span>
    </div>

    <div class="certificate-title">Certificate of Mastery</div>

    <div class="certifies-text">This certifies that</div>

    <div class="recipient-banner"><%= user.getName() %></div>

    <div class="completion-text">
        has successfully completed and mastered the specialized learning path in
    </div>

    <div class="course-name"><%= quiz.getTitle() %></div>

    <div class="certificate-footer">

        <div class="footer-cell footer-left">
            <div class="gold-seal">
                <div class="seal-text">QuizPro<br/>Certified</div>
            </div>
        </div>

        <div class="footer-cell footer-center">
            <p><strong>Awarded on:</strong> <%= date %></p>
            <p><strong>Unique Verification ID:</strong> <%= resId %></p>
        </div>

        <div class="footer-cell footer-right">
            <div class="signature">Sandesh</div>
            <div class="signature-title">CEO, QuizPro</div>
        </div>

    </div>
</div>

<div class="btn-center">
    <button onclick="window.print()" class="download-btn">
        Download Certificate
    </button>
    <a href="SendCertificateEmail?title=<%= quiz.getTitle() %>&date=<%= date %>&id=<%=resId %>" class="download-btn">Send to Email</a>
</div>

</body>
</html>
