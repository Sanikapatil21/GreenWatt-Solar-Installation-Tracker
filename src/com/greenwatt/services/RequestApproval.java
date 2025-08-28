package com.greenwatt.services;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.*;
import java.sql.*;
import java.util.*;

public class RequestApproval extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException, ServletException {
        String status = req.getParameter("status"); // Approved/Rejected
        int reqId = Integer.parseInt(req.getParameter("id"));

        try (Connection con = DBConnection.getConnection()) {
            // 1️⃣ Update request status only
            String sql = "UPDATE installation_requests SET status=? WHERE id=?";
            try (PreparedStatement ps = con.prepareStatement(sql)) {
                ps.setString(1, status);
                ps.setInt(2, reqId);
                ps.executeUpdate();
            }

            // No insertion into installations table anymore

            resp.sendRedirect(req.getContextPath() + "/RequestApproval");

        } catch (SQLException e) {
            throw new ServletException(e);
        }
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws IOException, ServletException {
        List<Map<String, Object>> list = new ArrayList<>();

        String sql = "SELECT r.id, res.name AS resident, r.systemType, r.capacityKW, r.requestDate, r.status " +
                     "FROM installation_requests r " +
                     "JOIN resident res ON res.id = r.residentId " +
                     "ORDER BY r.id DESC";

        try (Connection con = DBConnection.getConnection();
             Statement st = con.createStatement();
             ResultSet rs = st.executeQuery(sql)) {
            while (rs.next()) {
                Map<String, Object> m = new HashMap<>();
                m.put("id", rs.getInt("id"));
                m.put("resident", rs.getString("resident"));
                m.put("systemType", rs.getString("systemType"));
                m.put("capacityKW", rs.getString("capacityKW"));
                m.put("requestDate", rs.getDate("requestDate"));
                m.put("status", rs.getString("status"));
                list.add(m);
            }
        } catch (SQLException e) {
            throw new ServletException(e);
        }

        req.setAttribute("requests", list);
        req.getRequestDispatcher("admin/requests.jsp").forward(req, resp);
    }
}
