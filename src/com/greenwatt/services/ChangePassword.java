package com.greenwatt.services;

import javax.servlet.*; import javax.servlet.http.*; import java.io.*; import java.sql.*;

public class ChangePassword extends HttpServlet {
  protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException, ServletException {
    Integer installerId = (Integer) req.getSession().getAttribute("installerId");
    if (installerId == null) { resp.sendRedirect("../login/installer-login.jsp"); return; }
    String oldP=req.getParameter("oldPassword"), newP=req.getParameter("newPassword");
    try (Connection con=DBConnection.getConnection()) {
      try (PreparedStatement chk=con.prepareStatement("SELECT id FROM installer WHERE id=? AND password=?")) {
        chk.setInt(1, installerId); chk.setString(2, oldP);
        try (ResultSet rs=chk.executeQuery()) {
          if (!rs.next()) {
            resp.sendRedirect("installer/dashboard.jsp?msg=Wrong+old+password"); return;
          }
        }
      }
      try (PreparedStatement upd=con.prepareStatement("UPDATE installer SET password=? WHERE id=?")) {
        upd.setString(1, newP); upd.setInt(2, installerId); upd.executeUpdate();
      }
    } catch(SQLException e){ throw new ServletException(e); }
    resp.sendRedirect("installer/dashboard.jsp?msg=Password+changed");
  }
}
