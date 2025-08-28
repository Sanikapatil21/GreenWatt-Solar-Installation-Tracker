package com.greenwatt.services;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.*;
import java.sql.*;
import java.util.*;

public class InstallerReports extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws IOException, ServletException {
        Integer installerId = (Integer) req.getSession().getAttribute("installerId");
        if (installerId == null) {
            resp.sendRedirect(req.getContextPath() + "/login/installer-login.jsp");
            return;
        }

        String sql = "SELECT rep.id AS reportId, rep.installationId, rep.powerGenerated, rep.reportDate, rep.maintenanceNotes, " +
                     "res.name AS resident, r.systemType, r.capacityKW " +
                     "FROM reports rep " +
                     "JOIN installations inst ON inst.id = rep.installationId " +
                     "JOIN installation_requests r ON r.id = inst.requestId " +
                     "JOIN resident res ON res.id = r.residentId " +
                     "WHERE inst.installerId = ? " +
                     "ORDER BY rep.id DESC";

        List<Map<String, Object>> rows = new ArrayList<>();
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, installerId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Map<String, Object> m = new HashMap<>();
                    m.put("reportId", rs.getInt("reportId"));
                    m.put("installationId", rs.getInt("installationId"));
                    m.put("powerGenerated", rs.getDouble("powerGenerated"));
                    m.put("reportDate", rs.getDate("reportDate"));
                    m.put("maintenanceNotes", rs.getString("maintenanceNotes"));
                    m.put("resident", rs.getString("resident"));
                    m.put("systemType", rs.getString("systemType"));
                    m.put("capacityKW", rs.getDouble("capacityKW"));
                    rows.add(m);
                }
            }
        } catch (SQLException e) {
            throw new ServletException(e);
        }

        req.setAttribute("rows", rows);
        req.getRequestDispatcher("/installer/reports.jsp").forward(req, resp);
    }
}
