package com.greenwatt.services;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.*;
import java.sql.*;
import java.util.*;

public class SubsidyReports extends HttpServlet {

    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws IOException, ServletException {
        List<Map<String, Object>> rows = new ArrayList<>();

        String sql = "SELECT r.id AS installationId, " +
                     "res.name AS resident, " +
                     "COALESCE(ins.name, 'Not Assigned') AS installer, " +
                     "inst.systemCost, inst.subsidyApproved, inst.installDate " +
                     "FROM installation_requests r " +
                     "JOIN resident res ON res.id = r.residentId " +
                     "LEFT JOIN installations inst ON inst.requestId = r.id " +
                     "LEFT JOIN installer ins ON ins.id = inst.installerId " +
                     "WHERE r.status = 'Approved' " +
                     "ORDER BY r.id DESC";

        try (Connection con = DBConnection.getConnection();
             Statement st = con.createStatement();
             ResultSet rs = st.executeQuery(sql)) {

            while (rs.next()) {
                Map<String, Object> m = new HashMap<>();
                m.put("installationId", rs.getInt("installationId"));
                m.put("resident", rs.getString("resident"));
                m.put("installer", rs.getString("installer"));
                m.put("systemCost", rs.getObject("systemCost")); // may be null
                m.put("subsidyApproved", rs.getString("subsidyApproved") != null ? rs.getString("subsidyApproved") : "Pending");
                m.put("installDate", rs.getDate("installDate")); // may be null
                rows.add(m);
            }

        } catch (SQLException e) {
            throw new ServletException(e);
        }

        req.setAttribute("rows", rows);
        req.getRequestDispatcher("/admin/reports.jsp").forward(req, resp);
    }
}
