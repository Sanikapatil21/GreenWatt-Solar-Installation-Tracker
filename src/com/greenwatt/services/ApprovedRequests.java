package com.greenwatt.services;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.*;
import java.sql.*;
import java.util.*;

public class ApprovedRequests extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws IOException, ServletException {
        Integer installerId = (Integer) req.getSession().getAttribute("installerId");
        if (installerId == null) {
            resp.sendRedirect("../login/installer-login.jsp");
            return;
        }

        List<Map<String,Object>> list = new ArrayList<>();

        try (Connection con = DBConnection.getConnection()) {
            // ✅ Get only APPROVED requests that do not yet have an installation
            String sql = "SELECT r.id, r.residentId, res.name AS resident, r.systemType, r.capacityKW, r.requestDate " +
                         "FROM installation_requests r " +
                         "JOIN resident res ON res.id = r.residentId " +
                         "WHERE r.status='Approved' " +
                         "AND NOT EXISTS (SELECT 1 FROM installations i WHERE i.requestId = r.id)";
            try (PreparedStatement ps = con.prepareStatement(sql);
                 ResultSet rs = ps.executeQuery()) {

                while (rs.next()) {
                    Map<String,Object> m = new HashMap<>();
                    m.put("id", rs.getInt("id"));
                    m.put("resident", rs.getString("resident"));
                    m.put("systemType", rs.getString("systemType"));
                    m.put("capacityKW", rs.getDouble("capacityKW"));
                    m.put("requestDate", rs.getDate("requestDate"));
                    list.add(m);
                }
            }
        } catch (SQLException e) {
            throw new ServletException("Error fetching approved requests", e);
        }

        req.setAttribute("approved", list);
        req.getRequestDispatcher("/installer/approved-requests.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException, ServletException {
        Integer installerId = (Integer) req.getSession().getAttribute("installerId");
        if (installerId == null) {
            resp.sendRedirect("../login/installer-login.jsp");
            return;
        }

        int requestId = Integer.parseInt(req.getParameter("requestId"));

        try (Connection con = DBConnection.getConnection()) {
            int installationId = 0;

            // 1️⃣ Create installation assigned to this installer
            try (PreparedStatement ps = con.prepareStatement(
                    "INSERT INTO installations (requestId, installerId, installDate, systemCost, subsidyApproved, remarks) " +
                    "VALUES (?, ?, CURDATE(), ?, ?, ?)", Statement.RETURN_GENERATED_KEYS)) {

                ps.setInt(1, requestId);
                ps.setInt(2, installerId);
                ps.setDouble(3, 50000.0);         // default cost
                ps.setString(4, "Pending");       // subsidy status
                ps.setString(5, "Installation created by installer");
                ps.executeUpdate();

                try (ResultSet rsGen = ps.getGeneratedKeys()) {
                    if (rsGen.next()) {
                        installationId = rsGen.getInt(1);
                    }
                }
            }

            // 2️⃣ Insert initial report row
            if (installationId > 0) {
                try (PreparedStatement ps = con.prepareStatement(
                        "INSERT INTO reports (installationId, powerGenerated, reportDate, maintenanceNotes) " +
                        "VALUES (?, 0, CURDATE(), 'Initial report created')")) {
                    ps.setInt(1, installationId);
                    ps.executeUpdate();
                }
            }

        } catch (SQLException e) {
            throw new ServletException("Error creating installation", e);
        }

        // 3️⃣ Set success message and refresh page
        HttpSession session = req.getSession();
        session.setAttribute("message", "Installation created successfully!");
        resp.sendRedirect(req.getContextPath() + "/ApprovedRequests");
    }
}
