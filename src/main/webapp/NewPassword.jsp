<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Password Reset & OTP Validation - QuizPro</title>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
    
    <style>
        :root {
            --primary-color: #0077B6; 
            --dark-bg: #F0F2F5; 
            --light-text: #212529; 
            --card-bg: #FFFFFF; 
            --danger-color: #dc3545;
            --success-color: #28a745;
            --shadow-strong: rgba(0, 0, 0, 0.15);
        }
        body { font-family: 'Inter', sans-serif; margin: 0; padding: 0; background-color: var(--dark-bg); color: var(--light-text); display: flex; justify-content: center; align-items: center; min-height: 100vh; }
        .reset-container { width: 90%; max-width: 450px; background-color: var(--card-bg); padding: 40px; border-radius: 12px; box-shadow: 0 10px 25px var(--shadow-strong); text-align: center; }
        .reset-container h1 { color: var(--primary-color); font-size: 2em; margin-bottom: 10px; font-weight: 800; }
        .reset-container p { color: var(--subtle-gray); margin-bottom: 30px; line-height: 1.4; }
        .form-group { margin-bottom: 20px; text-align: left; }
        .form-group label { display: block; font-weight: 600; margin-bottom: 5px; }
        .form-group input { width: 100%; padding: 12px; border: 1px solid #CED4DA; border-radius: 6px; box-sizing: border-box; font-size: 1em; }
        #otpCode { font-size: 1.5em; text-align: center; letter-spacing: 0.5em; } /* Special style for OTP input */
        .cta-button { background-color: var(--primary-color); color: white; padding: 15px 30px; border: none; border-radius: 8px; font-weight: 700; font-size: 1.1em; cursor: pointer; transition: background-color 0.2s; width: 100%; margin-top: 10px; }
        .cta-button:hover { background-color: #005691; }
        #message-area { padding: 10px; border-radius: 6px; margin-bottom: 15px; display: none; font-weight: 600; text-align: center; }
        .success { background-color: #d4edda; color: var(--success-color); border: 1px solid #c3e6cb; }
        .error { background-color: #f8d7da; color: var(--danger-color); border: 1px solid #f5c6cb; }
    </style>
</head>
<body>
	<%
		String email=(String)session.getAttribute("email");
		int otp=(int)session.getAttribute("otp");
	%>
    <div class="reset-container">
        <i class="fas fa-lock fa-3x" style="color: var(--primary-color); margin-bottom: 15px;"></i>
        <h1>Password Reset</h1>
        <p id="instruction-text">A code has been sent to your email. Please enter it to continue.</p>
        
        <div id="message-area"></div>

        <form action="PasswordResetServlet" method="POST" id="resetForm"> 
            
            <input type="hidden" name="email" id="emailInput" value="">
            
            <input type="hidden" name="action" id="actionInput" value="validate_otp">

            <div id="otp-step">
                <div class="form-group">
                    <label for="otpCode"><i class="fas fa-key"></i> Verification Code</label>
                    <input type="text" id="otpCode" name="otpCode" maxlength="6" pattern="\d{6}" title="6 digit code" required>
                </div>
                
                <button type="submit" class="cta-button" id="otpSubmitBtn">
                    Verify Code
                </button>
                
                <a href="#" id="resendLink" style="display: block; margin-top: 15px; font-size: 0.9em;">
                    Didn't receive the code? Resend Now
                </a>
            </div>

            <div id="password-step" style="display: none;">
                <div class="form-group">
                    <label for="newPassword"><i class="fas fa-lock"></i> New Password</label>
                    <input type="password" id="newPassword" name="newPassword" required disabled>
                </div>
                
                <div class="form-group">
                    <label for="confirmPassword"><i class="fas fa-lock-open"></i> Confirm New Password</label>
                    <input type="password" id="confirmPassword" name="confirmPassword" required disabled>
                </div>
                
                <button type="submit" class="cta-button">
                    <i class="fas fa-check"></i> Set New Password
                </button>
            </div>
        </form>
    </div>
    
    <script>
        const form = document.getElementById('resetForm');
        const otpStep = document.getElementById('otp-step');
        const passwordStep = document.getElementById('password-step');
        const actionInput = document.getElementById('actionInput');
        const emailInput = document.getElementById('emailInput');
        const messageArea = document.getElementById('message-area');
        const instructionText = document.getElementById('instruction-text');
        const resendLink = document.getElementById('resendLink');
        
        // Function to display messages
        function displayMessage(status, msg) {
            messageArea.textContent = msg;
            messageArea.classList.remove('success', 'error');
            messageArea.classList.add(status === 'success' ? 'success' : 'error');
            messageArea.style.display = 'block';
        }

        // --- Handle Initial Load (Coming from forgot-password.html) ---
        document.addEventListener('DOMContentLoaded', function() {
            const params = new URLSearchParams(window.location.search);
            const email = "<%=email%>";
            const status = params.get('status');
            const message = params.get('message');

            if (!email) {
                displayMessage('error', 'Error: Missing email context. Please start the password reset process again.');
                form.style.display = 'none';
                return;
            }

            emailInput.value = "<%=email%>";
            resendLink.href = `ForgotPassword?email=${email}`;
            
            if (status && message) {
                 displayMessage(status, decodeURIComponent(message));
            }
            
            /* // Clean the URL for a cleaner look
            if (history.replaceState) {
                const cleanUrl = window.location.pathname + `?email=${email}`;
                history.replaceState(null, '', cleanUrl);
            } */
        });

        // --- Handle Form Submission (OTP Validation OR Password Setting) ---
        form.addEventListener('submit', function(e) {
            e.preventDefault();
            messageArea.style.display = 'none';

            // Check if we are validating OTP
            if (actionInput.value === 'validate_otp') {
                const otpCode = document.getElementById('otpCode').value;
                
                // Simulate sending OTP to Servlet via AJAX
                // In a real application, you would use fetch() or XMLHttpRequest
                // to send the OTP without reloading the page.

                // --- START SERVER SIMULATION ---
                let otpMatches = (otpCode == <%=otp%>); // Assume 123456 is the correct OTP
                // --- END SERVER SIMULATION ---

                if (otpMatches) {
                    // Success: Move to the next step
                    displayMessage('success', 'Code verified! Please set your new password.');
                    
                    // 1. Hide OTP step and show Password step
                    otpStep.style.display = 'none';
                    passwordStep.style.display = 'block';
                    document.getElementById('newPassword').disabled = false;
                    document.getElementById('confirmPassword').disabled = false;
                    // 2. Update the hidden action field for the next submission
                    actionInput.value = 'set_password';
                    
                    // 3. Update instruction text
                    instructionText.textContent = "Your code is verified. Enter and confirm your new password below.";

                } else {
                    // Failure: Stay on the current step and show error
                    displayMessage('error', 'Invalid code entered. Please try again or resend the code.');
                }
            } 
            
            // Check if we are setting the new password
            else if (actionInput.value === 'set_password') {
                const newPass = document.getElementById('newPassword').value;
                const confirmPass = document.getElementById('confirmPassword').value;
                
                if (newPass !== confirmPass) {
                    displayMessage('error', 'Error: Passwords do not match.');
                    return;
                }
                
                // In a real application, you would now submit the form 
                // to the Servlet (action=set_password) to update the database.
                
                // --- FINAL SERVER SIMULATION (Submitting the Password) ---
                console.log("Submitting new password for:", emailInput.value);
                console.log("New Password: ",newPass)
                // After successful server update:
                // Redirect to the login page with success status
                window.location.href = `NewPassword?email=<%=email%>&newPassword=${newPass}`;
                // --- END FINAL SERVER SIMULATION ---
            }
        });
    </script>
</body>
</html>