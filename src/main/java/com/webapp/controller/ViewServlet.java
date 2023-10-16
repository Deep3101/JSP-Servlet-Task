package com.webapp.controller;

import com.webapp.dao.UserDAO;
import com.webapp.model.Address;
import com.webapp.model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

public class ViewServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int userId = Integer.parseInt(request.getParameter("userId"));

        // Create an instance of UserDAO
        UserDAO userDAO = new UserDAO();

        // Retrieve user and address details from the database using the instance
        User user = userDAO.getUserById(userId);
        List<Address> addresses = userDAO.getAddressByUserId(userId);

        // Set the user and address details as request attributes
        request.setAttribute("user", user);
        request.setAttribute("addresses", addresses);

        // Forward the request to the user details JSP
        request.getRequestDispatcher("userDetails.jsp").forward(request, response);
    }
}
