<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%> 
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Installation Requests - GreenWatt</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;600;700&family=Poppins:wght@500;700&display=swap" rel="stylesheet">
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }

        body {
            font-family: 'Inter', sans-serif;
            background: #f9fafb;
            color: #1a1a1a;
        }

        .container {
            max-width: 1100px;
            margin: 3rem auto;
            padding: 2rem;
            background: #ffffff;
            border-radius: 1rem;
            box-shadow: 0 8px 25px rgba(0,0,0,0.1);
        }

        h3 {
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

        button {
            padding: 0.5rem 1rem;
            border: none;
            border-radius: 0.5rem;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
            color: #fff;
        }

        button[type="submit"] {
            margin: 0 0.25rem;
        }

        form {
            display: inline-block;
        }

        /* Approve Button */
        form input[value="Approved"] + button {
            background: linear-gradient(135deg, #22c55e, #16a34a);
        }

        form input[value="Approved"] + button:hover {
            box-shadow: 0 0 15px rgba(34,197,94,0.4);
            transform: translateY(-2px);
        }

        /* Reject Button */
        form input[value="Rejected"] + button {
            background: linear-gradient(135deg, #ef4444, #b91c1c);
        }

        form input[value="Rejected"] + button:hover {
            box-shadow: 0 0 15px rgba(239,68,68,0.4);
            transform: translateY(-2px);
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
    </style>
</head>
<body>
    <div class="container">
        <h3>Installation Requests</h3>

        <%
         if (request.getAttribute("requests") == null) {
           request.getRequestDispatcher("/RequestApproval").forward(request, response);
           return;
         }
        %>

        <table>
            <tr>
              <th>ID</th><th>Resident</th><th>Type</th><th>kW</th><th>Date</th><th>Status</th><th>Action</th>
            </tr>
            <c:forEach items="${requests}" var="r">
            <tr>
              <td>${r.id}</td>
              <td>${r.resident}</td>
              <td>${r.systemType}</td>
              <td>${r.capacityKW}</td>
              <td>${r.requestDate}</td>
              <td>${r.status}</td>
              <td>
                <form method="post" action="${pageContext.request.contextPath}/RequestApproval">
                  <input type="hidden" name="id" value="${r.id}"/>
                  <input type="hidden" name="status" value="Approved"/>
                  <button type="submit">Approve</button>
                </form>
                <form method="post" action="${pageContext.request.contextPath}/RequestApproval">
                  <input type="hidden" name="id" value="${r.id}"/>
                  <input type="hidden" name="status" value="Rejected"/>
                  <button type="submit">Reject</button>
                </form>
              </td>
            </tr>
            </c:forEach>
        </table>

        <a href="admin/dashboard.jsp" class="back-link">← Back to Dashboard</a>
    </div>
</body>
</html>
