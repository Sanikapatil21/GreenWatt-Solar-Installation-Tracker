package com.greenwatt.services;

import java.sql.*;

public class DBConnection {
    public static Connection con = null;

    public static Connection getConnection() {
        try {
            if (con == null || con.isClosed()) {
                Class.forName("com.mysql.jdbc.Driver");
                con = DriverManager.getConnection(
                        "jdbc:mysql://localhost:3306/solarDB",
                        "root",
                        ""
                );
                System.out.println(" Connection Established - " + con);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return con;
    }
}