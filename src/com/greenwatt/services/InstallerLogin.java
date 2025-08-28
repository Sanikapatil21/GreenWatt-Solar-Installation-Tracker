package com.greenwatt.services;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.*;
import java.sql.*;

public class InstallerLogin extends HttpServlet {

    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException, ServletException {
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(
                     "SELECT id,name FROM installer WHERE email=? AND password=?")) {

            ps.setString(1, req.getParameter("email"));
            ps.setString(2, req.getParameter("password"));

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    HttpSession session = req.getSession();
                    session.setAttribute("role", "INSTALLER");
                    session.setAttribute("installerId", rs.getInt("id"));
                    session.setAttribute("installerName", rs.getString("name"));
                    resp.sendRedirect(req.getContextPath() + "/installer/dashboard.jsp");
                } else {
                    req.setAttribute("msg", "Invalid Login");
                    req.getRequestDispatcher("/login/installer-login.jsp").forward(req, resp);
                }
            }
        } catch (SQLException e) {
            throw new ServletException(e);
        }
    }
}
