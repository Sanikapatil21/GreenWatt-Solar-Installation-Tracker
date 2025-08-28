package com.greenwatt.services;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.WebServlet;
import java.io.*;
import java.sql.*;


public class ResidentLogin extends HttpServlet {

    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException, ServletException {
        String email = req.getParameter("email");
        String password = req.getParameter("password");

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(
                     "SELECT id, name FROM resident WHERE email=? AND password=?")) {

            ps.setString(1, email);
            ps.setString(2, password);

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    HttpSession session = req.getSession();
                    session.setAttribute("role", "RESIDENT");
                    session.setAttribute("residentId", rs.getInt("id"));
                    session.setAttribute("residentName", rs.getString("name"));

                    // Redirect to resident dashboard
                    resp.sendRedirect(req.getContextPath() + "/resident/dashboard.jsp");
                } else {
                    // Invalid login: show error on login page
                    req.setAttribute("msg", "Invalid Login");
                    req.getRequestDispatcher("/login/resident-login.jsp").forward(req, resp);
                }
            }

        } catch (SQLException e) {
            throw new ServletException(e);
        }
    }

    // Optional: handle GET to show login page
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.getRequestDispatcher("/login/resident-login.jsp").forward(req, resp);
    }
}
