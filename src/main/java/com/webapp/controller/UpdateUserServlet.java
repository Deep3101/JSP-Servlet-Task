package com.webapp.controller;

import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Objects;

import com.webapp.dao.UserDAO;
import com.webapp.model.Address;
import com.webapp.model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

public class UpdateUserServlet extends HttpServlet {

    UserDAO userDAO = new UserDAO();

    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            // Retrieve user details from the request
            String userIdStr = req.getParameter("userId");
            if (userIdStr == null || userIdStr.isEmpty()) {
                // Handle the case where userId is missing or empty
                resp.sendRedirect(req.getContextPath() + "/UserUpdateError.jsp");
                return;
            }

            int userId = Integer.parseInt(userIdStr);
            String userName = req.getParameter("userName");
            String firstName = req.getParameter("firstName");
            String lastName = req.getParameter("lastName");
            String email = req.getParameter("email");
            String contact = req.getParameter("contact");
            String gender = req.getParameter("gender");
            String role = req.getParameter("role");

            // Create a User object with updated details
            User updatedUser = new User();   //will set properties of updated user retrieved from request
            updatedUser.setUserId(userId);
            updatedUser.setUserName(userName);
            updatedUser.setFirstName(firstName);
            updatedUser.setLastName(lastName);
            updatedUser.setEmail(email);
            updatedUser.setContact(contact);
            updatedUser.setGender(gender);
            updatedUser.setRole(role);

            String[] street = req.getParameterValues("streetAddress");  //will retrieve array of values
            String[] apartmentNumber = req.getParameterValues("apartmentNumber");
            String[] zipCode = req.getParameterValues("zipCode");
            String[] city = req.getParameterValues("city");
            String[] state = req.getParameterValues("state");

            String[] addressid = req.getParameterValues("addressId");
            if (addressid != null) {
                List<Address> addresses = userDAO.getAddressByUserId(userId); //retrieves list of addresses with given userid from db
                int index = 0;                   //variables intialized for address removal
                int[] oldAddressid = new int[addresses.size()];
                int addressIdLength;
                addressIdLength = addressid.length;
                int count = 0;
                for (Address address : addresses) {
                    oldAddressid[index] = address.getAddressId();
                    if (count < addressIdLength && addressid[count].length() != 0) {
                        int addrssid = Integer.parseInt(addressid[count]);
                        if (oldAddressid[index] == addrssid) {
                            count++;
                        }else {
                            userDAO.deleteAddress(address.getAddressId());
                        }
                    } else {
                        userDAO.deleteAddress(address.getAddressId());
                    }
                    index++;
                }
            }

            List<Address> updatedAddresses = new ArrayList<>();
            int i;
            if (addressid != null) {
                for (i = 0; i < street.length; i++) {
                    if (!Objects.equals(addressid[i], "")) {
                        int addressIdInt = Integer.parseInt(addressid[i]);

                        Address updatedAddress = new Address(street[i], apartmentNumber[i], zipCode[i], city[i], state[i], addressIdInt);
                        updatedAddresses.add(updatedAddress);

                    } else {
                        Address address = new Address();
                        address.setUserId(userId);
                        address.setAddress1(street[i]);
                        address.setApartment1(apartmentNumber[i]);
                        address.setSelectCity(city[i]);
                        address.setZipcode1(zipCode[i]);
                        address.setSelectState(state[i]);
                        userDAO.saveaddress(address);
                    }
                }
            }

            try {
                // Update the user and all addresses in the database
                boolean updated = UserDAO.updateUserAndAddresses(updatedUser, updatedAddresses);

                if (updated) {
                    String username = (String) req.getSession().getAttribute("username");
                    String userRole = UserDAO.getUserRole(username);

                    if ("ADMIN".equals(userRole)) {
                        resp.sendRedirect(req.getContextPath() + "/AdminDashboardServlet?userId=" + userId);
                    } else {
                        // User and address details updated successfully
                        resp.sendRedirect(req.getContextPath() + "/UserDashboardServlet?userId=" + userId);
                    }

                } else {
                    // User and address details couldn't be updated
                    resp.sendRedirect(req.getContextPath() + "/UserUpdateError.jsp");
                }
            } catch (SQLException e) {
                // Handle any database-related exceptions here
                throw new ServletException(e);
            }
        } catch (NumberFormatException | SQLException e) {
            // Handle the case where a parameter couldn't be parsed as an integer
            resp.sendRedirect(req.getContextPath() + "/UserUpdateError.jsp");
        }
    }
}
