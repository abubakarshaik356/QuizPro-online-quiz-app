<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>About Us | QuizPro</title>
    
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;600;800&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
    
    <style>
        :root {
            --primary-color: #0077B6;
            --secondary-blue: #023E8A;
            --accent-color: #FFB700;
            --dark-bg: #F0F2F5;
            --light-text: #212529;
            --card-bg: #FFFFFF;
            --subtle-gray: #6C757D;
            --shadow-light: rgba(0, 0, 0, 0.08);
            --shadow-hover: rgba(0, 0, 0, 0.15);
        }

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
            padding: 0 20px;
        }

        /* --- Sticky Header Navigation --- */
        .header {
            background: var(--card-bg);
            border-bottom: 1px solid #dee2e6;
            padding: 15px 0;
            position: sticky;
            top: 0;
            z-index: 1000;
            box-shadow: 0 2px 10px var(--shadow-light);
        }

        .header .container {
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .logo {
            font-size: 1.8em;
            font-weight: 800;
            color: var(--primary-color);
            text-decoration: none;
        }

        .nav {
            display: flex;
            align-items: center;
        }

        .nav a {
            color: var(--light-text);
            text-decoration: none;
            margin-left: 30px;
            font-weight: 600;
            transition: color 0.3s;
        }

        .nav a:hover, .nav a.active {
            color: var(--primary-color);
        }

        /* --- Action Button (Consolidated Style) --- */
        .cta-btn {
            display: inline-block;
            background-color: var(--accent-color);
            color: #1A1A1A;
            padding: 12px 28px;
            border-radius: 8px;
            text-decoration: none;
            font-weight: 800;
            font-size: 1em;
            transition: all 0.2s ease;
            border: none;
            cursor: pointer;
        }

        .cta-btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(255, 183, 0, 0.4);
            opacity: 0.9;
        }

        /* --- Hero Section --- */
        .about-hero {
            background: linear-gradient(135deg, var(--primary-color) 0%, var(--secondary-blue) 100%);
            color: white;
            padding: 100px 0;
            text-align: center;
            border-bottom: 8px solid var(--accent-color);
        }

        .about-hero h1 {
            font-size: 3.5em;
            font-weight: 800;
            margin: 0;
            letter-spacing: -1px;
        }

        .about-hero p {
            font-size: 1.25em;
            opacity: 0.9;
            max-width: 750px;
            margin: 25px auto 0;
        }

        /* --- Overlapping Stats Bar --- */
        .stats-bar {
            background: var(--card-bg);
            padding: 40px 0;
            display: flex;
            justify-content: space-around;
            text-align: center;
            border-radius: 15px;
            box-shadow: 0 10px 30px var(--shadow-light);
            margin-top: -60px;
            position: relative;
            z-index: 10;
        }

        .stat-item h3 {
            font-size: 2.8em;
            color: var(--primary-color);
            margin: 0;
            font-weight: 800;
        }

        .stat-item p {
            color: var(--subtle-gray);
            font-weight: 600;
            text-transform: uppercase;
            letter-spacing: 1px;
            font-size: 0.9em;
            margin-top: 5px;
        }

        /* --- Grid Content Sections --- */
        .section {
            padding: 80px 0;
        }

        .grid-2 {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 60px;
            align-items: center;
        }

        .mission-text h2 {
            color: var(--primary-color);
            font-size: 2.5em;
            margin-bottom: 25px;
        }

        .mission-text p {
            font-size: 1.1em;
            margin-bottom: 20px;
            color: var(--subtle-gray);
        }

        /* --- Values Grid (Match Index Feature Look) --- */
        .values-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
            gap: 30px;
            margin-top: 50px;
        }

        .value-card {
            background: white;
            padding: 40px;
            border-radius: 15px;
            text-align: center;
            transition: all 0.3s ease;
            box-shadow: 0 4px 15px var(--shadow-light);
            border-bottom: 4px solid transparent;
        }

        .value-card:hover {
            transform: translateY(-10px);
            border-bottom: 4px solid var(--primary-color);
            box-shadow: 0 15px 35px var(--shadow-hover);
        }

        .value-card i {
            font-size: 3.5em;
            color: var(--accent-color);
            margin-bottom: 25px;
        }

        .value-card h4 {
            font-size: 1.5em;
            margin-bottom: 15px;
            color: var(--light-text);
        }

        /* --- Team Section --- */
        .team-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(220px, 1fr));
            gap: 40px;
            text-align: center;
            margin-top: 50px;
        }

        .team-member img {
            width: 160px;
            height: 160px;
            border-radius: 50%;
            object-fit: cover;
            border: 4px solid white;
            box-shadow: 0 8px 20px var(--shadow-light);
            margin-bottom: 20px;
            filter: grayscale(20%);
        }

        .team-member h4 { font-size: 1.3em; margin: 5px 0; }

        /* --- Final CTA Section --- */
        .final-cta {
            background-color: #F8F9FA;
            text-align: center;
            padding: 100px 20px;
            border-top: 1px solid #dee2e6;
        }

        /* --- Footer --- */
        .footer {
            background: #1A1A1A;
            color: #ADB5BD;
            padding: 50px 0;
            text-align: center;
        }

        .footer a {
            color: var(--accent-color);
            text-decoration: none;
            margin: 0 15px;
            transition: color 0.2s;
        }

        .footer a:hover { color: white; }

        @media (max-width: 768px) {
            .grid-2 { grid-template-columns: 1fr; text-align: center; }
            .about-hero h1 { font-size: 2.5em; }
            .stats-bar { flex-direction: column; gap: 30px; margin-top: 20px; }
            .nav { display: none; } /* Consider adding a mobile menu icon here */
        }
    </style>
</head>
<body>

    <header class="header">
        <div class="container">
            <a href="index.jsp" class="logo">Quiz<span style="color: var(--accent-color);">Pro</span></a>
            <nav class="nav">
                <a href="index.jsp#categories">Explore</a>
                <a href="about-us.jsp" class="active">About Us</a>
                <a href="login.jsp">Login</a>
                <a href="signup.jsp" class="cta-btn" style="margin-left: 25px;">Get Started</a>
            </nav>
        </div>
    </header>

    <section class="about-hero">
        <div class="container">
            <h1>Elevating the Way You Learn</h1>
            <p>QuizPro is a mission-driven platform focused on making mastery accessible to everyone through high-fidelity, real-time assessments.</p>
        </div>
    </section>

    <div class="container">
        <div class="stats-bar">
            <div class="stat-item">
                <h3>10k+</h3>
                <p>Global Learners</p>
            </div>
            <div class="stat-item">
                <h3>500+</h3>
                <p>Verified Quizzes</p>
            </div>
            <div class="stat-item">
                <h3>98%</h3>
                <p>Success Rate</p>
            </div>
        </div>
    </div>

    <section class="section">
        <div class="container grid-2">
            <div class="mission-image">
                <img src="https://images.unsplash.com/photo-1522202176988-66273c2fd55f?ixlib=rb-4.0.3&auto=format&fit=crop&w=800&q=80" alt="Learning Community" style="width:100%; border-radius:20px; box-shadow: 0 15px 35px rgba(0,0,0,0.1);">
            </div>
            <div class="mission-text">
                <h2>Our Mission</h2>
                <p>Founded with the belief that traditional learning is often too passive, QuizPro was designed to put <strong>Active Recall</strong> at the center of your study routine.</p>
                <p>We provide a curated ecosystem of quizzes across technical, academic, and professional subjects, allowing you to identify knowledge gaps instantly and turn them into strengths.</p>
            </div>
        </div>
    </section>

    <section class="section" style="background-color: #FFFFFF; border-top: 1px solid #eee; border-bottom: 1px solid #eee;">
        <div class="container">
            <h2 style="text-align: center; font-size: 2.5em; color: var(--primary-color);">What Drives Us</h2>
            <div class="values-grid">
                <div class="value-card">
                    <i class="fas fa-lightbulb"></i>
                    <h4>Smart Adaptation</h4>
                    <p>Our quizzes adapt to your skill level, ensuring you are always challenged but never overwhelmed.</p>
                </div>
                <div class="value-card">
                    <i class="fas fa-universal-access"></i>
                    <h4>Universal Access</h4>
                    <p>We believe high-quality educational tools should be available to learners everywhere, free of barriers.</p>
                </div>
                <div class="value-card">
                    <i class="fas fa-check-circle"></i>
                    <h4>Verified Accuracy</h4>
                    <p>Every single question on our platform is vetted by subject matter experts for 100% precision.</p>
                </div>
            </div>
        </div>
    </section>

    <section class="section">
        <div class="container">
            <h2 style="text-align: center; font-size: 2.5em; color: var(--primary-color); margin-bottom: 10px;">The Minds Behind QuizPro</h2>
            <p style="text-align: center; color: var(--subtle-gray); margin-bottom: 50px;">A dedicated team of educators and engineers.</p>
            <div class="team-grid">
                <div class="team-member">
                    <img src="assets/abubakar.png" alt="CEO">
                    <h4>Abubakar Siddiq</h4>
                    <p style="color: var(--primary-color); font-weight: 700;">Team Member</p>
                </div>
                <div class="team-member">
                    <img src="assets/chaitanya.jpeg" alt="CTO">
                    <h4>Chaithanya</h4>
                    <p style="color: var(--primary-color); font-weight: 700;">Team Member</p>
                </div>
                <div class="team-member">
                    <img src="assets/narendra.jpeg" alt="Designer">
                    <h4>Narendra Reddy</h4>
                    <p style="color: var(--primary-color); font-weight: 700;">Team Member</p>
                </div>
                <div class="team-member">
                    <img src="assets/kesava.jpeg" alt="Content">
                    <h4>Kesava</h4>
                    <p style="color: var(--primary-color); font-weight: 700;">Team Member</p>
                </div>
            </div>
        </div>
    </section>

    <section class="final-cta">
        <div class="container">
            <h2 style="font-size: 2.5em; margin-bottom: 15px;">Ready to Start Your Journey?</h2>
            <p style="color: var(--subtle-gray); margin-bottom: 35px; font-size: 1.2em;">Join over 10,000 learners today and unlock your full potential.</p>
            <a href="signup.jsp" class="cta-btn" style="padding: 18px 50px; font-size: 1.1em;">Create Your Free Account</a>
        </div>
    </section>

    <footer class="footer">
        <div class="container">
            <p>&copy; <%= java.time.Year.now().getValue() %> QuizPro. All Rights Reserved.</p>
            <div style="margin-top: 20px;">
                <a href="#">Privacy Policy</a> | 
                <a href="#">Support Center</a> | 
                <a href="#">Terms of Service</a>
            </div>
        </div>
    </footer>
</body>
</html>