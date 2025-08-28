<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%> 
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Subsidy Reports - GreenWatt</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;600;700&family=Poppins:wght@500;700&display=swap" rel="stylesheet">
    <style>
        *{ margin: 0; padding: 0; box-sizing: border-box; }
        body {
            font-family: 'Inter', sans-serif;
            background: #f9fafb;
            color: #1a1a1a;
        }
        .container {
            max-width: 1200px;
            margin: 3rem auto;
            padding: 2rem;
            background: #ffffff;
            border-radius: 1rem;
            box-shadow: 0 8px 25px rgba(0,0,0,0.1);
        }
        h2 {
            font-family: 'Poppins', sans-serif;
            font-size: 2rem;
            font-weight: 700;
            text-align: center;
            margin-bottom: 2rem;
            background: linear-gradient(135deg, #22c55e, #3b82f6);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            overflow: hidden;
            border-radius: 0.75rem;
            box-shadow: 0 4px 15px rgba(34,197,94,0.1);
        }
        th {
            background: linear-gradient(135deg, #22c55e, #3b82f6);
            color: white;
            padding: 1rem;
            font-size: 1rem;
            text-align: left;
        }
        td {
            padding: 0.9rem 1rem;
            border-bottom: 1px solid #e5e7eb;
            font-size: 0.95rem;
        }
        tr:nth-child(even) td {
            background: #f9fafb;
        }
        tr:hover td {
            background: #ecfdf5;
        }
        .back-link {
            display: inline-block;
            margin-top: 2rem;
            text-decoration: none;
            font-weight: 600;
            font-size: 0.95rem;
            color: #fff;
            background: linear-gradient(135deg, #22c55e, #3b82f6);
            padding: 0.7rem 1.5rem;
            border-radius: 0.5rem;
            transition: all 0.3s ease;
        }
        .back-link:hover {
            box-shadow: 0 0 15px rgba(59,130,246,0.4);
            transform: translateY(-2px);
        }
        /* Responsive */
        @media (max-width: 768px) {
            .container {
                margin: 2rem 1rem;
                padding: 1.5rem;
            }
            th, td {
                padding: 0.7rem 0.5rem;
                font-size: 0.85rem;
            }
        }
        @media (max-width: 480px) {
            h2 { font-size: 1.5rem; }
        }
    </style>
</head>
<body>
    <div class="container">
        <h2>Subsidy Reports</h2>

        <c:if test="${empty rows}">
            <p style="text-align:center; color:gray; font-size:1rem;">No records found.</p>
        </c:if>

        <c:if test="${not empty rows}">
            <table>
                <tr>
                    <th>Installation ID</th>
                    <th>Resident</th>
                    <th>Installer</th>
                    <th>System Cost</th>
                    <th>Subsidy Approved</th>
                    <th>Install Date</th>
                </tr>
                <c:forEach items="${rows}" var="x">
                    <tr>
                        <td>${x.installationId}</td>
                        <td>${x.resident}</td>
                        <td>${x.installer}</td>
                        <td><c:out value="${x.systemCost}" default="0.00"/></td>
                        <td>${x.subsidyApproved}</td>
                        <td><c:out value="${x.installDate}" default="N/A"/></td>
                    </tr>
                </c:forEach>
            </table>
        </c:if>

        <a href="admin/dashboard.jsp" class="back-link">← Back to Dashboard</a>

    </div>
</body>
</html>
