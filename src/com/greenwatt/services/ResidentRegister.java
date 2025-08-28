package com.greenwatt.services;


import javax.servlet.*; import javax.servlet.http.*; import java.io.*; import java.sql.*;

public class ResidentRegister extends HttpServlet {
  protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException, ServletException {
    String name=req.getParameter("name"), address=req.getParameter("address"),
           email=req.getParameter("email"), aadhaar=req.getParameter("aadhaar"),
           password=req.getParameter("password");
    try (Connection con=DBConnection.getConnection();
         PreparedStatement ps=con.prepareStatement(
          "INSERT INTO resident(name,address,email,aadhaar,password) VALUES(?,?,?,?,?)")) {
      ps.setString(1,name); ps.setString(2,address); ps.setString(3,email);
      ps.setString(4,aadhaar); ps.setString(5,password);
      ps.executeUpdate();
      req.setAttribute("msg","Registration successful. Please login.");
      req.getRequestDispatcher("login/resident-login.jsp").forward(req, resp);
    } catch(SQLException e){ throw new ServletException(e); }
  }
}
