package com.webapp.controller;

import com.webapp.dao.UserDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;


public class DeleteUserServlet extends HttpServlet {
    private UserDAO userDAO;

    public void init() {
        userDAO = new UserDAO();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Get the user ID to delete from the request parameter
        int userId = Integer.parseInt(request.getParameter("userId"));

        // Call the DAO method to delete the user
        boolean deleted = userDAO.deleteUser(userId);

        if (deleted) {
            // User was deleted successfully
            response.sendRedirect(request.getContextPath() + "/AdminDashboardServlet?userId=" +userId);
        } else {
            // Handle the case where the user deletion failed (e.g., user not found)
            response.getWriter().println("Failed to delete user.");
        }
    }
}
