<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Installer Dashboard - GreenWatt</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <style>
        body {
            margin: 0;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(135deg, rgba(22, 163, 74, 0.05), rgba(5, 150, 105, 0.05));
            min-height: 100vh;
        }

        .dashboard-container {
            max-width: 1200px;
            margin: 0 auto;
            min-height: 100vh;
            display: flex;
            flex-direction: column;
        }

        header {
            background: linear-gradient(135deg, #22c55e, #16a34a);
            padding: 1.5rem 2rem;
            box-shadow: 0 4px 20px rgba(22, 163, 74, 0.25);
            color: white;
        }

        .header-content {
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .logo {
            font-weight: bold;
            font-size: 1.6rem;
            display: flex;
            align-items: center;
        }

        .logo-icon {
            margin-right: 0.5rem;
            font-size: 2rem;
        }

        .logout-btn {
            background: rgba(255, 255, 255, 0.2);
            padding: 0.5rem 1rem;
            border-radius: 8px;
            color: white;
            text-decoration: none;
            font-size: 0.9rem;
            transition: 0.3s;
            border: 1px solid rgba(255, 255, 255, 0.3);
        }

        .logout-btn:hover {
            background: rgba(255, 255, 255, 0.3);
            transform: translateY(-2px);
        }

        main {
            flex: 1;
            padding: 2rem;
        }

        .dashboard-title {
            text-align: center;
            margin-bottom: 2rem;
        }

        .dashboard-title h2 {
            font-size: 2.5rem;
            color: #065f46;
            margin-bottom: 0.5rem;
        }

        .dashboard-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(280px, 1fr));
            gap: 2rem;
            max-width: 1000px;
            margin: 0 auto;
        }

        .dashboard-card {
            background: white;
            border-radius: 16px;
            padding: 2rem;
            box-shadow: 0 10px 30px rgba(22, 163, 74, 0.1);
            border: 2px solid rgba(22, 163, 74, 0.1);
            transition: all 0.3s ease;
            position: relative;
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
            box-shadow: 0 20px 40px rgba(22, 163, 74, 0.15);
            border-color: rgba(22, 163, 74, 0.3);
        }

        .card-icon {
            font-size: 3rem;
            margin-bottom: 1rem;
            display: block;
        }

        .card-content h3 {
            font-size: 1.4rem;
            color: #065f46;
            margin-bottom: 0.75rem;
            font-weight: 600;
        }

        .card-content p {
            color: #4b5563;
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
            box-shadow: 0 4px 15px rgba(22, 163, 74, 0.3);
        }

        .card-action:hover {
            background: linear-gradient(135deg, #16a34a, #15803d);
            transform: translateY(-2px);
            box-shadow: 0 6px 20px rgba(22, 163, 74, 0.4);
        }

        .form-card {
            background: #fff;
            border-radius: 16px;
            padding: 2rem;
            box-shadow: 0 10px 30px rgba(22, 163, 74, 0.1);
            border: 2px solid rgba(22, 163, 74, 0.1);
            max-width: 500px;
            margin: 0 auto;
            transition: all 0.3s ease;
        }

        input {
            width: 100%;
            padding: 0.7rem 1rem;
            border-radius: 8px;
            border: 1px solid #d1d5db;
            margin-bottom: 1rem;
            font-size: 1rem;
        }

        button {
            background: linear-gradient(135deg, #22c55e, #16a34a);
            color: white;
            padding: 0.8rem;
            border: none;
            border-radius: 10px;
            font-size: 1rem;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
            width: 100%;
        }

        button:hover {
            background: linear-gradient(135deg, #16a34a, #15803d);
            transform: translateY(-2px);
            box-shadow: 0 6px 20px rgba(22, 163, 74, 0.4);
        }

        .msg {
            background: #ecfdf5;
            border-left: 4px solid #10b981;
            padding: 0.75rem 1rem;
            margin-bottom: 1rem;
            border-radius: 6px;
            color: #065f46;
            font-size: 0.95rem;
            text-align: center;
        }

        footer {
            background: #f0fdf4;
            padding: 1rem;
            text-align: center;
            border-top: 1px solid #d1fae5;
            color: #047857;
            font-size: 0.9rem;
        }

        @media (max-width: 768px) {
            .dashboard-grid {
                grid-template-columns: 1fr;
                gap: 1.5rem;
            }
            .form-card {
                padding: 1.5rem;
            }
        }
    </style>
</head>
<body>
    <div class="dashboard-container">
        <header>
            <div class="header-content">
                <div class="logo"><span class="logo-icon">👷‍♂️</span> GreenWatt</div>
                <a href="../login/installer-login.jsp" class="logout-btn">Logout</a>
            </div>
        </header>

        <main>
            <div class="dashboard-title">
                <h2>Installer Dashboard</h2>
                <p>Manage approved installations and reports</p>
            </div>

            <div class="dashboard-grid">
                <div class="dashboard-card approved-card">
                    <div class="card-icon">✅</div>
                    <div class="card-content">
                        <h3>Approved Requests</h3>
                        <p>View and take approved installation requests</p>
                        <a href="${pageContext.request.contextPath}/ApprovedRequests" class="card-action">View Requests</a>
                    </div>
                </div>

                <div class="dashboard-card add-report-card">
                    <div class="card-icon">➕</div>
                    <div class="card-content">
                        <h3>Add Report</h3>
                        <p>Add installation reports for completed requests</p>
                        <a href="${pageContext.request.contextPath}/AddReport" class="card-action">Add Report</a>
                    </div>
                </div>

                <div class="dashboard-card view-report-card">
                    <div class="card-icon">📄</div>
                    <div class="card-content">
                        <h3>My Reports</h3>
                        <p>View all submitted reports</p>
                        <a href="${pageContext.request.contextPath}/InstallerReports" class="card-action">View Reports</a>
                    </div>
                </div>

                <div class="form-card">
                    <h3>Change Password</h3>
                    <c:if test="${param.msg != null}">
                        <div class="msg">${param.msg}</div>
                    </c:if>
                    <form method="post" action="../ChangePassword">
                        <input type="password" name="oldPassword" placeholder="Old password" required>
                        <input type="password" name="newPassword" placeholder="New password" required>
                        <button type="submit">Update</button>
                    </form>
                </div>
            </div>
        </main>

        <footer>
            <p>&copy; 2024 GreenWatt Solar. Empowering sustainable energy solutions.</p>
        </footer>
    </div>
</body>
</html>
