<%@ page contentType="text/html;charset=UTF-8" %> 
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>My Reports - Installer | GreenWatt</title>
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
            display: flex;
            flex-direction: column;
            min-height: 100vh;
        }

        header {
            background: linear-gradient(135deg, #22c55e, #16a34a);
            padding: 1.5rem 2rem;
            box-shadow: 0 4px 20px rgba(22,163,74,0.25);
            color: white;
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
            max-width: 950px;
            transition: all 0.3s ease;
        }

        .card h3 {
            font-size: 2rem;
            color: #065f46;
            margin-bottom: 1rem;
            text-align: center;
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

        .download-btn {
            float: right;
            margin-bottom: 1rem;
            padding: 0.5rem 1rem;
            background: #16a34a;
            color: white;
            font-weight: 600;
            border-radius: 8px;
            border: none;
            cursor: pointer;
            transition: all 0.3s ease;
        }

        .download-btn:hover {
            background: #15803d;
            transform: translateY(-2px);
            box-shadow: 0 4px 15px rgba(22,163,74,0.3);
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 0.5rem;
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

        .no-data {
            text-align: center;
            color: gray;
            margin-top: 1rem;
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
            table {
                font-size: 0.85rem;
            }
            th, td {
                padding: 0.6rem;
            }
            .card {
                padding: 1.5rem;
            }
        }
    </style>
    <script>
        function downloadExcel() {
            let table = document.querySelector("table").outerHTML;
            let url = 'data:application/vnd.ms-excel,' + encodeURIComponent(table);
            let a = document.createElement("a");
            a.href = url;
            a.download = "Installer_Reports.xls";
            a.click();
        }
    </script>
</head>
<body>
    <div class="page-container">
        <header>
            <div class="logo"><span class="logo-icon">📄</span> GreenWatt</div>
            <a href="login/installer-login.jsp" class="logout-btn">Logout</a>
        </header>

        <main>
            <div class="card">
                <h3>My Reports</h3>
                <a href="${pageContext.request.contextPath}/installer/dashboard.jsp" class="back-btn">⬅ Back to Dashboard</a>

                <button class="download-btn" onclick="downloadExcel()">Download Excel</button>

                <%
                  if (request.getAttribute("rows") == null) {
                    request.getRequestDispatcher("../InstallerReports").forward(request, response);
                    return;
                  }
                %>

                <c:if test="${empty rows}">
                    <div class="no-data">No reports yet.</div>
                </c:if>

                <c:if test="${not empty rows}">
                    <table>
                        <tr>
                            <th>Report ID</th>
                            <th>Installation</th>
                            <th>Resident</th>
                            <th>System</th>
                            <th>kW</th>
                            <th>Power Generated</th>
                            <th>Report Date</th>
                            <th>Notes</th>
                        </tr>
                        <c:forEach var="r" items="${rows}">
                            <tr>
                                <td>${r.reportId}</td>
                                <td>${r.installationId}</td>
                                <td>${r.resident}</td>
                                <td>${r.systemType}</td>
                                <td>${r.capacityKW}</td>
                                <td>${r.powerGenerated}</td>
                                <td>${r.reportDate}</td>
                                <td>${r.maintenanceNotes}</td>
                            </tr>
                        </c:forEach>
                    </table>
                </c:if>
            </div>
        </main>

        <footer>
            &copy; 2024 GreenWatt Solar. Empowering sustainable energy solutions.
        </footer>
    </div>
</body>
</html>
