<%@ page import="com.webapp.model.User, com.webapp.model.Address, com.webapp.dao.UserDAO, java.util.*, java.sql.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css"
          integrity="sha384-xOolHFLEh07PJGoPkLv1IbcEPTNtaed2xpHsD9ESMhqIYd0nLMwNLD69Npy4HI+N"
          crossorigin="anonymous" />
    <title>User Details</title>
    <style>
        body {
            background-color: #0275d8;
            margin: 0 auto;
            display: flex;
            flex-direction: column;
            min-height: 100vh;
        }

        .content {
            flex-grow: 1;
            display: flex;
            flex-direction: column;
            align-items: center; /* Center horizontally */
            justify-content: center; /* Center vertically */
            padding-top: 40px;
        }

        .user-details {
            width: 100%;
            max-width: 900px; /* Limit width to make it more readable */
            background-color: white;
            padding: 20px;
            box-shadow: 0px 0px 10px 2px rgba(0, 0, 0, 0.4);
            border-radius: 5px;
        }

        h2 {
            text-align: center;
        }

        .form-group {
            margin-bottom: 20px;
        }

        button {
            margin-top: 10px;
        }
        .error-message {
             color:red;
        }
    </style>
</head>
<% response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate"); %>
<% response.setHeader("Pragma", "no-cache"); %>
<% response.setDateHeader("Expires", 0); %>
<body>
<jsp:include page="header.jsp" />
<div class="content">
    <div class="user-details">
        <h2>User Details</h2>
        <form action="UpdateUserServlet" method="post">
                <input type="hidden" class="form-control" id="userId" name="userId" value="<c:out value='${user.getUserId()}' />" disabled>
            <div class="form-group">
                <label for="userName">User Name:</label>
                <input type="text" class="form-control" id="userName" name="userName" value="<c:out value='${user.getUserName()}' />" readonly>
            </div>
            <div class="form-group">
                <label for="firstName">First Name:</label>
                <input type="text" class="form-control" id="userFirstName" name="firstName" value="<c:out value='${user.getFirstName()}' />" disabled>
                <div class="error-message" id="firstNameError"></div>
            </div>
            <div class="form-group">
                <label for="lastName">Last Name:</label>
                <input type="text" class="form-control" id="userLastName" name="lastName" value="<c:out value='${user.getLastName()}' />" disabled>
                <div class="error-message" id="lastNameError"></div>
            </div>
            <div class="form-group">
                <label for="email">Email:</label>
                <input type="text" class="form-control" id="email" name="email" value="<c:out value='${user.getEmail()}' />" readonly>
            </div>
            <div class="form-group">
                <label for="contact">Contact:</label>
                <input type="text" class="form-control" id="contact" name="contact" value="<c:out value='${user.getContact()}' />" disabled>
                <div class="error-message" id="contactError"></div>
            </div>
            <div class="form-group" id="genderGroup">
                <label>Gender:</label>
                <div class="form-check form-check-inline">
                    <input type="radio" class="form-check-input" id="male" name="gender" value="Male" <c:if test="${user.getGender() eq 'Male'}">checked</c:if> disabled>
                    <label class="form-check-label" for="male">Male</label>
                </div>
                <div class="form-check form-check-inline">
                     <input type="radio" class="form-check-input" id="female" name="gender" value="Female" <c:if test="${user.getGender() eq 'Female'}">checked</c:if> disabled>
                     <label class="form-check-label" for="female">Female</label>
                </div>
                <div class="form-check form-check-inline">
                    <input type="radio" class="form-check-input" id="other" name="gender" value="Other" <c:if test="${user.getGender() eq 'Other'}">checked</c:if> disabled>
                    <label class="form-check-label" for="female">Other</label>
                </div>
            </div>
            <h3 class="text-bold"> Addresses : </h3>
            <!-- Inside the c:forEach loop for displaying user addresses -->
            <c:forEach var="address" items="${addresses}" varStatus="loop">
                <div class="address-form">
                    <div class="form-group">
                        <input type="hidden" name="addressId" value="${address.getAddressId()}"/>
                        <label for="streetAddress">Street Address:</label>
                        <input type="text" class="form-control" id="streetAddress" name="streetAddress" value="${address.getAddress1()}" disabled>
                        <div class="error-message" id="streetAddressError"></div>
                    </div>
                    <div class="form-group">
                        <label for="apartmentNumber">Apartment Number:</label>
                        <input type="text" class="form-control" id="apartmentNumber" name="apartmentNumber" value="${address.getApartment1()}" disabled>
                        <div class="error-message" id="apartmentNumberError"></div>
                    </div>
                    <div class="form-group">
                        <label for="zipCode">ZIP Code:</label>
                        <input type="text" class="form-control" id="zipCode" name="zipCode" value="${address.getZipcode1()}" disabled>
                        <div class="error-message" id="zipCodeError"></div>
                    </div>
                    <div class="form-group">
                        <label for="city">City:</label>
                        <input type="text" class="form-control" id="city" name="city" value="${address.getSelectCity()}" disabled>
                        <div class="error-message" id="cityError"></div>
                    </div>
                    <div class="form-group">
                        <label for="state">State:</label>
                        <input type="text" class="form-control" id="state" name="state" value="${address.getSelectState()}" disabled>
                        <div class="error-message" id="stateError"></div>
                    </div>
                    <button type="button" class="btn btn-danger remove-address-button" style="display: none;" data-address-id="${address.getAddressId()}">Remove Address</button>
                </div>
            </c:forEach>
            <!-- Add an edit button to make changes -->
            <button type="button" id="editButton" class="btn btn-success">Edit</button>
            <!-- Add a Save Changes button (hidden initially) -->
            <button type="submit" id="saveButton" class="btn btn-primary" style="display: none;">Save Changes</button>
            <!-- Add an Add Address button -->
            <button type="button" id="addAddressButton" class="btn btn-info" style="display: none;">Add Address</button>
        </form>
    </div>
</div>
<jsp:include page="footer.jsp" />
<script>
    document.addEventListener("DOMContentLoaded", function () {
        // Function to make form fields editable
        function makeFieldsEditable() {
            const inputFields = document.querySelectorAll(".form-control");
            inputFields.forEach(function (input) {
                // Check if it's the username field
                if (input.id !== "userName") {
                    input.removeAttribute("disabled");
                }
            });

            // Enable the "Save Changes" and "Add Address" buttons
            document.getElementById("saveButton").style.display = "inline";
            document.getElementById("addAddressButton").style.display = "inline";
            // Show the "Remove Address" buttons
            const removeAddressButtons = document.querySelectorAll(".remove-address-button");
            removeAddressButtons.forEach(function (button) {
                button.style.display = "inline";
            });
        }

        // Function to make form fields readable
        function makeFieldsReadable() {
            const inputFields = document.querySelectorAll(".form-control");
            inputFields.forEach(function (input) {
                input.setAttribute("disabled", "disabled");
            });

            // Disable the "Save Changes" and "Add Address" buttons
            document.getElementById("saveButton").style.display = "none";
            document.getElementById("addAddressButton").style.display = "none";
            // Hide the "Remove Address" buttons
            const removeAddressButtons = document.querySelectorAll(".remove-address-button");
            removeAddressButtons.forEach(function (button) {
                button.style.display = "none";
            });
        }

        // Function to add a new address field
        function addAddressField() {
            // Clone the first address form field (assuming it's present initially)
            const firstAddressField = document.querySelector(".address-form");
            const newAddressField = firstAddressField.cloneNode(true);

            // Clear the values in the cloned address field
            const clonedInputs = newAddressField.querySelectorAll("input");
            clonedInputs.forEach(function (input) {
                input.value = "";
            });

            // Add the cloned address field to the form
            const addressForm = document.querySelector(".user-details form");
            addressForm.insertBefore(newAddressField, document.getElementById("addAddressButton"));

            // Enable the "Remove Address" button for the new address field
            const removeAddressButton = newAddressField.querySelector(".remove-address-button");
            removeAddressButton.style.display = "inline";

            // Attach an event listener to the new "Remove Address" button
            removeAddressButton.addEventListener("click", function () {
                // Handle the removal of the address field here
                // You can access the address ID using this.getAttribute("data-address-id")
                // Remove the corresponding address field and perform any other required actions
                const addressId = this.getAttribute("data-address-id");
                const addressField = this.closest(".address-form");
                // Remove the address field associated with this addressId
                addressField.remove();
            });
        }

        // Event listener for the "Edit" button
        document.getElementById("editButton").addEventListener("click", function () {
            makeFieldsEditable();
            // Show the "Add Address" button
            document.getElementById("addAddressButton").style.display = "inline";

             if (document.querySelectorAll(".address-form").length === 0) {
                    document.getElementById("addAddressButton").style.display = "inline";
                }
             const genderRadioButtons = document.querySelectorAll("[name='gender']");
                 genderRadioButtons.forEach(function (radioButton) {
                     if (!radioButton.hasAttribute("disabled")) {
                         radioButton.removeAttribute("disabled");
                     }
                 });
            });

        // Event listener for the "Add Address" button
        document.getElementById("addAddressButton").addEventListener("click", function () {
            addAddressField();
        });

        // Event listener for the "Remove Address" buttons (initially displayed ones)
        const removeAddressButtons = document.querySelectorAll(".remove-address-button");
        removeAddressButtons.forEach(function (button) {
            button.addEventListener("click", function () {
                // Handle the removal of the address field here
                // You can access the address ID using this.getAttribute("data-address-id")
                // Remove the corresponding address field and perform any other required actions
                const addressId = this.getAttribute("data-address-id");
                const addressField = this.closest(".address-form");
                // Remove the address field associated with this addressId
                addressField.remove();
            });
        });

        // Initially, make fields readable
        makeFieldsReadable();
        // Function to validate fields
                    function validateFields() {
                        const firstName = document.getElementById("userFirstName").value;
                        const lastName = document.getElementById("userLastName").value;
                        const contact = document.getElementById("contact").value;
                        const streetAddress = document.getElementById("streetAddress").value;
                        const apartmentNumber = document.getElementById("apartmentNumber").value;
                        const zipCode = document.getElementById("zipCode").value;
                        const city = document.getElementById("city").value;
                        const state = document.getElementById("state").value;

                        // Regular expressions for validation
                        const nameRegex = /^[A-Za-z]+$/;
                        const contactRegex = /^\d{10}$/; // For a 10-digit number
                        const streetRegex = /^[A-Za-z0-9\s\-,.]+$/;
                        const apartmentRegex = /^\d+$/; // For positive integers
                        const zipCodeRegex = /^\d{3}$/; // For a 5-digit ZIP code
                        const cityRegex = /^[A-Za-z\s]+$/;
                        const stateRegex = /^[A-Za-z\s]+$/;


                        // Error messages
                        const firstNameError = document.getElementById("firstNameError");
                        const lastNameError = document.getElementById("lastNameError");
                        const contactError = document.getElementById("contactError");
                        const streetAddressError = document.getElementById("streetAddressError");
                        const apartmentNumberError = document.getElementById("apartmentNumberError");
                        const zipCodeError = document.getElementById("zipCodeError");
                        const cityError = document.getElementById("cityError");
                        const stateError = document.getElementById("stateError");

                        // Validate First Name
                        if (!nameRegex.test(firstName)) {
                            firstNameError.innerText = "First Name is not valid.";
                            return false;
                        } else {
                            firstNameError.innerText = "";
                        }

                        // Validate Last Name
                        if (!nameRegex.test(lastName)) {
                            lastNameError.innerText = "Last Name is not valid.";
                            return false;
                        } else {
                            lastNameError.innerText = "";
                        }

                        // Validate Contact
                        if (!contactRegex.test(contact)) {
                            contactError.innerText = "Contact is not valid. It should be a 10-digit number.";
                            return false;
                        } else {
                            contactError.innerText = "";
                        }

                        //Validate Street Address
                        if(!streetRegex.test(streetAddress)){
                             streetAddressError.innerText = "Street Address Not Valid. Don't Use Special Characters Like @ #";
                             return false;
                        }else {
                              streetAddressError.innerText = "";
                        }

                        // Validate Apartment Number
                        if (!apartmentRegex.test(apartmentNumber)) {
                            apartmentNumberError.innerText = "Apartment Number is not valid. It should be a positive integer.";
                            return false;
                        } else {
                            apartmentNumberError.innerText = "";
                        }

                        // Validate ZIP Code
                        if (!zipCodeRegex.test(zipCode)) {
                            zipCodeError.innerText = "ZIP Code is not valid. It should be a 3 digit number.";
                            return false;
                        } else {
                            zipCodeError.innerText = "";
                        }

                        //Validate City and state
                        if(!cityRegex.test(city)){
                            cityError.innerText = "City Invalid. Don't use Numbers or special characters.";
                            return false;
                        }else{
                            cityError.innerText = "";
                        }

                        if(!stateRegex.test(state)){
                            stateError.innerText = "State Invalid. Don't use Numbers or special characters.";
                            return false;
                        }

                        return true; // All fields are valid
                    }

                    // Event listener for the "Save Changes" button
                    document.getElementById("saveButton").addEventListener("click", function (event) {
                        if (!validateFields()) {
                            event.preventDefault(); // Prevent form submission if validation fails
                        }
                    });
    });
</script>
</body>
</html>
