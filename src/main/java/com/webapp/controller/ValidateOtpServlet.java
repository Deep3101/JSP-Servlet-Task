package com.webapp.controller;

import java.io.IOException;
import java.io.Serial;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

public class ValidateOtpServlet extends HttpServlet {
    @Serial
    private static final long serialVersionUID = 1L;


    protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
    {
        int value=Integer.parseInt(request.getParameter("otp"));
        HttpSession session=request.getSession();
        int otp=(int)session.getAttribute("otp");



        RequestDispatcher dispatcher;


        if (value==otp)
        {

            request.setAttribute("email", request.getParameter("email"));
            request.setAttribute("status", "success");
            dispatcher=request.getRequestDispatcher("newPassword.jsp");
            dispatcher.forward(request, response);

        }
        else
        {
            request.setAttribute("message","wrong otp");
            dispatcher=request.getRequestDispatcher("enterOtp.jsp");
            dispatcher.forward(request, response);

        }

    }

}
