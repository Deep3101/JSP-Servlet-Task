package com.webapp.util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBConnection {
    private static Connection con;
    public static Connection getConnection() throws ClassNotFoundException, SQLException {
        Class.forName("com.mysql.cj.jdbc.Driver");
        try {
            con = DriverManager.getConnection("jdbc:mysql://localhost:3306/users?ServerTimezone=UTC","root","Deep@3102001");
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return con;
    }
}
