<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Resident Register - GreenWatt</title>
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }

        :root {
            --primary: #059669;
            --foreground: #1a1a1a;
            --background: #ffffff;
            --border: #d1d5db;
            --gradient-card: linear-gradient(145deg, #ffffff, #f9fafb);
            --gradient-solar: linear-gradient(135deg, #22c55e, #0ea5e9);
            --shadow-card: 0 4px 10px rgba(0,0,0,0.08);
        }

        body {
            font-family: 'Inter', sans-serif;
            background: linear-gradient(135deg, rgba(5, 150, 105, 0.05), rgba(16, 185, 129, 0.03));
            color: var(--foreground);
        }

        .register-container {
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            position: relative;
            overflow: hidden;
            padding: 2rem 1rem;
        }

        .register-card {
            background: var(--gradient-card);
            border: 2px solid rgba(34, 197, 94, 0.1);
            border-radius: 1.5rem;
            padding: 2.5rem;
            box-shadow: var(--shadow-card);
            animation: fadeInUp 0.6s ease-out forwards;
            max-width: 450px;
            width: 100%;
            position: relative;
            z-index: 10;
        }

        .register-card.register {
            border: 2px solid #059669;
            background: linear-gradient(135deg, rgba(5, 150, 105, 0.1), rgba(16, 185, 129, 0.05));
        }

        .register-header {
            text-align: center;
            margin-bottom: 2rem;
            background: linear-gradient(135deg, #059669, #10b981);
            color: white;
            padding: 2rem 1rem;
            margin: -2.5rem -2.5rem 2rem -2.5rem;
            border-radius: 1.5rem 1.5rem 0 0;
        }

        .logo-section {
            display: flex;
            flex-direction: column;
            align-items: center;
            gap: 1rem;
            margin-bottom: 1rem;
        }

        .logo-section h1 { font-size: 1.75rem; font-weight: 700; }

        .logo-icon {
            width: 4rem; height: 4rem;
            border-radius: 50%;
            display: flex; align-items: center; justify-content: center;
            font-size: 1.5rem;
            background: linear-gradient(135deg, #34d399, #6ee7b7);
            box-shadow: 0 0 20px rgba(52, 211, 153, 0.3);
            color: white;
        }

        .register-header h3 { font-size: 1.25rem; font-weight: 600; margin-bottom: 0.5rem; }
        .register-subtitle { font-size: 0.95rem; opacity: 0.9; }

        .register-form { display: flex; flex-direction: column; gap: 1.25rem; }

        .form-group { display: flex; flex-direction: column; gap: 0.5rem; }
        .form-group label { font-size: 0.875rem; font-weight: 600; }
        .form-group input {
            padding: 0.875rem 1rem;
            border: 2px solid var(--border);
            border-radius: 0.75rem;
            font-size: 1rem;
            background: var(--background);
            transition: all 0.3s ease;
        }
        .form-group input:focus {
            outline: none;
            border-color: var(--primary);
            box-shadow: 0 0 0 3px rgba(34, 197, 94, 0.1);
        }

        .register-btn {
            position: relative;
            padding: 1rem 2rem;
            background: linear-gradient(135deg, #059669, #10b981);
            color: white;
            border: none;
            border-radius: 0.75rem;
            font-size: 1rem;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
            overflow: hidden;
        }
        .register-btn:hover {
            background: linear-gradient(135deg, #047857, #059669);
            transform: translateY(-2px);
            box-shadow: 0 10px 30px rgba(5, 150, 105, 0.3);
        }

        .btn-glow {
            position: absolute; inset: 0;
            background: radial-gradient(circle, rgba(52, 211, 153, 0.3) 0%, transparent 70%);
            opacity: 0; transition: opacity 0.3s ease;
        }
        .register-btn:hover .btn-glow { opacity: 1; }

        .login-section {
            margin-top: 2rem; padding-top: 1.5rem;
            border-top: 1px solid rgba(5, 150, 105, 0.2);
            text-align: center;
        }
        .login-section a {
            display: inline-block;
            margin-top: 0.75rem;
            color: #059669;
            font-weight: 600;
            text-decoration: none;
        }
        .login-section a:hover { text-decoration: underline; }

        .register-background { position: absolute; inset: 0; z-index: 1; }
        .bg-pattern {
            position: absolute; inset: 0;
            background-image: radial-gradient(circle at 25% 25%, rgba(5, 150, 105, 0.1) 0%, transparent 50%),
                              radial-gradient(circle at 75% 75%, rgba(16, 185, 129, 0.1) 0%, transparent 50%);
            background-size: 400px 400px;
            animation: float 8s ease-in-out infinite;
        }
        .floating-elements { position: absolute; inset: 0; pointer-events: none; }
        .float-icon { position: absolute; font-size: 2rem; opacity: 0.6; animation: float 6s ease-in-out infinite; }
        .float-icon.solar { top: 20%; left: 15%; }
        .float-icon.house { top: 15%; right: 10%; font-size: 3rem; animation-delay: 0.5s; }
        .float-icon.leaf { bottom: 20%; left: 20%; animation-delay: 1s; }

        @keyframes float { 0%,100%{transform:translateY(0);} 50%{transform:translateY(-20px);} }

        @media (max-width:768px){
            .register-card{ padding:2rem 1.5rem; margin:1rem;}
            .register-header{ margin:-2rem -1.5rem 2rem -1.5rem; padding:1.5rem 1rem;}
        }
    </style>
</head>
<body>
    <div class="register-container">
        <div class="register-card register">
            <div class="register-header">
                <div class="logo-section">
                    <div class="logo-icon">🌱</div>
                    <h1>GreenWatt</h1>
                </div>
                <h3>Create Resident Account</h3>
                <p class="register-subtitle">Join GreenWatt and track your solar installation</p>
            </div>

            <form method="post" action="../ResidentRegister" class="register-form">
                <div class="form-group">
                    <label for="name">Full Name</label>
                    <input name="name" id="name" placeholder="Full name" required>
                </div>
                <div class="form-group">
                    <label for="address">Address</label>
                    <input name="address" id="address" placeholder="Address" required>
                </div>
                <div class="form-group">
                    <label for="email">Email</label>
                    <input name="email" id="email" placeholder="Email" required>
                </div>
                <div class="form-group">
                    <label for="aadhaar">Aadhaar</label>
                    <input name="aadhaar" id="aadhaar" placeholder="Aadhaar" required>
                </div>
                <div class="form-group">
                    <label for="password">Password</label>
                    <input name="password" id="password" type="password" placeholder="Password" required>
                </div>
                <button type="submit" class="register-btn">
                    <span>Register</span>
                    <div class="btn-glow"></div>
                </button>
            </form>

            <div class="login-section">
                <p>Already have an account?</p>
                <a href="../login/resident-login.jsp">Sign in →</a>
            </div>
        </div>

        <div class="register-background">
            <div class="bg-pattern"></div>
            <div class="floating-elements">
                <div class="float-icon solar">☀️</div>
                <div class="float-icon house">🏠</div>
                <div class="float-icon leaf">🌱</div>
            </div>
        </div>
    </div>
</body>
</html>
