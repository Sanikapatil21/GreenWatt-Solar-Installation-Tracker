package com.greenwatt.services;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.*;
import java.sql.*;
import java.util.*;

public class AddReport extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws IOException, ServletException {
        Integer installerId = (Integer) req.getSession().getAttribute("installerId");
        if (installerId == null) {
            resp.sendRedirect(req.getContextPath() + "/login/installer-login.jsp");
            return;
        }

        // Load only this installer's COMPLETED installations (installDate not null)
        String sql = "SELECT inst.id AS installationId, res.name AS resident, r.systemType, r.capacityKW, inst.installDate " +
                     "FROM installations inst " +
                     "JOIN installation_requests r ON r.id = inst.requestId " +
                     "JOIN resident res ON res.id = r.residentId " +
                     "WHERE inst.installerId = ? AND inst.installDate IS NOT NULL " +
                     "ORDER BY inst.id DESC";

        List<Map<String, Object>> installs = new ArrayList<>();
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, installerId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Map<String, Object> m = new HashMap<>();
                    m.put("installationId", rs.getInt("installationId"));
                    m.put("resident", rs.getString("resident"));
                    m.put("systemType", rs.getString("systemType"));
                    m.put("capacityKW", rs.getDouble("capacityKW"));
                    m.put("installDate", rs.getDate("installDate"));
                    installs.add(m);
                }
            }
        } catch (SQLException e) {
            throw new ServletException(e);
        }

        req.setAttribute("installs", installs);
        req.getRequestDispatcher("/installer/add-report.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException, ServletException {
        Integer installerId = (Integer) req.getSession().getAttribute("installerId");
        if (installerId == null) {
            resp.sendRedirect(req.getContextPath() + "/login/installer-login.jsp");
            return;
        }

        int installationId = Integer.parseInt(req.getParameter("installationId"));
        double powerGenerated = Double.parseDouble(req.getParameter("powerGenerated"));
        String reportDate = req.getParameter("reportDate"); // yyyy-mm-dd (optional)
        String notes = req.getParameter("maintenanceNotes");

        String sql = (reportDate == null || reportDate.trim().isEmpty())
                ? "INSERT INTO reports (installationId, powerGenerated, reportDate, maintenanceNotes) VALUES (?, ?, CURDATE(), ?)"
                : "INSERT INTO reports (installationId, powerGenerated, reportDate, maintenanceNotes) VALUES (?, ?, ?, ?)";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, installationId);
            ps.setDouble(2, powerGenerated);
            if (reportDate == null || reportDate.trim().isEmpty()) {
                ps.setString(3, notes);
            } else {
                ps.setDate(3, java.sql.Date.valueOf(reportDate));
                ps.setString(4, notes);
            }
            ps.executeUpdate();
        } catch (SQLException e) {
            throw new ServletException(e);
        }

        req.getSession().setAttribute("message", "Report added successfully.");
        resp.sendRedirect(req.getContextPath() + "/AddReport");
    }
}
