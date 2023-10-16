package com.webapp.controller;

import com.webapp.dao.UserDAO;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import javax.mail.*;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import java.util.Properties;
import java.util.Random;

public class ForgotPasswordServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response) {
        String email = request.getParameter("email");
        RequestDispatcher dispatcher;
        int otpvalue;
        HttpSession mySession = request.getSession();

        if (email != null && !email.equals("")) {
            try {
                int emailCount = UserDAO.checkEmailExistence(email);

                if (emailCount == 0) {
                    request.setAttribute("message", "Email is not registered. Please use a registered email address.");
                    dispatcher = request.getRequestDispatcher("forgotPassword.jsp");
                } else {
                    Random rand = new Random();
                    otpvalue = rand.nextInt(1255650);

                    // Rest of the code for sending email
                    Properties props = new Properties();
                    props.put("mail.smtp.host", "smtp.gmail.com");
                    props.put("mail.smtp.socketFactory.port", "465");
                    props.put("mail.smtp.socketFactory.class", "javax.net.ssl.SSLSocketFactory");
                    props.put("mail.smtp.auth", "true");
                    props.put("mail.smtp.port", "465");
                    Session session = Session.getDefaultInstance(props, new Authenticator() {
                        protected PasswordAuthentication getPasswordAuthentication() {  //method overridden within anonymous inner class to provide authentication
                            return new PasswordAuthentication("panchaldeep113@gmail.com", "ugbimjuhqkxbcopr");
                        }
                    });

                    try {
                        MimeMessage message = new MimeMessage(session);
                        message.setFrom(new InternetAddress(email));
                        message.addRecipient(Message.RecipientType.TO, new InternetAddress(email));
                        message.setSubject("Hello");
                        message.setText("Your OTP is: " + otpvalue);
                        Transport.send(message);
                        request.setAttribute("message", "OTP is sent to your email id successfully");
                        System.out.println("Message sent successfully");
                    } catch (MessagingException e) {
                        throw new RuntimeException(e);
                    }

                    dispatcher = request.getRequestDispatcher("enterOtp.jsp"); // Replace with the actual JSP page
                    request.setAttribute("message", "OTP is sent to your email id");
                    mySession.setAttribute("otp", otpvalue);
                    mySession.setAttribute("email", email);
                }
                dispatcher.forward(request, response);
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }
}
