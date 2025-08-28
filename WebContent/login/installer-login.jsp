<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Installer Login - GreenWatt</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }

        body {
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            background: linear-gradient(135deg, rgba(5, 150, 105, 0.05), rgba(16, 185, 129, 0.03));
            position: relative;
            overflow: hidden;
            padding: 2rem 1rem;
        }

        .login-container {
            position: relative;
            z-index: 10;
            max-width: 420px;
            width: 100%;
        }

        .login-card {
            background: white;
            border: 2px solid rgba(5, 150, 105, 0.15);
            border-radius: 1.5rem;
            padding: 2.5rem;
            box-shadow: 0 10px 25px rgba(5, 150, 105, 0.15);
            animation: fadeInUp 0.6s ease-out forwards;
            width: 100%;
        }

        .login-header {
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

        .logo-section h1 {
            font-size: 1.75rem;
            font-weight: 700;
            margin: 0;
        }

        .logo-icon {
            width: 4rem;
            height: 4rem;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 1.5rem;
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

        .form-group input {
            padding: 0.875rem 1rem;
            border: 2px solid #e5e7eb;
            border-radius: 0.75rem;
            font-size: 1rem;
            background: #fff;
            transition: all 0.3s ease;
        }

        .form-group input:focus {
            outline: none;
            border-color: #059669;
            box-shadow: 0 0 0 3px rgba(5, 150, 105, 0.15);
        }

        .login-btn {
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

        .login-btn:hover {
            background: linear-gradient(135deg, #047857, #059669);
            transform: translateY(-2px);
            box-shadow: 0 10px 30px rgba(5, 150, 105, 0.3);
        }

        .btn-glow {
            position: absolute;
            top: 0; left: 0; right: 0; bottom: 0;
            background: radial-gradient(circle, rgba(52, 211, 153, 0.3) 0%, transparent 70%);
            opacity: 0;
            transition: opacity 0.3s ease;
        }

        .login-btn:hover .btn-glow {
            opacity: 1;
        }

        .error-message {
            margin-top: 1rem;
            padding: 1rem;
            background: rgba(239, 68, 68, 0.1);
            border: 1px solid rgba(239, 68, 68, 0.2);
            border-radius: 0.5rem;
            text-align: center;
            color: #ef4444;
            font-weight: 500;
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
        }

        .float-icon.tools {
            top: 15%;
            right: 10%;
            font-size: 3rem;
            animation: float 4s ease-in-out infinite;
        }

        .float-icon.panel {
            bottom: 20%;
            left: 20%;
        }

        .back-link {
            position: absolute;
            top: 2rem;
            left: 2rem;
            color: #059669;
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
            border-color: #059669;
            transform: translateY(-1px);
            box-shadow: 0 4px 12px rgba(5, 150, 105, 0.15);
        }

        @keyframes float {
            0%, 100% { transform: translateY(0px); }
            50% { transform: translateY(-20px); }
        }

        @keyframes fadeInUp {
            from { opacity: 0; transform: translateY(30px); }
            to { opacity: 1; transform: translateY(0); }
        }
    </style>
</head>
<body>
    <a href="../index.jsp" class="back-link">← Back to Home</a>
    <div class="login-container">
        <div class="login-card">
            <div class="login-header">
                <div class="logo-section">
                    <div class="logo-icon">🔧</div>
                    <h1>GreenWatt</h1>
                </div>
                <h3>Installer Login</h3>
                <p class="login-subtitle">Access your installation dashboard</p>
            </div>

            <form method="post" action="../InstallerLogin" class="login-form">
                <div class="form-group">
                    <input name="email" type="email" placeholder="Email" required>
                </div>
                <div class="form-group">
                    <input name="password" type="password" placeholder="Password" required>
                </div>
                <button type="submit" class="login-btn">
                    <span>Login</span>
                    <div class="btn-glow"></div>
                </button>
            </form>

            <!-- Error Message Placeholder -->
            <div class="error-message" id="errorMsg" style="display: none;">
                Login failed. Please try again.
            </div>
        </div>
    </div>

    <div class="login-background">
        <div class="bg-pattern"></div>
        <div class="floating-elements">
            <div class="float-icon solar">☀️</div>
            <div class="float-icon tools">🔧</div>
            <div class="float-icon panel">🔋</div>
        </div>
    </div>
</body>
</html>
