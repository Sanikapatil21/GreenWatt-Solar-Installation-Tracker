<%@ page import="java.sql.*, com.greenwatt.services.DBConnection" %> 
<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Reports - GreenWatt</title>
    <style>
        body {
            margin: 0;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(135deg, rgba(16,185,129,0.08), rgba(5,150,105,0.08));
            min-height: 100vh;
        }
        header {
            background: linear-gradient(135deg, #22c55e, #16a34a);
            padding: 1.2rem 2rem;
            color: white;
            box-shadow: 0 4px 20px rgba(22, 163, 74, 0.3);
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
        header .logo {
            font-size: 1.5rem;
            font-weight: bold;
            display: flex;
            align-items: center;
        }
        header .logo span {
            font-size: 2rem;
            margin-right: 0.6rem;
        }
        header a {
            background: rgba(255, 255, 255, 0.2);
            color: white;
            padding: 0.5rem 1rem;
            border-radius: 8px;
            text-decoration: none;
            font-size: 0.9rem;
            transition: 0.3s;
        }
        header a:hover {
            background: rgba(255, 255, 255, 0.3);
        }

        main {
            padding: 2rem;
        }
        h3 {
            color: #065f46;
            font-size: 1.6rem;
            margin-bottom: 1rem;
        }
        .table-container {
            overflow-x: auto;
            background: #fff;
            padding: 1.5rem;
            border-radius: 12px;
            box-shadow: 0 8px 25px rgba(16, 185, 129, 0.15);
        }
        table {
            width: 100%;
            border-collapse: collapse;
            font-size: 0.95rem;
        }
        th, td {
            padding: 0.75rem;
            text-align: center;
            border: 1px solid #d1d5db;
        }
        th {
            background: #f0fdf4;
            color: #065f46;
        }
        tr:nth-child(even) {
            background: #f9fafb;
        }
        .btn-group {
            margin-bottom: 1rem;
            display: flex;
            gap: 1rem;
        }
        .btn {
            background: linear-gradient(135deg, #22c55e, #16a34a);
            color: white;
            padding: 0.6rem 1.2rem;
            border-radius: 8px;
            border: none;
            cursor: pointer;
            font-weight: 600;
            transition: 0.3s;
        }
        .btn:hover {
            background: linear-gradient(135deg, #16a34a, #15803d);
            transform: translateY(-2px);
        }
        footer {
            text-align: center;
            padding: 1rem;
            margin-top: 2rem;
            background: #f0fdf4;
            border-top: 1px solid #d1fae5;
            color: #047857;
            font-size: 0.9rem;
        }
    </style>
    <script>
        function downloadExcel() {
            let table = document.querySelector("table").outerHTML;
            let url = 'data:application/vnd.ms-excel,' + escape(table);
            let a = document.createElement("a");
            a.href = url;
            a.download = "GreenWatt_Reports.xls";
            a.click();
        }

        function downloadPDF() {
            let content = document.querySelector(".table-container").innerHTML;
            let win = window.open("", "", "width=900,height=700");
            win.document.write("<html><head><title>Reports</title></head><body>");
            win.document.write("<h2>GreenWatt Reports</h2>");
            win.document.write(content);
            win.document.write("</body></html>");
            win.document.close();
            win.print();
        }
    </script>
</head>
<body>
    <header>
        <div class="logo"><span>📊</span> GreenWatt Reports</div>
        <a href="${pageContext.request.contextPath}/resident/dashboard.jsp" class="back-btn">⬅ Back to Dashboard</a>
    </header>
    <main>
        <h3>My Installation & Subsidy Reports</h3>
        <div class="btn-group">
            
            <button class="btn" onclick="downloadExcel()">Download Excel</button>
        </div>
        <div class="table-container">

            <%-- 🔹 Your existing table code remains unchanged below --%>
            <%
            Integer residentId = (Integer) session.getAttribute("residentId");
            if (residentId == null) {
                response.sendRedirect("../login/resident-login.jsp");
                return;
            }

            Connection con = null;
            PreparedStatement ps = null;
            ResultSet rs = null;
            try {
                con = DBConnection.getConnection();
                String sql = "SELECT r.id AS requestId, r.systemType, r.capacityKW, r.requestDate, r.status, " +
                             "inst.id AS installationId, inst.systemCost, inst.subsidyApproved, inst.installDate, " +
                             "rep.id AS reportId, rep.powerGenerated, rep.reportDate, rep.maintenanceNotes " +
                             "FROM installation_requests r " +
                             "LEFT JOIN installations inst ON inst.requestId = r.id " +
                             "LEFT JOIN reports rep ON rep.installationId = inst.id " +
                             "WHERE r.residentId = ? AND r.status='Approved' " +
                             "ORDER BY r.id DESC";
                ps = con.prepareStatement(sql);
                ps.setInt(1, residentId);
                rs = ps.executeQuery();
            %>

            <table>
                <tr>
                    <th>Request ID</th>
                    <th>System Type</th>
                    <th>Capacity (kW)</th>
                    <th>Request Date</th>
                    <th>Status</th>
                    <th>Installation ID</th>
                    <th>System Cost</th>
                    <th>Subsidy Approved</th>
                    <th>Install Date</th>
                    <th>Report ID</th>
                    <th>Power Generated</th>
                    <th>Report Date</th>
                    <th>Maintenance Notes</th>
                </tr>

            <%
            boolean hasData = false;
            while (rs.next()) {
                hasData = true;
            %>
                <tr>
                    <td><%= rs.getInt("requestId") %></td>
                    <td><%= rs.getString("systemType") %></td>
                    <td><%= rs.getString("capacityKW") %></td>
                    <td><%= rs.getDate("requestDate") %></td>
                    <td><%= rs.getString("status") %></td>
                    <td><%= rs.getInt("installationId") != 0 ? rs.getInt("installationId") : "N/A" %></td>
                    <td><%= rs.getDouble("systemCost") != 0 ? rs.getDouble("systemCost") : "N/A" %></td>
                    <td><%= rs.getString("subsidyApproved") != null ? rs.getString("subsidyApproved") : "Pending" %></td>
                    <td><%= rs.getDate("installDate") != null ? rs.getDate("installDate") : "N/A" %></td>
                    <td><%= rs.getInt("reportId") != 0 ? rs.getInt("reportId") : "N/A" %></td>
                    <td><%= rs.getString("powerGenerated") != null ? rs.getString("powerGenerated") : "N/A" %></td>
                    <td><%= rs.getDate("reportDate") != null ? rs.getDate("reportDate") : "N/A" %></td>
                    <td><%= rs.getString("maintenanceNotes") != null ? rs.getString("maintenanceNotes") : "N/A" %></td>
                </tr>
            <%
            }
            if (!hasData) {
            %>
                <tr>
                    <td colspan="13" style="text-align:center; color:gray">No installations or reports found.</td>
                </tr>
            <%
            }
            %>
            </table>

            <%
            } catch(Exception e){
                out.print("Error: " + e.getMessage());
            } finally {
                try { if (rs != null) rs.close(); } catch(Exception e) {}
                try { if (ps != null) ps.close(); } catch(Exception e) {}
                try { if (con != null) con.close(); } catch(Exception e) {}
            }
            %>

        </div>
    </main>
    <footer>
        &copy; 2024 GreenWatt Solar | Reports Portal
    </footer>
</body>
</html>
