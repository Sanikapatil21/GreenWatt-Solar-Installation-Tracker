<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>My Applications - GreenWatt</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <style>
        body {
            margin: 0;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(135deg, rgba(16, 185, 129, 0.08), rgba(5, 150, 105, 0.08));
            min-height: 100vh;
        }

        .page-container {
            max-width: 1000px;
            margin: 0 auto;
            display: flex;
            flex-direction: column;
            min-height: 100vh;
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
            display: flex;
            justify-content: center;
        }

        .card {
            background: #fff;
            border-radius: 16px;
            box-shadow: 0 10px 30px rgba(22, 163, 74, 0.12);
            border: 2px solid rgba(22, 163, 74, 0.1);
            padding: 2rem;
            width: 100%;
            max-width: 950px;
            transition: 0.3s ease;
        }

        .card h3 {
            font-size: 1.8rem;
            color: #065f46;
            margin-bottom: 1rem;
            text-align: center;
        }

        .back-btn {
            display: inline-block;
            margin-bottom: 1rem;
            padding: 0.5rem 1rem;
            background: #10b981;
            color: white;
            text-decoration: none;
            border-radius: 8px;
            font-size: 0.9rem;
            font-weight: 600;
            transition: 0.3s ease;
        }

        .back-btn:hover {
            background: #059669;
            transform: translateY(-2px);
        }

        .msg {
            background: #ecfdf5;
            border-left: 4px solid #10b981;
            padding: 0.75rem 1rem;
            margin-bottom: 1rem;
            border-radius: 6px;
            color: #065f46;
            font-size: 0.95rem;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 1rem;
            font-size: 0.95rem;
        }

        th, td {
            padding: 0.9rem;
            text-align: center;
            border-bottom: 1px solid #e5e7eb;
        }

        th {
            background: #f0fdf4;
            color: #047857;
            font-weight: 600;
            font-size: 1rem;
        }

        tr:hover {
            background: #f9fafb;
            transition: 0.2s;
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
            .card {
                padding: 1rem;
            }
            table {
                font-size: 0.85rem;
            }
            th, td {
                padding: 0.6rem;
            }
        }
    </style>
</head>
<body>
    <div class="page-container">
        <header>
            <div class="header-content">
                <div class="logo"><span class="logo-icon">🌞</span> GreenWatt</div>
                <a href="login/resident-login.jsp" class="logout-btn">Logout</a>
            </div>
        </header>

        <main>
            <div class="card">
                <h3>My Applications</h3>

                <!-- Back to Home Button -->
                <a href="${pageContext.request.contextPath}/resident/dashboard.jsp" class="back-btn">⬅ Back to Dashboard</a>

                
                <c:if test="${param.msg!=null}">
                    <div class="msg">${param.msg}</div>
                </c:if>

                <%
                 if (request.getAttribute("apps")==null) {
                   request.getRequestDispatcher("../ResidentApplications").forward(request, response);
                   return;
                 }
                %>

                <table>
                    <tr>
                        <th>ID</th>
                        <th>Type</th>
                        <th>kW</th>
                        <th>Date</th>
                        <th>Status</th>
                    </tr>
                    <c:forEach items="${apps}" var="a">
                        <tr>
                            <td>${a.id}</td>
                            <td>${a.systemType}</td>
                            <td>${a.capacityKW}</td>
                            <td>${a.requestDate}</td>
                            <td>
                                <span style="
                                    padding: 0.3rem 0.6rem;
                                    border-radius: 6px;
                                    font-size: 0.85rem;
                                    font-weight: 600;
                                    background: ${a.status == 'Approved' ? '#dcfce7' : (a.status == 'Pending' ? '#fef9c3' : '#fee2e2')};
                                    color: ${a.status == 'Approved' ? '#166534' : (a.status == 'Pending' ? '#854d0e' : '#991b1b')};
                                ">
                                    ${a.status}
                                </span>
                            </td>
                        </tr>
                    </c:forEach>
                </table>
            </div>
        </main>

        <footer>
            <p>&copy; 2024 GreenWatt Solar. Empowering sustainable energy solutions.</p>
        </footer>
    </div>
</body>
</html>
