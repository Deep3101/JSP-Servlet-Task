package com.webapp.controller;

import jakarta.servlet.*;
import jakarta.servlet.http.HttpServletRequest;

import java.io.IOException;
import java.util.regex.Pattern;
import java.util.regex.Matcher;

public class ValidationFilter implements Filter {
    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
        Filter.super.init(filterConfig);
    }

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain filterChain) throws IOException, ServletException {
        HttpServletRequest req = (HttpServletRequest) request;

        boolean hasErrors = false; // A flag to track validation errors

        // Validate first name
        String firstName = req.getParameter("firstName");
        if (!firstName.matches("^[a-zA-Z]+$")) {
            req.setAttribute("firstNameError", "Invalid first name");
            hasErrors = true;
        }

        // Validate last name
        String lastName = req.getParameter("lastName");
        if (!lastName.matches("^[a-zA-Z]+$")) {
            req.setAttribute("lastNameError", "Invalid last name");
            hasErrors = true;
        }

        // Validate username
        String userName = req.getParameter("userName");
        if (!userName.matches("^[a-zA-Z]+$")) {
            req.setAttribute("userNameError", "Invalid username");
            hasErrors = true;
        }

        // Validate email address
        String emailAddress = req.getParameter("emailAddress");
        if (!emailAddress.matches("[a-z0-9._%+-]+@[a-z0-9.-]+\\.[a-z]{2,3}$")) {
            req.setAttribute("emailAddressError", "Invalid email address");
            hasErrors = true;
        }

        // Validate contact number
        String contactNo = req.getParameter("contactNo");
        if (!contactNo.matches("^[0-9]+$")) {
            req.setAttribute("contactNoError", "Invalid contact number");
            hasErrors = true;
        }

        // Validate password
        String password = req.getParameter("password");
        if (!password.matches("^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)(?=.*[#$@!%&*?+-])[A-Za-z\\d#$@!%&*?+-]{3,30}$")) {
            req.setAttribute("passwordError", "Invalid password");
            hasErrors = true;
        }

        // Validate address fields
        String[] streetAddresses = req.getParameterValues("address1");
        String[] apartmentNumbers = req.getParameterValues("apartment1");
        String[] zipCodes = req.getParameterValues("zipcode1");


        if (streetAddresses == null) {
            req.setAttribute("addressError", "Please add at least one address");
            hasErrors = true;
        } else {
            for (int i = 0; i < streetAddresses.length; i++) {
                // Check if street address is valid
                Pattern streetPattern = Pattern.compile("^[a-zA-Z0-9\\s.,#-]+$");
                Matcher streetMatcher = streetPattern.matcher(streetAddresses[i]);
                if (!streetMatcher.matches()) {
                    req.setAttribute("address1Error", "Invalid characters in street address");
                    hasErrors = true;
                }

                // Check if apartment number is valid
                Pattern apartmentPattern = Pattern.compile("^[0-9]+$");
                Matcher apartmentMatcher = apartmentPattern.matcher(apartmentNumbers[i]);
                if (!apartmentMatcher.matches()) {
                    req.setAttribute("address2Error", "Invalid characters in apartment number");
                    hasErrors = true;
                }

                // Check if ZIP code is valid
                Pattern zipCodePattern = Pattern.compile("^[0-9]+$");
                Matcher zipCodeMatcher = zipCodePattern.matcher(zipCodes[i]);
                if (!zipCodeMatcher.matches()) {
                    req.setAttribute("address3Error", "Invalid ZIP code format");
                    hasErrors = true;
                }

            }
        }

        if (hasErrors) {
            // Forward to the register JSP page with error messages
            req.getRequestDispatcher("register.jsp").forward(request, response);
        } else {
            // If no errors, continue with the filter chain
            filterChain.doFilter(request, response);
        }
    }

    @Override
    public void destroy() {
        Filter.super.destroy();
    }
}
