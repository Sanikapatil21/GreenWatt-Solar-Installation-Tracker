package com.greenwatt.services;

import javax.servlet.*; 
import javax.servlet.http.*; 
import java.io.*; 
import java.sql.*;

public class AdminLogin extends HttpServlet {
  protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException, ServletException {
    String email = req.getParameter("email");
    String password = req.getParameter("password");
    try (Connection con = DBConnection.getConnection();
         PreparedStatement ps = con.prepareStatement("SELECT email FROM installer WHERE 1=0")) {
      // Simple hardcoded admin (adjust as needed)
      if ("admin@greenwatt".equalsIgnoreCase(email) && "admin123".equals(password)) {
        req.getSession().setAttribute("role", "ADMIN");
        req.getSession().setAttribute("adminEmail", email);
        resp.sendRedirect("admin/dashboard.jsp");
      } else {
        req.setAttribute("msg", "Invalid admin credentials");
        req.getRequestDispatcher("login/admin-login.jsp").forward(req, resp);
      }
    } catch (SQLException e) { throw new ServletException(e); }
  }
}
