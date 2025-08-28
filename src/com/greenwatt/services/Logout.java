package com.greenwatt.services;

import javax.servlet.*; import javax.servlet.http.*; import java.io.*;

public class Logout extends HttpServlet {
  protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws IOException {
    HttpSession s = req.getSession(false);
    if (s!=null) s.invalidate();
    resp.sendRedirect("index.jsp");
  }
}
