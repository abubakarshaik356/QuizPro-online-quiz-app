<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>QuizPro - Secure Login</title>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;600;800&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    
    <style>
        :root {
            /* Professional Color Palette (Deep Teal & Subtle Gold) */
            --primary-color: #0077B6; /* Deep Blue/Teal for Trust */
            --accent-color: #FFB700; /* Refined Gold/Orange for CTA */
            --dark-bg: #F8F9FA; /* Light Background for clean look */
            --light-text: #212529; /* Dark Text */
            --card-bg: #FFFFFF; /* White Cards */
            --subtle-gray: #6C757D; /* Subtler text/dividers */
            --shadow-light: rgba(0, 0, 0, 0.1); /* Soft Shadow for forms */
        }

        /* Basic Setup */
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

        /* --- Form Container --- */
        .auth-wrapper {
            width: 90%;
            max-width: 420px;
            background: var(--card-bg);
            padding: 40px;
            border-radius: 12px;
            box-shadow: 0 10px 30px var(--shadow-light);
            text-align: center;
        }

        .logo {
            font-size: 2.2em;
            font-weight: 800;
            color: var(--primary-color);
            margin-bottom: 30px;
            display: block;
            text-decoration: none;
        }
        .logo span {
            color: var(--accent-color);
        }

        h2 {
            font-size: 1.8em;
            font-weight: 800;
            margin-bottom: 30px;
            color: var(--light-text);
        }

        /* --- Form Styling --- */
        .form-group {
            margin-bottom: 20px;
            text-align: left;
        }

        .input-icon {
            position: relative;
        }

        .input-icon input {
            width: 100%;
            padding: 15px 15px 15px 45px; /* Padding for icon */
            border: 1px solid #CED4DA;
            border-radius: 6px;
            font-size: 1em;
            box-sizing: border-box;
            transition: border-color 0.3s;
        }

        .input-icon i {
            position: absolute;
            left: 15px;
            top: 50%;
            transform: translateY(-50%);
            color: var(--subtle-gray);
            font-size: 1.1em;
        }

        .input-icon input:focus {
            border-color: var(--primary-color);
            outline: none;
            box-shadow: 0 0 0 3px rgba(0, 119, 182, 0.2);
        }

        .cta-button {
            width: 100%;
            display: block;
            background-color: var(--primary-color);
            color: var(--card-bg);
            padding: 15px;
            border-radius: 6px;
            font-weight: 700;
            font-size: 1.1em;
            border: none;
            cursor: pointer;
            transition: background-color 0.2s;
            margin-bottom: 20px;
        }

        .cta-button:hover {
            background-color: #005691;
        }
        
        .forgot-password, .alt-link {
            display: block;
            text-align: right;
            margin-top: -10px;
            margin-bottom: 20px;
            font-size: 0.9em;
            color: var(--subtle-gray);
            text-decoration: none;
        }
        .forgot-password:hover, .alt-link a:hover {
            color: var(--primary-color);
        }
        .alt-link {
            text-align: center;
        }
        .alt-link a {
            color: var(--primary-color);
            font-weight: 600;
            text-decoration: none;
        }


        /* --- Social Login --- */
        .social-login {
            margin-top: 25px;
            padding-top: 25px;
            border-top: 1px solid #E9ECEF;
        }

        .social-button {
            display: flex;
            align-items: center;
            justify-content: center;
            width: 100%;
            padding: 12px;
            margin-bottom: 10px;
            border-radius: 6px;
            text-decoration: none;
            font-weight: 600;
            font-size: 1em;
            transition: opacity 0.2s;
        }

        .social-button:hover {
            opacity: 0.9;
        }

        .social-button i {
            margin-right: 10px;
            font-size: 1.2em;
        }

        .google-btn {
            background-color: #DB4437;
            color: var(--card-bg);
        }

        .linkedin-btn {
            background-color: #0077B5;
            color: var(--card-bg);
        }
        #msg{
        	color:red;
        }
    </style>
</head>
<body>
	<% 
    	String msg=(String)request.getAttribute("msg");
    	if(msg!=null){
    		msg="<h6 id='msg'>"+msg+"</h6>";
    	}
    	else{
    		msg="";
    	}
    %>
    
    <div class="auth-wrapper">
        <a href="/" class="logo">Quiz<span>Pro</span></a>
        
        <h2>Login to Your Account</h2>
		<%=msg%>
        <form id="login-form" action="login" method="POST">
            
            <div class="form-group">
                <div class="input-icon">
                    <i class="fas fa-envelope"></i>
                    <input type="email" placeholder="Email Address" name="email" required>
                </div>
            </div>
            
            <div class="form-group">
                <div class="input-icon">
                    <i class="fas fa-lock"></i>
                    <input type="password" placeholder="Password" name="password" required>
                </div>
            </div>

            <a href="ForgotPassword.jsp" class="forgot-password">Forgot Password?</a>

            <button type="submit" class="cta-button">Secure Login</button>
        </form>

        <p class="alt-link">
            Need an account? <a href="signup.jsp">Sign Up Now</a>
        </p>

        <!-- <div class="social-login">
            <p style="color: var(--subtle-gray); margin-bottom: 15px;">Or log in with</p>
            <a href="/auth/google" class="social-button google-btn">
                <i class="fab fa-google"></i> Sign In with Google
            </a>
            <a href="/auth/linkedin" class="social-button linkedin-btn">
                <i class="fab fa-linkedin"></i> Sign In with LinkedIn
            </a>
        </div> -->

    </div>

</body>
</html>