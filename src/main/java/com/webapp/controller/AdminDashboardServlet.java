package com.webapp.controller;

import com.webapp.dao.UserDAO;
import com.webapp.model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class AdminDashboardServlet extends HttpServlet {
    private UserDAO userDAO;

    @Override
    public void init() throws ServletException {
        super.init();
        userDAO = new UserDAO();
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();
        String username = (String) session.getAttribute("username");
        String role = (String) session.getAttribute("role");

        if (username != null && "ADMIN".equalsIgnoreCase(role)) {
            try {
                // Retrieve user data using the UserDAO
                List<User> userList = userDAO.getAllUsers();

                // Filter users to exclude those with "ADMIN" role
                List<User> filteredUserList = new ArrayList<>();
                for (User user : userList) {
                    if (!"ADMIN".equalsIgnoreCase(user.getRole())) {
                        filteredUserList.add(user);
                    }
                }

                // Set the filtered list of users as an attribute to be used in the JSP
                req.setAttribute("userList", filteredUserList);

                // Forward the request to the admin dashboard JSP
                req.getRequestDispatcher("adminDashboard.jsp").forward(req, resp);
            } catch (SQLException | ClassNotFoundException e) {
                throw new ServletException("Error fetching user data from the database", e);
            }
        } else {
            // Redirect regular users to their dashboard
            resp.sendRedirect("UserDashboardServlet");
        }
    }
}
