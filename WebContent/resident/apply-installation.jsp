<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Apply for Installation - GreenWatt</title>
    <style>
        body {
            margin: 0;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(135deg, rgba(16, 185, 129, 0.1), rgba(5, 150, 105, 0.1));
            min-height: 100vh;
        }

        .page-container {
            max-width: 900px;
            margin: 0 auto;
            min-height: 100vh;
            display: flex;
            flex-direction: column;
        }

        header {
            background: linear-gradient(135deg, #22c55e, #16a34a);
            padding: 1.5rem 2rem;
            box-shadow: 0 4px 20px rgba(22, 163, 74, 0.3);
            color: white;
        }

        .header-content {
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .logo {
            display: flex;
            align-items: center;
            font-weight: bold;
            font-size: 1.5rem;
        }

        .logo-icon {
            margin-right: 0.75rem;
            font-size: 2rem;
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

        main {
            flex: 1;
            padding: 2rem;
            display: flex;
            justify-content: center;
            align-items: flex-start;
        }

        .form-card {
            background: #fff;
            padding: 2rem;
            border-radius: 16px;
            box-shadow: 0 10px 30px rgba(22, 163, 74, 0.15);
            border: 2px solid rgba(22, 163, 74, 0.1);
            width: 100%;
            max-width: 600px;
            text-align: center;
            transition: all 0.3s ease;
        }

        .form-card h3 {
            font-size: 1.8rem;
            color: #065f46;
            margin-bottom: 1.5rem;
        }

        form {
            display: flex;
            flex-direction: column;
            gap: 1.2rem;
            text-align: left;
        }

        label {
            font-weight: 600;
            color: #374151;
            margin-bottom: 0.3rem;
        }

        input {
            padding: 0.7rem 1rem;
            border: 1px solid #d1d5db;
            border-radius: 8px;
            font-size: 1rem;
            transition: border-color 0.2s ease;
        }

        input:focus {
            border-color: #16a34a;
            outline: none;
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
            margin-top: 1rem;
        }

        button:hover {
            background: linear-gradient(135deg, #16a34a, #15803d);
            transform: translateY(-2px);
            box-shadow: 0 6px 20px rgba(22, 163, 74, 0.4);
        }

        /* Back to Home Button */
        .back-home {
            display: inline-block;
            margin-top: 1rem;
            background: #f0fdf4;
            color: #047857;
            padding: 0.7rem 1.2rem;
            border-radius: 8px;
            text-decoration: none;
            font-weight: 600;
            border: 1px solid #bbf7d0;
            transition: all 0.3s ease;
        }

        .back-home:hover {
            background: #bbf7d0;
            transform: translateY(-2px);
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
            main {
                padding: 1rem;
            }
            .form-card {
                padding: 1.5rem;
            }
        }
    </style>
</head>
<body>
    <div class="page-container">
        <header>
            <div class="header-content">
                <div class="logo">
                    <div class="logo-icon">🌞</div>
                    GreenWatt
                </div>
                <a href="../login/resident-login.jsp" class="logout-btn">Logout</a>
            </div>
        </header>

        <main>
            <div class="form-card">
                <h3>Apply for Solar Installation</h3>
                <form method="post" action="../ApplyInstallation">
                    <label>System Type</label>
                    <input name="systemType" placeholder="On-Grid/Off-Grid" required>

                    <label>Capacity (kW)</label>
                    <input name="capacityKW" type="number" min="1" step="0.1" required>

                    <button type="submit">Submit Application</button>
                </form>

                <!-- Back to Home Button -->
                <a href="dashboard.jsp" class="back-home">⬅ Back to Home</a>
            </div>
        </main>

        <footer>
            <p>&copy; 2024 GreenWatt Solar. Empowering sustainable energy solutions.</p>
        </footer>
    </div>
</body>
</html>
