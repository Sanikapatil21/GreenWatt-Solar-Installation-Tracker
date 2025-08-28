package com.greenwatt.services;

import javax.servlet.*; import javax.servlet.http.*; import java.io.*; import java.sql.*; import java.time.*;

public class CompleteInstallation extends HttpServlet {
  protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException, ServletException {
    Integer installerId = (Integer) req.getSession().getAttribute("installerId");
    if (installerId == null) { resp.sendRedirect("../login/installer-login.jsp"); return; }
    int requestId = Integer.parseInt(req.getParameter("requestId"));
    String systemCost = req.getParameter("systemCost");
    String subsidyApproved = req.getParameter("subsidyApproved"); // Yes/No
    String remarks = req.getParameter("remarks");
    try (Connection con=DBConnection.getConnection();
         PreparedStatement ps=con.prepareStatement(
           "INSERT INTO installations(requestId, installerId, installDate, systemCost, subsidyApproved, remarks) VALUES(?,?,?,?,?,?)")) {
      ps.setInt(1, requestId);
      ps.setInt(2, installerId);
      ps.setDate(3, java.sql.Date.valueOf(LocalDate.now()));
      ps.setBigDecimal(4, new java.math.BigDecimal(systemCost));
      ps.setString(5, subsidyApproved);
      ps.setString(6, remarks);
      ps.executeUpdate();
    } catch(SQLException e){ throw new ServletException(e); }

    // Optionally, mark request as Completed (custom state) or keep Approved
    resp.sendRedirect("installer/approved-requests.jsp?msg=Completed");
  }
}
