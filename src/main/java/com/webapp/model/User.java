package com.webapp.model;

public class User {
    private int userId;
    private String userName;
    private String password;
    private String firstName;
    private String lastName;
    private String email;
    private String contact;
    private String gender;
    private String role;


    public User(String userName, String password, String firstName, String lastName, String email, String contact, String gender, String role, int userId) {
    this.userName= userName;
    this.password = password;
    this.firstName = firstName;
    this.lastName = lastName;
    this.email = email;
    this.contact= contact;
    this.gender = gender;
    this.userId = userId;
    this.role = role;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public User() {

    }

    public User(String userName, String firstName, String lastName, String email, String contact, String gender, int userId, String role) {
        this.userName = userName;
        this.firstName= firstName;
        this.lastName = lastName;
        this.email = email;
        this.contact = contact;
        this.gender = gender;
        this.userId = userId;
        this.role = role;
    }



    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }



    public User(String userName, String firstName, String lastName, String email, String contact, String gender, String role) {
        this.userName = userName;
        this.firstName = firstName;
        this.lastName = lastName;
        this.email = email;
        this.contact = contact;
        this.gender = gender;
        this.role = role;
    }

    // Getters and setters for each attribute

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    public String getFirstName() {
        return firstName;
    }

    public void setFirstName(String firstName) {
        this.firstName = firstName;
    }

    public String getLastName() {
        return lastName;
    }

    public void setLastName(String lastName) {
        this.lastName = lastName;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getContact() {
        return contact;
    }

    public void setContact(String contact) {
        this.contact = contact;
    }

    public String getGender() {
        return gender;
    }

    public void setGender(String gender) {
        this.gender = gender;
    }

    public String getRole() {
        return role;
    }

    public void setRole(String role) {
        this.role = role;
    }
    @Override
    public String toString() {
        return "User ID: " + userId +
                "\nUsername: " + userName +
                "\nFirst Name: " + firstName +
                "\nLast Name: " + lastName +
                "\nEmail: " + email +
                "\nContact: " + contact +
                "\nGender: " + gender +
                "\nRole: " + role;
    }

}
