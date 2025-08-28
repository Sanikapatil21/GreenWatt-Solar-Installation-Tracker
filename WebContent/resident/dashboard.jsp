<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Resident Dashboard - GreenWatt Solar</title>
    <style>
        .resident-dashboard-page {
            background: linear-gradient(135deg, rgba(34, 197, 94, 0.1), rgba(22, 163, 74, 0.1));
            min-height: 100vh;
        }

        .dashboard-container {
            max-width: 1200px;
            margin: 0 auto;
            min-height: 100vh;
            display: flex;
            flex-direction: column;
        }

        .dashboard-header {
            background: linear-gradient(135deg, #22c55e, #16a34a);
            padding: 1.5rem 2rem;
            box-shadow: 0 4px 20px rgba(34, 197, 94, 0.3);
        }

        .header-content {
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .dashboard-header .logo {
            display: flex;
            align-items: center;
            color: white;
        }

        .dashboard-header .logo-icon {
            font-size: 2rem;
            margin-right: 0.75rem;
        }

        .dashboard-header h1 {
            font-size: 1.75rem;
            font-weight: 700;
            margin: 0;
        }

        .user-info {
            display: flex;
            align-items: center;
            gap: 1rem;
        }

        .welcome-text {
            color: rgba(255, 255, 255, 0.9);
            font-size: 0.95rem;
        }

        .logout-btn {
            background: rgba(255, 255, 255, 0.2);
            color: white;
            padding: 0.5rem 1rem;
            border-radius: 8px;
            text-decoration: none;
            font-size: 0.9rem;
            transition: all 0.3s ease;
            border: 1px solid rgba(255, 255, 255, 0.3);
        }

        .logout-btn:hover {
            background: rgba(255, 255, 255, 0.3);
            transform: translateY(-2px);
        }

        .dashboard-main {
            flex: 1;
            padding: 2rem;
        }

        .dashboard-title {
            text-align: center;
            margin-bottom: 3rem;
        }

        .dashboard-title h2 {
            font-size: 2.5rem;
            color: #166534;
            margin-bottom: 0.5rem;
            font-weight: 700;
        }

        .dashboard-title p {
            color: #374151;
            font-size: 1.1rem;
        }

        .dashboard-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(280px, 1fr));
            gap: 2rem;
            max-width: 900px;
            margin: 0 auto;
        }

        .dashboard-card {
            background: white;
            border-radius: 16px;
            padding: 2rem;
            box-shadow: 0 10px 30px rgba(34, 197, 94, 0.1);
            border: 2px solid rgba(34, 197, 94, 0.1);
            transition: all 0.3s ease;
            position: relative;
            overflow: hidden;
            text-align: center;
        }

        .dashboard-card::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            height: 4px;
            background: linear-gradient(90deg, #22c55e, #16a34a);
        }

        .dashboard-card:hover {
            transform: translateY(-8px);
            box-shadow: 0 20px 40px rgba(34, 197, 94, 0.15);
            border-color: rgba(22, 163, 74, 0.3);
        }

        .card-icon {
            font-size: 3rem;
            margin-bottom: 1rem;
            display: block;
        }

        .card-content h3 {
            font-size: 1.4rem;
            color: #166534;
            margin-bottom: 0.75rem;
            font-weight: 600;
        }

        .card-content p {
            color: #6b7280;
            margin-bottom: 1.5rem;
            line-height: 1.6;
        }

        .card-action {
            display: inline-block;
            background: linear-gradient(135deg, #22c55e, #16a34a);
            color: white;
            padding: 0.75rem 1.5rem;
            border-radius: 10px;
            text-decoration: none;
            font-weight: 500;
            transition: all 0.3s ease;
            box-shadow: 0 4px 15px rgba(34, 197, 94, 0.3);
        }

        .card-action:hover {
            background: linear-gradient(135deg, #16a34a, #15803d);
            transform: translateY(-2px);
            box-shadow: 0 6px 20px rgba(22, 163, 74, 0.4);
        }

        .dashboard-footer {
            background: #f8fafc;
            padding: 1.5rem;
            text-align: center;
            border-top: 1px solid #e2e8f0;
            color: #64748b;
        }

        /* Card colors */
        .apply-card .card-icon { color: #22c55e; }
        .applications-card .card-icon { color: #f59e0b; }
        .reports-card .card-icon { color: #8b5cf6; }

        @media (max-width: 768px) {
            .dashboard-header {
                padding: 1rem;
            }
            .header-content {
                flex-direction: column;
                gap: 1rem;
                text-align: center;
            }
            .dashboard-main {
                padding: 1rem;
            }
            .dashboard-title h2 {
                font-size: 2rem;
            }
            .dashboard-grid {
                grid-template-columns: 1fr;
                gap: 1.5rem;
            }
            .dashboard-card {
                padding: 1.5rem;
            }
            .user-info {
                flex-direction: column;
                gap: 0.5rem;
            }
        }
    </style>
</head>
<body class="resident-dashboard-page">
    <div class="dashboard-container">
        <header class="dashboard-header">
            <div class="header-content">
                <div class="logo">
                    <div class="logo-icon">🌞</div>
                    <h1>GreenWatt</h1>
                </div>
                <div class="user-info">
                    <span class="welcome-text">Welcome, Resident</span>
                    <a href="../login/resident-login.jsp" class="logout-btn">Logout</a>
                </div>
            </div>
        </header>

        <main class="dashboard-main">
            <div class="dashboard-title">
                <h2>Resident Dashboard</h2>
                <p>Manage your solar installation journey</p>
            </div>

            <div class="dashboard-grid">
                <div class="dashboard-card apply-card">
                    <div class="card-icon">⚡</div>
                    <div class="card-content">
                        <h3>Apply for Installation</h3>
                        <p>Submit a new request for solar installation</p>
                        <a href="apply-installation.jsp" class="card-action">Apply Now</a>
                    </div>
                </div>

                <div class="dashboard-card applications-card">
                    <div class="card-icon">📄</div>
                    <div class="card-content">
                        <h3>My Applications</h3>
                        <p>Track and monitor your installation applications</p>
                        <a href="../ResidentApplications" class="card-action">View Applications</a>
                    </div>
                </div>

                <div class="dashboard-card reports-card">
                    <div class="card-icon">📊</div>
                    <div class="card-content">
                        <h3>My Reports</h3>
                        <p>View installation progress and subsidy details</p>
                        <a href="reports.jsp" class="card-action">View Reports</a>
                    </div>
                </div>
            </div>
        </main>

        <footer class="dashboard-footer">
            <p>&copy; 2024 GreenWatt Solar. Empowering sustainable energy solutions.</p>
        </footer>
    </div>
</body>
</html>
