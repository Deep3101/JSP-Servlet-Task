package com.webapp.controller;

import com.webapp.dao.UserDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

public class LoginServlet extends HttpServlet {
    private UserDAO userDAO;

    public void init() {
        userDAO = new UserDAO();
    }


    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException, ServletException {
        String username = req.getParameter("username");
        String password = req.getParameter("password");

//
//        String decryptedPassword = new String(Base64.getDecoder().decode(password));
//        System.out.println("decoded " +decryptedPassword);

        // Authenticate the user and obtain userId
        int userId = UserDAO.authenticateUserAndGetId(username, password);


        if (userId > 0) {
            // Authentication successful
            String role = userDAO.getUserRole(username);
            HttpSession session = req.getSession();
            session.setAttribute("username", username);
            session.setAttribute("role", role);
            session.setAttribute("userId", userId); // Set userId in the session
            session.setAttribute("loggedInUser", username);

            if ("ADMIN".equals(role)) {
                session.setAttribute("loggedIn", true);

                resp.sendRedirect(req.getContextPath() + "/AdminDashboardServlet");
            } else {
                session.setAttribute("loggedIn", true); // Set loggedIn to true

                resp.sendRedirect(req.getContextPath() + "/UserDashboardServlet");
            }
        } else {
            // Username not registered or incorrect password
            if (UserDAO.isUsernameRegistered(username)) {
                // Username is registered, so the password must be incorrect
                req.setAttribute("passwordError", "Incorrect password");
            } else {
                // Username is not registered
                req.setAttribute("usernameError", "Username not registered");
            }
            req.getRequestDispatcher("/login.jsp").forward(req, resp);
        }
    }

}


