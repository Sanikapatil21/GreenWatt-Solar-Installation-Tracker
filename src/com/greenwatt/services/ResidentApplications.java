package com.greenwatt.services;

import javax.servlet.*; import javax.servlet.http.*; import java.io.*; import java.sql.*;
import java.util.*;

public class ResidentApplications extends HttpServlet {
  protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws IOException, ServletException {
    Integer residentId = (Integer) req.getSession().getAttribute("residentId");
    if (residentId == null) { resp.sendRedirect("../login/resident-login.jsp"); return; }
    List<Map<String,Object>> rows = new ArrayList<>();
    try (Connection con=DBConnection.getConnection();
      PreparedStatement ps=con.prepareStatement(
       "SELECT id,systemType,capacityKW,requestDate,status FROM installation_requests WHERE residentId=? ORDER BY id DESC")) {
      ps.setInt(1, residentId);
      try (ResultSet rs=ps.executeQuery()) {
        while(rs.next()){
          Map<String,Object> m=new HashMap<>();
          m.put("id", rs.getInt("id"));
          m.put("systemType", rs.getString("systemType"));
          m.put("capacityKW", rs.getString("capacityKW"));
          m.put("requestDate", rs.getDate("requestDate"));
          m.put("status", rs.getString("status"));
          rows.add(m);
        }
      }
    } catch(SQLException e){ throw new ServletException(e); }
    req.setAttribute("apps", rows);
    req.getRequestDispatcher("resident/applications.jsp").forward(req, resp);
  }
}
