<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Login - GreenWatt</title>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet">
    <style>
        :root {
            --background: #ffffff;
            --foreground: #1a1a1a;
            --muted: #f0f0f0;
            --muted-foreground: #777;
            --primary: #22c55e;
            --border: #e5e5e5;
            --gradient-solar: linear-gradient(135deg, #22c55e, #3b82f6);
            --gradient-card: #f9fafb;
            --shadow-card: 0 4px 8px rgba(0,0,0,0.08);
            --shadow-glow: 0 0 15px rgba(34,197,94,0.4);
        }

        * { margin: 0; padding: 0; box-sizing: border-box; font-family: 'Inter', sans-serif; }

        body { background: var(--background); color: var(--foreground); }

        /* Header */
        .admin-header { background: var(--background); border-bottom: 1px solid var(--border); padding: 1rem 0; position: sticky; top: 0; z-index: 50; }
        .header-content { display: flex; align-items: center; justify-content: space-between; max-width: 1200px; margin: 0 auto; }
        .logo-section { display: flex; align-items: center; gap: 1rem; }
        .logo-icon { width: 3rem; height: 3rem; border-radius: 50%; background: var(--gradient-solar); display: flex; align-items: center; justify-content: center; color: white; box-shadow: var(--shadow-card); }
        .logo-icon .icon { width: 1.5rem; height: 1.5rem; }
        .logo-text { display: flex; flex-direction: column; }
        .logo-title { font-size: 1.5rem; font-weight: 700; color: var(--foreground); line-height: 1; }
        .logo-subtitle { font-size: 0.875rem; color: var(--muted-foreground); font-weight: 500; }
        .back-link { color: var(--primary); text-decoration: none; font-weight: 500; padding: 0.5rem 1rem; border-radius: 0.5rem; transition: all 0.3s ease; border: 1px solid transparent; }
        .back-link:hover { background: var(--muted); border-color: var(--border); }

        /* Main */
        .admin-main { min-height: calc(100vh - 140px); display: flex; align-items: center; padding: 2rem 0; background: linear-gradient(135deg, rgba(34,197,94,0.02), rgba(59,130,246,0.02)); }
        .admin-login-container { display: grid; grid-template-columns: 1fr 1fr; gap: 4rem; max-width: 64rem; margin: 0 auto; align-items: center; }

        /* Login Form */
        .login-form-card {
    background: var(--gradient-card);
    border: 1px solid rgba(34, 197, 94, 0.1);
    border-radius: 1rem;
    padding: 2rem;           /* reduced padding */
    max-width: 360px;        /* set a smaller width */
    margin: 0 auto;
    box-shadow: var(--shadow-card);
    animation: fadeInUp 0.6s ease-out forwards;
}

        .form-header { text-align: center; margin-bottom: 2rem; }
        .admin-icon { width: 4rem; height: 4rem; margin: 0 auto 1.5rem; border-radius: 50%; background: var(--gradient-solar); display: flex; align-items: center; justify-content: center; color: white; box-shadow: var(--shadow-glow); }
        .admin-icon .icon { width: 2rem; height: 2rem; }
        .form-title { font-size: 1.75rem; font-weight: 700; color: var(--foreground); margin-bottom: 0.5rem; }
        .form-description { color: var(--muted-foreground); font-size: 1rem; }
        .login-form { display: flex; flex-direction: column; gap: 1.5rem; }
        .form-group { display: flex; flex-direction: column; gap: 0.5rem; }
        .form-label { font-size: 0.875rem; font-weight: 600; color: var(--foreground); }
        .form-input { padding: 0.875rem 1rem; border: 2px solid var(--border); border-radius: 0.5rem; font-size: 1rem; background: var(--background); color: var(--foreground); transition: all 0.3s ease; }
        .form-input:focus { outline: none; border-color: var(--primary); box-shadow: 0 0 0 3px rgba(34,197,94,0.1); }
        .form-input::placeholder { color: var(--muted-foreground); }
        .submit-button { background: var(--gradient-solar); color: white; border: none; padding: 1rem 1.5rem; border-radius: 0.5rem; font-weight: 600; font-size: 1rem; cursor: pointer; display: flex; align-items: center; justify-content: center; gap: 0.5rem; transition: all 0.3s ease; margin-top: 0.5rem; }
        .submit-button:hover { box-shadow: var(--shadow-glow); transform: translateY(-1px); }

        /* Error */
        .error-message { background: rgba(239, 68, 68, 0.1); border: 1px solid rgba(239, 68, 68, 0.2); border-radius: 0.5rem; padding: 1rem; margin-top: 1rem; display: flex; align-items: center; gap: 0.75rem; }
        .error-icon { width: 1.25rem; height: 1.25rem; color: #ef4444; flex-shrink: 0; }
        .error-text { color: #ef4444; font-size: 0.875rem; font-weight: 500; }

        /* Info Panel */
        .login-info-panel { background: var(--gradient-card); border: 1px solid rgba(34, 197, 94, 0.1); border-radius: 1rem; padding: 2.5rem; box-shadow: var(--shadow-card); animation: fadeInUp 0.6s ease-out forwards; animation-delay: 0.2s; }
        .info-content { text-align: center; }
        .info-title { font-size: 1.5rem; font-weight: 700; color: var(--foreground); margin-bottom: 2rem; }
        .info-features { display: flex; flex-direction: column; gap: 1.5rem; }
        .info-item { display: flex; align-items: center; gap: 1rem; padding: 1rem; border-radius: 0.5rem; background: rgba(34, 197, 94, 0.05); border: 1px solid rgba(34, 197, 94, 0.1); transition: all 0.3s ease; }
        .info-item:hover { background: rgba(34, 197, 94, 0.1); transform: translateX(4px); }
        .info-icon { width: 1.5rem; height: 1.5rem; color: var(--primary); flex-shrink: 0; }
        .info-item span { font-weight: 500; color: var(--foreground); }

        /* Footer */
        .admin-footer { background: var(--foreground); color: var(--background); padding: 1.5rem 0; text-align: center; }
        .admin-footer .footer-text { font-size: 0.875rem; opacity: 0.8; }

        /* Animations */
        @keyframes fadeInUp { from { opacity: 0; transform: translateY(20px); } to { opacity: 1; transform: translateY(0); } }

        /* Responsive */
        @media (max-width: 1024px) { .admin-login-container { grid-template-columns: 1fr; gap: 2rem; } }
        @media (max-width: 768px) { .header-content { flex-direction: column; gap: 1rem; text-align: center; } }
    </style>
</head>
<body>
    <!-- Header -->
    <header class="admin-header">
        <div class="header-content">
            <div class="logo-section">
                <div class="logo-icon">
                    <svg class="icon" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 3v1m0 16v1m9-9h-1M4 12H3m15.364 6.364l-.707-.707M6.343 6.343l-.707-.707m12.728 0l-.707.707M6.343 17.657l-.707.707M16 12a4 4 0 11-8 0 4 4 0 018 0z"></path>
                    </svg>
                </div>
                <div class="logo-text">
                    <h1 class="logo-title">GreenWatt</h1>
                    <p class="logo-subtitle">Solar Energy Solutions</p>
                </div>
            </div>
            <a href="../index.jsp" class="back-link">← Back to Home</a>
        </div>
    </header>

    <!-- Main -->
    <main class="admin-main">
        <div class="admin-login-container">
            <div class="login-form-card">
                <div class="form-header">
                    <div class="admin-icon">
                        <svg class="icon" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M16 7a4 4 0 11-8 0 4 4 0 018 0zM12 14a7 7 0 00-7 7h14a7 7 0 00-7-7z"></path>
                        </svg>
                    </div>
                    <h2 class="form-title">Admin Login</h2>
                    <p class="form-description">Access the GreenWatt administration panel</p>
                </div>

                <form method="post" action="../AdminLogin" class="login-form">
                    <div class="form-group">
                        <label for="email" class="form-label">Email Address</label>
                        <input type="email" id="email" name="email" placeholder="Enter your admin email" required class="form-input">
                    </div>
                    <div class="form-group">
                        <label for="password" class="form-label">Password</label>
                        <input type="password" id="password" name="password" placeholder="Enter your password" required class="form-input">
                    </div>
                    <button type="submit" class="submit-button">
                        <span>Sign In</span>
                        <svg class="button-icon" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M17 8l4 4m0 0l-4 4m4-4H3"></path>
                        </svg>
                    </button>
                </form>

                <div class="error-message" style="display: none;">
                    <svg class="error-icon" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 9v2m0 4h.01m-6.938 4h13.856c1.54 0 2.502-1.667 1.732-2.5L13.732 4c-.77-.833-1.964-.833-2.732 0L3.732 16.5c-.77.833.192 2.5 1.732 2.5z"></path>
                    </svg>
                    <span class="error-text">Invalid credentials. Please try again.</span>
                </div>

                <div class="form-footer">
                    <p class="footer-text">Need help? Contact your system administrator</p>
                </div>
            </div>

            <div class="login-info-panel">
                <div class="info-content">
                    <h3 class="info-title">Administrator Access</h3>
                    <div class="info-features">
                        <div class="info-item"><span>Manage subsidy applications</span></div>
                        <div class="info-item"><span>Oversee installer network</span></div>
                        <div class="info-item"><span>View analytics & reports</span></div>
                        <div class="info-item"><span>System configuration</span></div>
                    </div>
                </div>
            </div>
        </div>
    </main>

    <!-- Footer -->
    <footer class="admin-footer">
        <p class="footer-text">© 2024 GreenWatt - Smart Solar Subsidy & Installation Tracker</p>
    </footer>
</body>
</html>
