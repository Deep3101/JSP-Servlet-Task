package com.webapp.controller;

import com.webapp.util.DBConnection;
import com.webapp.model.User;
import com.webapp.model.Address;
import com.webapp.dao.UserDAO;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

    public class UserDashboardServlet extends HttpServlet {
        private static final String USER_DATA_QUERY = "SELECT user_name , first_name, last_name, email, contact, gender, user_id, role FROM user_login WHERE user_name = ?";

        protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
            HttpSession session = req.getSession();
            String username = (String) session.getAttribute("username");
            String role = (String) session.getAttribute("role");

            if (username != null) {
                try {
                    try (Connection con = DBConnection.getConnection();
                         PreparedStatement preparedStatement = con.prepareStatement(USER_DATA_QUERY)) {

                        preparedStatement.setString(1, username);
                        try (ResultSet rs = preparedStatement.executeQuery()) {
                            if (rs.next()) {
                                // Retrieve basic user details
                                int userId = rs.getInt("user_id");
                                String usernm = rs.getString("user_name");
                                String firstname = rs.getString("first_name");
                                String lastname = rs.getString("last_name");
                                String email = rs.getString("email");
                                String contact = rs.getString("contact");
                                String gender = rs.getString("gender");
                                String userRole = rs.getString("role");

                                // Create a User object to store these details
                                User user = new User();
                                user.setUserName(usernm);
                                user.setUserId(userId);
                                user.setFirstName(firstname);
                                user.setLastName(lastname);
                                user.setEmail(email);
                                user.setContact(contact);
                                user.setGender(gender);
                                user.setRole(userRole);
                                // Store the User object in the session
                                session.setAttribute("user", user);
                            }
                        }

                        int userId;
                        if (!username.equals("")) {
                            userId = UserDAO.getUserIdByUsername(username);
                        } else {
                            userId = Integer.parseInt(req.getParameter("userId"));
                        }
                        List<Address> addresses = UserDAO.fetchUserAddresses(userId);
                        session.setAttribute("addresses", addresses);

                        if ("ADMIN".equals(role)) {
                            // Redirect administrators to the admin dashboard
                            resp.sendRedirect("AdminDashboardServlet");
                        } else {
                            // Forward regular users to their dashboard
                            req.getRequestDispatcher("userDashboard.jsp").forward(req, resp);
                        }
                    }
                } catch (ClassNotFoundException | SQLException e) {
                    throw new ServletException(e);
                }
            } else {
                resp.sendRedirect("login.jsp");
            }
        }
}
