<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>GreenWatt - Smart Solar Subsidy & Installation Tracker</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <!-- Use clean, modern fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;600;700&family=Poppins:wght@500;700&display=swap" rel="stylesheet">
    
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }

        body {
            font-family: 'Inter', sans-serif;
            color: #fff;
            background: #ffffff;
        }

        /* Hero Section */
        .hero {
            position: relative;
            min-height: 100vh;
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
            text-align: center;
            padding: 2rem;
            overflow: hidden;
        }

       .hero::before {
    content: "";
    position: absolute;
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
    background-image: url('images/solar.jpeg');
    background-position: center;
    background-size: cover;
    background-repeat: no-repeat;
    filter: brightness(0.65);
    z-index: -2;
}
       


        .hero::after {
            content: "";
            position: absolute;
            inset: 0;
            background: linear-gradient(135deg, rgba(34,197,94,0.8), rgba(59,130,246,0.7));
            z-index: -1;
        }

        .hero h1 {
            font-family: 'Poppins', sans-serif;
            font-size: 3.5rem;
            font-weight: 700;
            margin-bottom: 0.5rem;
        }

        .hero h2 {
            font-size: 1.5rem;
            font-weight: 500;
            margin-bottom: 1.5rem;
        }

        .hero p {
            max-width: 600px;
            font-size: 1.125rem;
            line-height: 1.6;
            margin-bottom: 2rem;
        }

        .hero-features {
            display: flex;
            gap: 2rem;
            flex-wrap: wrap;
            justify-content: center;
            font-size: 1rem;
        }

        .hero-features span {
            display: flex;
            align-items: center;
            gap: 0.5rem;
            font-weight: 500;
        }

        .hero-features svg {
            width: 20px;
            height: 20px;
            color: #fff;
        }

        /* Login Section */
        .login-section {
            background: #fff;
            color: #1a1a1a;
            padding: 4rem 1rem;
        }

        .section-header {
            text-align: center;
            margin-bottom: 2rem;
        }

        .section-title {
            font-size: 2rem;
            font-weight: 700;
            margin-bottom: 0.5rem;
        }

        .section-description {
            color: #555;
            font-size: 1rem;
        }

        .login-cards {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(260px, 1fr));
            gap: 1.5rem;
            max-width: 1000px;
            margin: 0 auto;
        }

        .login-card {
            background: #f9fafb;
            border-radius: 0.75rem;
            padding: 1.5rem;
            text-align: center;
            box-shadow: 0 4px 8px rgba(0,0,0,0.08);
            transition: transform 0.3s, box-shadow 0.3s;
        }

        .login-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 8px 20px rgba(0,0,0,0.12);
        }

        .card-title {
            font-family: 'Poppins', sans-serif;
            font-size: 1.25rem;
            font-weight: 600;
            margin-bottom: 0.5rem;
        }

        .card-description {
            font-size: 0.9rem;
            color: #444;
            margin-bottom: 1rem;
        }

        .login-button {
            padding: 0.75rem 1.25rem;
            border: none;
            border-radius: 0.5rem;
            font-weight: 600;
            color: #fff;
            background: linear-gradient(135deg, #22c55e, #3b82f6);
            cursor: pointer;
            transition: transform 0.2s, box-shadow 0.2s;
        }

        .login-button:hover {
            box-shadow: 0 0 20px rgba(34,197,94,0.5);
            transform: translateY(-2px);
        }

        /* Footer */
        .footer {
            background: #1a1a1a;
            color: #ddd;
            text-align: center;
            padding: 1rem;
            font-size: 0.9rem;
        }

        /* Responsive */
        @media (max-width: 768px) {
            .hero h1 { font-size: 2.5rem; }
            .hero h2 { font-size: 1.25rem; }
        }
    </style>
</head>
<body>
    <section class="hero">
        <h1>GreenWatt</h1>
        <h2>Smart Solar Subsidy & Installation Tracker</h2>
        <p>Streamline your solar journey with intelligent tracking, subsidy management, 
           and seamless coordination between residents, installers, and administrators.</p>
        <div class="hero-features">
            <span>☀️ Solar Tracking</span>
            <span>💰 Subsidy Management</span>
            <span>⚡ Smart Installation</span>
        </div>
    </section>

    <section class="login-section">
        <div class="section-header">
            <h2 class="section-title">Choose Your Portal</h2>
            <p class="section-description">Access your dashboard based on your role in the solar ecosystem</p>
        </div>
        <div class="login-cards">
            <div class="login-card">
                <h3 class="card-title">Admin</h3>
                <p class="card-description">Manage subsidies, installations, and oversee the entire platform</p>
                <button class="login-button" onclick="location.href='login/admin-login.jsp'">Login as Admin</button>
            </div>
            <div class="login-card">
                <h3 class="card-title">Resident</h3>
                <p class="card-description">Track your solar installation progress and subsidy applications</p>
                <button class="login-button" onclick="location.href='login/resident-login.jsp'">Login as Resident</button>
            </div>
            <div class="login-card">
                <h3 class="card-title">Installer</h3>
                <p class="card-description">Manage installations, view assignments, and update project status</p>
                <button class="login-button" onclick="location.href='login/installer-login.jsp'">Login as Installer</button>
            </div>
        </div>
    </section>

    <footer class="footer">
        © 2025 GreenWatt. Powering sustainable energy adoption.
    </footer>
</body>
</html>
