<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Resident Login - GreenWatt</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

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

        .login-container {
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            position: relative;
            overflow: hidden;
            padding: 2rem 1rem;
        }

        .login-card {
            background: var(--gradient-card);
            border: 2px solid rgba(34, 197, 94, 0.1);
            border-radius: 1.5rem;
            padding: 2.5rem;
            box-shadow: var(--shadow-card);
            animation: fadeInUp 0.6s ease-out forwards;
            max-width: 400px;
            width: 100%;
            position: relative;
            z-index: 10;
        }

        .resident-login {
            border: 2px solid #059669;
            background: linear-gradient(135deg, rgba(5, 150, 105, 0.1), rgba(16, 185, 129, 0.05));
        }

        .login-header {
            text-align: center;
            margin-bottom: 2rem;
            background: var(--gradient-solar);
            color: white;
            padding: 2rem 1rem;
            margin: -2.5rem -2.5rem 2rem -2.5rem;
            border-radius: 1.5rem 1.5rem 0 0;
        }

        .resident-login .login-header {
            background: linear-gradient(135deg, #059669, #10b981);
        }

        .logo-section {
            display: flex;
            flex-direction: column;
            align-items: center;
            gap: 1rem;
            margin-bottom: 1rem;
        }

        .logo-section h1 {
            font-size: 1.75rem;
            font-weight: 700;
            margin: 0;
        }

        .logo-icon {
            width: 4rem;
            height: 4rem;
            border-radius: 50%;
            background: rgba(255, 255, 255, 0.2);
            backdrop-filter: blur(4px);
            border: 2px solid rgba(255, 255, 255, 0.3);
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 1.5rem;
            box-shadow: 0 8px 25px rgba(0, 0, 0, 0.1);
        }

        .resident-icon {
            background: linear-gradient(135deg, #34d399, #6ee7b7);
            box-shadow: 0 0 20px rgba(52, 211, 153, 0.3);
        }

        .login-header h3 {
            font-size: 1.25rem;
            font-weight: 600;
            margin-bottom: 0.5rem;
        }

        .login-subtitle {
            font-size: 0.95rem;
            opacity: 0.9;
            margin: 0;
        }

        .login-form {
            display: flex;
            flex-direction: column;
            gap: 1.5rem;
        }

        .form-group {
            display: flex;
            flex-direction: column;
            gap: 0.5rem;
        }

        .form-group label {
            font-size: 0.875rem;
            font-weight: 600;
            color: var(--foreground);
        }

        .form-group input {
            padding: 0.875rem 1rem;
            border: 2px solid var(--border);
            border-radius: 0.75rem;
            font-size: 1rem;
            background: var(--background);
            color: var(--foreground);
            transition: all 0.3s ease;
        }

        .form-group input:focus {
            outline: none;
            border-color: var(--primary);
            box-shadow: 0 0 0 3px rgba(34, 197, 94, 0.1);
        }

        .login-btn {
            position: relative;
            padding: 1rem 2rem;
            background: var(--gradient-solar);
            color: white;
            border: none;
            border-radius: 0.75rem;
            font-size: 1rem;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
            overflow: hidden;
        }

        .resident-btn {
            background: linear-gradient(135deg, #059669, #10b981);
            border: 2px solid transparent;
            background-clip: padding-box;
        }

        .resident-btn:hover {
            background: linear-gradient(135deg, #047857, #059669);
            transform: translateY(-2px);
            box-shadow: 0 10px 30px rgba(5, 150, 105, 0.3);
        }

        .btn-glow {
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background: radial-gradient(circle, rgba(255, 255, 255, 0.2) 0%, transparent 70%);
            opacity: 0;
            transition: opacity 0.3s ease;
        }

        .login-btn:hover .btn-glow {
            opacity: 1;
        }

        .resident-btn .btn-glow {
            background: radial-gradient(circle, rgba(52, 211, 153, 0.3) 0%, transparent 70%);
        }

        .register-section {
            margin-top: 2rem;
            padding-top: 1.5rem;
            border-top: 1px solid rgba(5, 150, 105, 0.2);
            text-align: center;
        }

        .register-section p {
            color: #6b7280;
            margin-bottom: 0.75rem;
            font-size: 0.9rem;
        }

        .register-link {
            display: inline-flex;
            align-items: center;
            gap: 0.5rem;
            color: #059669;
            text-decoration: none;
            font-weight: 600;
            font-size: 0.95rem;
            padding: 0.75rem 1.5rem;
            border: 2px solid #059669;
            border-radius: 0.75rem;
            transition: all 0.3s ease;
            background: linear-gradient(135deg, rgba(5, 150, 105, 0.1), transparent);
        }

        .register-link:hover {
            background: #059669;
            color: white;
            transform: translateY(-1px);
            box-shadow: 0 5px 15px rgba(5, 150, 105, 0.2);
        }

        .error-message {
            margin-top: 1rem;
            padding: 1rem;
            background: rgba(239, 68, 68, 0.1);
            border: 1px solid rgba(239, 68, 68, 0.2);
            border-radius: 0.5rem;
            text-align: center;
        }

        .login-background {
            position: absolute;
            inset: 0;
            z-index: 1;
        }

        .bg-pattern {
            position: absolute;
            inset: 0;
            background-image: radial-gradient(circle at 25% 25%, rgba(5, 150, 105, 0.1) 0%, transparent 50%),
                              radial-gradient(circle at 75% 75%, rgba(16, 185, 129, 0.1) 0%, transparent 50%);
            background-size: 400px 400px;
            animation: float 8s ease-in-out infinite;
        }

        .floating-elements {
            position: absolute;
            inset: 0;
            pointer-events: none;
        }

        .float-icon {
            position: absolute;
            font-size: 2rem;
            opacity: 0.6;
            animation: float 6s ease-in-out infinite;
        }

        .float-icon.solar {
            top: 20%;
            left: 15%;
            animation-delay: 0s;
        }

        .float-icon.house {
            top: 15%;
            right: 10%;
            font-size: 3rem;
            animation: float 4s ease-in-out infinite;
            animation-delay: 0.5s;
        }

        .float-icon.leaf {
            bottom: 20%;
            left: 20%;
            animation-delay: 1s;
        }

        .back-link {
            position: absolute;
            top: 2rem;
            left: 2rem;
            color: var(--primary);
            text-decoration: none;
            font-weight: 600;
            padding: 0.75rem 1.5rem;
            background: rgba(255, 255, 255, 0.9);
            backdrop-filter: blur(4px);
            border-radius: 0.75rem;
            border: 1px solid rgba(5, 150, 105, 0.2);
            transition: all 0.3s ease;
            z-index: 20;
        }

        .back-link:hover {
            background: rgba(255, 255, 255, 1);
            border-color: var(--primary);
            transform: translateY(-1px);
            box-shadow: 0 4px 12px rgba(5, 150, 105, 0.15);
        }

        @keyframes float {
            0%, 100% { transform: translateY(0px); }
            50% { transform: translateY(-20px); }
        }

        @media (max-width: 768px) {
            .login-container { padding: 1rem; }
            .login-card { padding: 2rem 1.5rem; margin: 1rem; }
            .login-header { margin: -2rem -1.5rem 2rem -1.5rem; padding: 1.5rem 1rem; }
            .back-link { position: relative; top: auto; left: auto; margin-bottom: 1rem; display: inline-block; }
        }
    </style>
</head>
<body>
    <div class="login-container">
        <div class="login-card resident-login">
            <div class="login-header">
                <div class="logo-section">
                    <div class="logo-icon resident-icon">🏠</div>
                    <h1>GreenWatt</h1>
                </div>
                <h3>Resident Login</h3>
                <p class="login-subtitle">Access your solar installation dashboard</p>
            </div>
            
            <form method="post" action="<%=request.getContextPath()%>/ResidentLogin"
 class="login-form">
                <div class="form-group">
                    <label for="email">Email Address</label>
                    <input type="email" name="email" id="email" placeholder="Enter your email" required>
                </div>
                
                <div class="form-group">
                    <label for="password">Password</label>
                    <input type="password" name="password" id="password" placeholder="Enter your password" required>
                </div>
                
                <button type="submit" class="login-btn resident-btn">
                    <span>Sign In</span>
                    <div class="btn-glow"></div>
                </button>
                
                <div class="register-section">
                    <p>New to GreenWatt?</p>
                    <a href="../register/resident-register.jsp" class="register-link">Create your account →</a>
                </div>
            </form>
            
            <!-- Error message placeholder -->
            <div id="error-msg" class="error-message" style="display: none;">
                <p style="color:red">Error message will appear here</p>
            </div>
        </div>
        
        <div class="login-background">
            <div class="bg-pattern"></div>
            <div class="floating-elements">
                <div class="float-icon solar">☀️</div>
                <div class="float-icon house">🏠</div>
                <div class="float-icon leaf">🌱</div>
            </div>
        </div>
        
        <a href="../index.jsp" class="back-link">← Back to Home</a>
    </div>
</body>
</html>
