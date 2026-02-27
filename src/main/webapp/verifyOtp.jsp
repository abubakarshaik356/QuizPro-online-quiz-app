<%@ page import="jakarta.servlet.http.HttpSession"%>
<%
    String msg = request.getParameter("msg");
    String type = request.getParameter("type");
    String redirect = request.getParameter("redirect");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Verify OTP</title>
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    <style>
        :root {
            --primary-color: #0077B6;
            --accent-color: #FFB700;
            --dark-bg: #F0F2F5;
            --card-bg: #FFFFFF;
            --subtle-gray: #6C757D;
            --shadow-light: rgba(0,0,0,0.08);
        }

        body {
            font-family: 'Inter', sans-serif;
            background-color: var(--dark-bg);
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }

        .otp-container {
            background: var(--card-bg);
            padding: 30px 40px;
            border-radius: 12px;
            box-shadow: 0 4px 20px var(--shadow-light);
            text-align: center;
            width: 380px;
        }

        h2 { color: var(--primary-color); margin-bottom: 10px; font-weight: 800; }

        .otp-inputs { display: flex; justify-content: space-between; margin: 25px 0; }

        .otp-box {
            width: 45px;
            height: 50px;
            font-size: 1.5em;
            text-align: center;
            border: 2px solid var(--primary-color);
            border-radius: 8px;
            outline: none;
            transition: 0.2s;
        }

        .otp-box:focus {
            border-color: var(--accent-color);
            box-shadow: 0 0 5px var(--accent-color);
        }

        .verify-btn {
            width: 100%;
            background: var(--primary-color);
            color: white;
            border: none;
            padding: 12px;
            border-radius: 8px;
            font-size: 1.1em;
            font-weight: 700;
            cursor: pointer;
            transition: 0.2s;
        }

        .verify-btn:hover { opacity: 0.85; }

        .timer { margin-top: 10px; font-weight: 600; color: var(--subtle-gray); }

        .resend-btn {
            margin-top: 10px;
            color: var(--primary-color);
            text-decoration: none;
            font-weight: 600;
            display: inline-block;
        }

        .resend-btn.disabled { pointer-events: none; opacity: 0.5; }
    </style>
</head>
<body>

<div class="otp-container">
    <h2>Verify OTP</h2>
    <p>Enter the 6-digit OTP sent to your email</p>

    <form action="verifyOtp" method="post" id="otpForm">
        <div class="otp-inputs">
            <input type="text" maxlength="1" class="otp-box" name="d1">
            <input type="text" maxlength="1" class="otp-box" name="d2">
            <input type="text" maxlength="1" class="otp-box" name="d3">
            <input type="text" maxlength="1" class="otp-box" name="d4">
            <input type="text" maxlength="1" class="otp-box" name="d5">
            <input type="text" maxlength="1" class="otp-box" name="d6">
        </div>
        <input type="hidden" name="otp" id="finalOtp">
        <button class="verify-btn" type="submit">Verify OTP</button>
    </form>

    <div class="timer">OTP expires in <span id="countdown">02:00</span></div>
    <a href="resendOtp" id="resendBtn" class="resend-btn disabled">Resend OTP</a>
</div>

<script>
    <% if (msg != null && !msg.isEmpty()) { %>
        Swal.fire({
            icon: "<%= type != null ?  type :"info" %>",
            text: "<%= msg %>",
            confirmButtonColor: "#0077B6"
        }).then(() => {
            <% if (redirect != null && !redirect.isEmpty()) { %>
                window.location.href = "<%= redirect %>";
            <% } %>
        });
    <% } %>

    let boxes = document.querySelectorAll(".otp-box");
    boxes.forEach((box,index)=>{
        box.addEventListener("keyup", e => {
            if(box.value.length === 1 && index < boxes.length-1) boxes[index+1].focus();
            if(e.key === "Backspace" && index > 0) boxes[index-1].focus();
        });
    });

    document.getElementById("otpForm").addEventListener("submit", function(e){
        let finalOtp = "";
        boxes.forEach(b => finalOtp += b.value);
        if(finalOtp.length !== 6) {
            e.preventDefault();
            Swal.fire({icon: "error", text:"Please enter all 6 digits", confirmButtonColor:"#0077B6"});
            return;
        }
        document.getElementById("finalOtp").value = finalOtp;
    });

    let timeLeft = 120;
    let countdownEl = document.getElementById("countdown");
    let resendBtn = document.getElementById("resendBtn");

    let timer = setInterval(()=>{
        let min = Math.floor(timeLeft/60);
        let sec = timeLeft%60;
        countdownEl.innerHTML = (min<10?'0'+min:min)+":"+(sec<10?'0'+sec:sec);
        if(timeLeft<=0){
            clearInterval(timer);
            countdownEl.innerHTML = "Expired";
            resendBtn.classList.remove("disabled");
        }
        timeLeft--;
    },1000);
</script>

</body>
</html>
