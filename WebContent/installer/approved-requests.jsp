<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Approved Requests - Installer | GreenWatt</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <style>
        body {
            margin: 0;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(135deg, rgba(22, 163, 74, 0.05), rgba(5, 150, 105, 0.05));
            min-height: 100vh;
        }

        .page-container {
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
            margin-bottom: 1.5rem;
        }

        .dashboard-title h2 {
            font-size: 2.5rem;
            color: #065f46;
            margin-bottom: 0.5rem;
        }

        .back-btn {
            display: inline-block;
            margin-bottom: 1.5rem;
            padding: 0.5rem 1rem;
            background: linear-gradient(135deg, #22c55e, #16a34a);
            color: white;
            text-decoration: none;
            border-radius: 8px;
            font-weight: 600;
            transition: all 0.3s ease;
        }

        .back-btn:hover {
            background: linear-gradient(135deg, #16a34a, #15803d);
            transform: translateY(-2px);
            box-shadow: 0 4px 15px rgba(22, 163, 74, 0.3);
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

        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 1rem;
            font-size: 0.95rem;
        }

        th, td {
            padding: 0.8rem;
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

        .form-inline {
            display: flex;
            flex-wrap: wrap;
            gap: 0.5rem;
            justify-content: center;
        }

        .form-inline input, .form-inline select {
            padding: 0.5rem;
            border-radius: 8px;
            border: 1px solid #d1d5db;
            font-size: 0.9rem;
        }

        .form-inline button {
            background: linear-gradient(135deg, #22c55e, #16a34a);
            color: white;
            padding: 0.5rem 1rem;
            border: none;
            border-radius: 8px;
            font-size: 0.9rem;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
        }

        .form-inline button:hover {
            background: linear-gradient(135deg, #16a34a, #15803d);
            transform: translateY(-2px);
            box-shadow: 0 4px 15px rgba(22, 163, 74, 0.3);
        }

        footer {
            background: #f0fdf4;
            padding: 1rem;
            text-align: center;
            border-top: 1px solid #d1fae5;
            color: #047857;
            font-size: 0.9rem;
            margin-top: 2rem;
        }

        @media (max-width: 768px) {
            table, th, td {
                font-size: 0.85rem;
                padding: 0.5rem;
            }
            .form-inline {
                flex-direction: column;
            }
        }
    </style>
</head>
<body>
    <div class="page-container">
        <header>
            <div class="header-content">
                <div class="logo"><span class="logo-icon">👷‍♂️</span> GreenWatt</div>
                <a href="login/installer-login.jsp" class="logout-btn">Logout</a>
            </div>
        </header>

        <main>
            <div class="dashboard-title">
                <h2>Approved Installation Requests</h2>
                <p>Take action on approved requests</p>
            </div>

            <!-- Back to Dashboard Button -->
           <a href="${pageContext.request.contextPath}/installer/dashboard.jsp" class="back-btn">⬅ Back to Dashboard</a>


            <c:if test="${not empty sessionScope.message}">
                <div class="msg">${sessionScope.message}</div>
                <c:remove var="message" scope="session"/>
            </c:if>

            <%
               if (request.getAttribute("approved") == null) {
                   request.getRequestDispatcher("../ApprovedRequests").forward(request, response);
                   return;
               }
            %>

            <c:if test="${empty approved}">
                <p style="color: gray; text-align:center;">No approved requests available.</p>
            </c:if>

            <c:if test="${not empty approved}">
                <table>
                    <tr>
                        <th>ID</th>
                        <th>Resident</th>
                        <th>Type</th>
                        <th>kW</th>
                        <th>Date</th>
                        <th>Action</th>
                    </tr>

                    <c:forEach var="req" items="${approved}">
                        <tr>
                            <td>${req.id}</td>
                            <td>${req.resident}</td>
                            <td>${req.systemType}</td>
                            <td>${req.capacityKW}</td>
                            <td>${req.requestDate}</td>
                            <td>
                                <form action="${pageContext.request.contextPath}/CompleteInstallation" method="post" class="form-inline">
                                    <input type="hidden" name="requestId" value="${req.id}" />
                                    <input name="systemCost" placeholder="System Cost" required>
                                    <select name="subsidyApproved">
                                        <option>Yes</option>
                                        <option>No</option>
                                    </select>
                                    <input name="remarks" placeholder="Remarks">
                                    <button type="submit">Mark Complete</button>
                                </form>
                            </td>
                        </tr>
                    </c:forEach>
                </table>
            </c:if>
        </main>

        <footer>
            <p>&copy; 2024 GreenWatt Solar. Empowering sustainable energy solutions.</p>
        </footer>
    </div>
</body>
</html>
