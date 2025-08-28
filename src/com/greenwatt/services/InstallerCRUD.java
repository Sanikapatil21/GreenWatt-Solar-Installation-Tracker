package com.greenwatt.services;

import javax.servlet.*; import javax.servlet.http.*; import java.io.*; import java.sql.*; import java.util.*;

public class InstallerCRUD extends HttpServlet {
  protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException, ServletException {
    String action = req.getParameter("action");
    try (Connection con=DBConnection.getConnection()) {
      if ("add".equals(action)) {
        try (PreparedStatement ps=con.prepareStatement(
          "INSERT INTO installer(name,licenseNo,email,password) VALUES(?,?,?,?)")) {
          ps.setString(1, req.getParameter("name"));
          ps.setString(2, req.getParameter("licenseNo"));
          ps.setString(3, req.getParameter("email"));
          ps.setString(4, req.getParameter("password"));
          ps.executeUpdate();
        }
      } else if ("delete".equals(action)) {
        try (PreparedStatement ps=con.prepareStatement("DELETE FROM installer WHERE id=?")) {
          ps.setInt(1, Integer.parseInt(req.getParameter("id"))); ps.executeUpdate();
        }
      }
    } catch(SQLException e){ throw new ServletException(e); }
    resp.sendRedirect("admin/installers.jsp");
  }

  protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws IOException, ServletException {
    List<Map<String,Object>> list=new ArrayList<>();
    try (Connection con=DBConnection.getConnection();
         Statement st=con.createStatement();
         ResultSet rs=st.executeQuery("SELECT id,name,licenseNo,email FROM installer ORDER BY id DESC")) {
      while(rs.next()){
        Map<String,Object> m=new HashMap<>();
        m.put("id", rs.getInt("id"));
        m.put("name", rs.getString("name"));
        m.put("licenseNo", rs.getString("licenseNo"));
        m.put("email", rs.getString("email"));
        list.add(m);
      }
    } catch(SQLException e){ throw new ServletException(e); }
    req.setAttribute("installers", list);
    req.getRequestDispatcher("admin/installers.jsp").forward(req, resp);
  }
}
