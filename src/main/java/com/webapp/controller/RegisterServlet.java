package com.webapp.controller;

import com.webapp.dao.UserDAO;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.Base64;

public class RegisterServlet extends HttpServlet {
    private UserDAO userDAO;

    public void init() {
        userDAO = new UserDAO();
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String fname = req.getParameter("firstName");
        String lname = req.getParameter("lastName");
        String gen = req.getParameter("gender");
        String email = req.getParameter("emailAddress");
        String uname = req.getParameter("userName");
        String pwd = req.getParameter("password");
        String contact = req.getParameter("contactNo");

        // Retrieve the selected role from the form
        String role = req.getParameter("role");

        // Address fields
        String[] streetAddresses = req.getParameterValues("address1");
        String[] apartmentNumbers = req.getParameterValues("apartment1");
        String[] zipCodes = req.getParameterValues("zipcode1");
        String[] cities = req.getParameterValues("selectCity");
        String[] states = req.getParameterValues("selectState");

        String encryptedPassword = Base64.getEncoder().encodeToString(pwd.getBytes());


        // Check if the username or email is already registered
        if (userDAO.isUsernameExists(uname)) {
            req.setAttribute("usernameError", "Username is already registered.");
        }

        if (userDAO.isEmailExists(email)) {
            req.setAttribute("emailError", "Email is already registered.");
        }

        // If username or email is already registered, return to the registration page with error messages
        if (req.getAttribute("usernameError") != null || req.getAttribute("emailError") != null) {
            RequestDispatcher dispatcher = req.getRequestDispatcher("register.jsp");
            dispatcher.forward(req, resp);
        } else {
            // Register the user with the encrypted password
            if (userDAO.registerUser(uname, encryptedPassword, fname, lname, email, contact, gen, role, streetAddresses, apartmentNumbers, zipCodes, cities, states)) {
                // Registration successful, you can redirect to a success page or login page
                resp.sendRedirect(req.getContextPath() + "/login.jsp");
            } else {
                resp.getWriter().append("Failed to Register User...");
            }
        }
    }
}
