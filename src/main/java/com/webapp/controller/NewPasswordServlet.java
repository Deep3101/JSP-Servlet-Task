package com.webapp.controller;

import java.io.IOException;
import java.io.Serial;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import com.webapp.dao.UserDAO;

import java.util.Base64;

public class NewPasswordServlet extends HttpServlet {
    @Serial
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        String newPassword = request.getParameter("password");
        String confPassword = request.getParameter("confPassword");
        RequestDispatcher dispatcher;

        if (newPassword != null && newPassword.equals(confPassword)) {
            String email = (String) session.getAttribute("email");
            String encodedPassword = Base64.getEncoder().encodeToString(newPassword.getBytes());

            boolean updateSuccess = UserDAO.updateUserPassword(email, encodedPassword);


            if (updateSuccess) {
                request.setAttribute("status", "resetSuccess");
            } else {
                request.setAttribute("status", "resetFailed");
            }

            dispatcher = request.getRequestDispatcher("login.jsp");
            dispatcher.forward(request, response);
        }
    }
}
