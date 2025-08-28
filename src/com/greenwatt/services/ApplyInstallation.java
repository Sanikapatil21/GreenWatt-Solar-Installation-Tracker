package com.greenwatt.services;

import javax.servlet.*; import javax.servlet.http.*; import java.io.*; import java.sql.*; import java.time.*;

public class ApplyInstallation extends HttpServlet {
  protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException, ServletException {
    Integer residentId = (Integer) req.getSession().getAttribute("residentId");
    if (residentId == null) { resp.sendRedirect("login/resident-login.jsp"); return; }
    String systemType=req.getParameter("systemType");
    String capacityKW=req.getParameter("capacityKW");
    try (Connection con=DBConnection.getConnection();
         PreparedStatement ps=con.prepareStatement(
           "INSERT INTO installation_requests(residentId,systemType,capacityKW,requestDate,status) VALUES(?,?,?,?,?)")) {
      ps.setInt(1, residentId);
      ps.setString(2, systemType);
      ps.setString(3, capacityKW);
      ps.setDate(4, java.sql.Date.valueOf(LocalDate.now()));
      ps.setString(5, "Pending");
      ps.executeUpdate();
      resp.sendRedirect("resident/applications.jsp?msg=Applied");
    } catch(SQLException e){ throw new ServletException(e); }
  }
}
