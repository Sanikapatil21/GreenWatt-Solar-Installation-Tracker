<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Add Report - Installer | GreenWatt</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <style>
        body {
            margin: 0;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(135deg, rgba(22,163,74,0.05), rgba(5,150,105,0.05));
            min-height: 100vh;
        }

        .page-container {
            max-width: 1000px;
            margin: 0 auto;
            min-height: 100vh;
            display: flex;
            flex-direction: column;
        }

        header {
            background: linear-gradient(135deg, #22c55e, #16a34a);
            padding: 1.5rem 2rem;
            box-shadow: 0 4px 20px rgba(22,163,74,0.25);
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
            background: rgba(255,255,255,0.3);
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
            padding: 2rem;
            border-radius: 16px;
            box-shadow: 0 10px 30px rgba(22,163,74,0.15);
            border: 2px solid rgba(22,163,74,0.1);
            width: 100%;
            max-width: 700px;
            transition: all 0.3s ease;
        }

        .card h3 {
            font-size: 2rem;
            color: #065f46;
            margin-bottom: 1rem;
            text-align: center;
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

        form {
            display: flex;
            flex-direction: column;
            gap: 1rem;
        }

        label {
            font-weight: 600;
            color: #374151;
        }

        input, select {
            padding: 0.7rem 1rem;
            border-radius: 8px;
            border: 1px solid #d1d5db;
            font-size: 1rem;
            transition: border-color 0.2s ease;
        }

        input:focus, select:focus {
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
        }

        button:hover {
            background: linear-gradient(135deg, #16a34a, #15803d);
            transform: translateY(-2px);
            box-shadow: 0 6px 20px rgba(22,163,74,0.4);
        }

        .back-btn {
            display: inline-block;
            margin-bottom: 1rem;
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
            box-shadow: 0 4px 15px rgba(22,163,74,0.3);
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
            .card {
                padding: 1.5rem;
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
            <div class="card">
                <h3>Add Report</h3>

                <!-- Back to Dashboard button -->
                <a href="${pageContext.request.contextPath}/installer/dashboard.jsp" class="back-btn">⬅ Back to Dashboard</a>


                <c:if test="${not empty sessionScope.message}">
                    <div class="msg">${sessionScope.message}</div>
                    <c:remove var="message" scope="session"/>
                </c:if>

                <%
                  if (request.getAttribute("installs") == null) {
                    request.getRequestDispatcher("../AddReport").forward(request, response);
                    return;
                  }
                %>

                <c:choose>
                  <c:when test="${empty installs}">
                    <p style="color:gray; text-align:center;">No completed installations found for you yet.</p>
                  </c:when>
                  <c:otherwise>
                    <form method="post" action="${pageContext.request.contextPath}/AddReport">
                      <label>Installation:</label>
                      <select name="installationId" required>
                        <c:forEach var="i" items="${installs}">
                          <option value="${i.installationId}">
                            #${i.installationId} — ${i.resident} (${i.systemType}, ${i.capacityKW} kW)
                          </option>
                        </c:forEach>
                      </select>

                      <label>Power Generated (kWh):</label>
                      <input type="number" step="0.01" name="powerGenerated" required />

                      <label>Report Date (optional):</label>
                      <input type="date" name="reportDate"/>

                      <label>Maintenance Notes:</label>
                      <input type="text" name="maintenanceNotes" maxlength="255" />

                      <button type="submit">Save Report</button>
                    </form>
                  </c:otherwise>
                </c:choose>
            </div>
        </main>

        <footer>
            <p>&copy; 2024 GreenWatt Solar. Empowering sustainable energy solutions.</p>
        </footer>
    </div>
</body>
</html>
