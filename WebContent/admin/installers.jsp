<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.*" %> 
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Manage Installers - GreenWatt</title>
    <style>
        body{
            margin: 0;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(135deg, #22c55e, #16a34a);
            color: #1f2937;
        }

        .container {
            max-width: 1000px;
            margin: 2rem auto;
            background: #ffffff;
            padding: 2rem;
            border-radius: 16px;
            box-shadow: 0 10px 30px rgba(22, 163, 74, 0.2);
        }

        h3 {
            text-align: center;
            color: #166534;
            font-size: 1.8rem;
            margin-bottom: 2rem;
        }

        form {
            display: flex;
            flex-wrap: wrap;
            gap: 1rem;
            justify-content: center;
            margin-bottom: 2rem;
        }

        form input {
            flex: 1 1 200px;
            padding: 0.8rem 1rem;
            border: 2px solid #d1d5db;
            border-radius: 8px;
            font-size: 0.95rem;
            transition: border 0.3s;
        }

        form input:focus {
            border-color: #16a34a;
            outline: none;
            box-shadow: 0 0 0 3px rgba(34, 197, 94, 0.2);
        }

        form button {
            padding: 0.8rem 1.5rem;
            background: linear-gradient(135deg, #22c55e, #16a34a);
            color: white;
            border: none;
            border-radius: 8px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
        }

        form button:hover {
            background: linear-gradient(135deg, #15803d, #166534);
            transform: translateY(-2px);
            box-shadow: 0 6px 20px rgba(22, 163, 74, 0.3);
        }

        hr {
            margin: 2rem 0;
            border: none;
            height: 2px;
            background: rgba(34, 197, 94, 0.2);
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 1.5rem;
            border-radius: 12px;
            overflow: hidden;
            box-shadow: 0 4px 15px rgba(22, 163, 74, 0.1);
        }

        table th {
            background: linear-gradient(135deg, #22c55e, #16a34a);
            color: white;
            padding: 1rem;
            text-align: left;
            font-size: 1rem;
        }

        table td {
            padding: 0.9rem 1rem;
            border-bottom: 1px solid #e5e7eb;
        }

        table tr:hover td {
            background: #f0fdf4;
        }

        table form {
            margin: 0;
        }

        table button {
            background: #ef4444;
            color: white;
            border: none;
            padding: 0.5rem 1rem;
            border-radius: 6px;
            font-size: 0.9rem;
            cursor: pointer;
            transition: all 0.3s ease;
        }

        table button:hover {
            background: #dc2626;
            transform: translateY(-1px);
        }

        .back-link {
            display: inline-block;
            margin-top: 1.5rem;
            text-decoration: none;
            font-weight: 600;
            color: #16a34a;
            padding: 0.7rem 1.2rem;
            border: 2px solid #16a34a;
            border-radius: 8px;
            transition: all 0.3s ease;
        }

        .back-link:hover {
            background: #16a34a;
            color: white;
            box-shadow: 0 5px 15px rgba(22, 163, 74, 0.3);
        }
    </style>
</head>
<body>
    <div class="container">
        <h3>Installers</h3>

        <form method="post" action="../InstallerCRUD">
            <input type="hidden" name="action" value="add">
            <input name="name" placeholder="Name" required>
            <input name="licenseNo" placeholder="License No" required>
            <input name="email" placeholder="Email" required>
            <input name="password" type="password" placeholder="Password" required>
            <button type="submit">Add Installer</button>
        </form>

        <hr/>

        <%
          // When this page is opened directly, ask servlet to supply data
          if (request.getAttribute("installers")==null) {
            request.getRequestDispatcher("../InstallerCRUD").forward(request, response);
            return;
          }
        %>

        <table>
          <tr><th>ID</th><th>Name</th><th>License</th><th>Email</th><th>Action</th></tr>
          <c:forEach items="${installers}" var="i">
            <tr>
              <td>${i.id}</td><td>${i.name}</td><td>${i.licenseNo}</td><td>${i.email}</td>
              <td>
                <form method="post" action="../InstallerCRUD" style="display:inline">
                  <input type="hidden" name="action" value="delete"/>
                  <input type="hidden" name="id" value="${i.id}"/>
                  <button type="submit">Delete</button>
                </form>
              </td>
            </tr>
          </c:forEach>
        </table>

        <a href="dashboard.jsp" class="back-link">← Back to Dashboard</a>
    </div>
</body>
</html>
