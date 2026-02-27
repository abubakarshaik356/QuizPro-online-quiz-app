<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Forgot Password - QuizPro</title>
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

        .reset-container {
            width: 90%;
            max-width: 450px;
            background-color: var(--card-bg);
            padding: 40px;
            border-radius: 12px;
            box-shadow: 0 10px 25px var(--shadow-strong);
            text-align: center;
        }

        .reset-container h1 {
            color: var(--primary-color);
            font-size: 2em;
            margin-bottom: 10px;
            font-weight: 800;
        }

        .reset-container p {
            color: var(--subtle-gray);
            margin-bottom: 30px;
            line-height: 1.4;
        }

        /* Form Styling */
        .form-group {
            margin-bottom: 20px;
            text-align: left;
        }

        .form-group label {
            display: block;
            font-weight: 600;
            margin-bottom: 5px;
        }

        .form-group input[type="email"] {
            width: 100%;
            padding: 12px;
            border: 1px solid #CED4DA;
            border-radius: 6px;
            box-sizing: border-box;
            font-size: 1em;
        }

        /* Submit Button */
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
            margin-top: 10px;
        }
        .cta-button:hover {
            background-color: #005691;
        }
        
        .back-link {
            display: block;
            margin-top: 25px;
            font-size: 0.95em;
            color: var(--primary-color);
            text-decoration: none;
            font-weight: 600;
        }
        .back-link:hover {
            text-decoration: underline;
        }
        
        /* Message Area for Success/Error */
        #message-area {
            padding: 10px;
            border-radius: 6px;
            margin-bottom: 15px;
            display: none; /* Hidden by default */
            font-weight: 600;
        }
        .success {
            background-color: #d4edda;
            color: var(--success-color);
            border: 1px solid #c3e6cb;
        }
        .error {
            background-color: #f8d7da;
            color: var(--danger-color);
            border: 1px solid #f5c6cb;
        }

    </style>
</head>
<body>

    <div class="reset-container">
        <i class="fas fa-lock fa-3x" style="color: var(--primary-color); margin-bottom: 15px;"></i>
        <h1>Forgot Your Password?</h1>
        <p>Enter the email address associated with your account and we'll send you a link to reset your password.</p>
        
        <div id="message-area"></div>

        <form action="ForgotPassword" method="POST"> 
            
            <input type="hidden" name="action" value="request_reset">

            <div class="form-group">
                <label for="email"><i class="fas fa-envelope"></i> Email Address</label>
                <input type="email" id="email" name="email" placeholder="you@example.com" required>
            </div>
            
            <button type="submit" class="cta-button">
                Send Reset Link
            </button>
        </form>
        
        <a href="login.html" class="back-link">
            <i class="fas fa-arrow-left"></i> Back to Login
        </a>
    </div>
    
    <script>
        // Client-side script to handle success/error messages passed via URL parameters
        document.addEventListener('DOMContentLoaded', function() {
            const params = new URLSearchParams(window.location.search);
            const status = params.get('status');
            const message = params.get('message');
            const messageArea = document.getElementById('message-area');

            if (status && message) {
                const decodedMessage = decodeURIComponent(message);
                messageArea.textContent = decodedMessage;
                messageArea.style.display = 'block';

                if (status === 'success') {
                    messageArea.classList.add('success');
                } else if (status === 'error') {
                    messageArea.classList.add('error');
                }
                
                // Clean the URL (optional but recommended)
                if (history.replaceState) {
                    const cleanUrl = window.location.pathname;
                    history.replaceState(null, '', cleanUrl);
                }
            }
        });
    </script>

</body>
</html>