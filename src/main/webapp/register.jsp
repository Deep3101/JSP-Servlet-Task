<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css"
        integrity="sha384-xOolHFLEh07PJGoPkLv1IbcEPTNtaed2xpHsD9ESMhqIYd0nLMwNLD69Npy4HI+N" crossorigin="anonymous" />
    <title>jQuery Form Validation</title>
    <style>
        #firstname-error,
        #lastname-error,
        #birthday-error,
        #email-error,
        #password-error,
        #cpassword-error,
        #selectcity-error,
        #check-error,
        #username-error,
        #contact-error
        {
            color: red;
        }

        .add-border-red {
            border: 2px solid red;
            box-shadow: 0.5px 0.5px 1px 0.5px red;
        }

        .add-border-green {
            border: 2px solid green;
            box-shadow: 0.5px 0.5px 1px 0.5px green;
        }

        .form-label::after {
            content: "*";
            color: red;
        }
    </style>
</head>
<% response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate"); %>
<% response.setHeader("Pragma", "no-cache"); %>
<% response.setDateHeader("Expires", 0); %>
<body>
<jsp:include page="header.jsp" />
    <section class="gradient-custom bg-primary">
        <div class="container-fluid py-4">
            <div class="row justify-content-center align-items-center">
                <div class="col-12 col-lg-9 col-xl-7">
                    <div class="card shadow-2-strong card-registration">
                        <div class="card-body p-4 p-md-5">
                            <h3 class="mb-4 pb-2 pb-md-0 mb-md-5">
                                User Registration Form
                            </h3>
                            <form id="form" action="RegisterServlet" method="post" autocomplete="off">
                                <div class="row">
                                    <div class="col-md-6 mb-4">
                                        <div class="form-outline">
                                            <label class="form-label font-weight-bold" for="firstName">First Name :</label>
                                            <input type="text" id="firstName" class="form-control form-control-lg"
                                                name="firstName" required />
                                            <p id="firstname-error"></p>
                                            <c:if test="${not empty requestScope.firstNameError}">
                                                        <span style="color: red;">${requestScope.firstNameError}</span>
                                            </c:if>
                                         </div>
                                    </div>
                                    <div class="col-md-6 mb-4">
                                        <div class="form-outline">
                                            <label class="form-label font-weight-bold" for="lastName">Last Name :</label>
                                            <input type="text" id="lastName" class="form-control form-control-lg"
                                                name="lastName" required />
                                            <p id="lastname-error"></p>
                                            <c:if test="${not empty requestScope.lastNameError}">
                                                        <span style="color: red;">${requestScope.lastNameError}</span>
                                            </c:if>
                                       </div>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-md-6 mb-4 d-flex align-items-center">
                                        <div class="form-outline datepicker w-100">
                                            <label for="birthdayDate" class="form-label font-weight-bold">D.O.B. :</label><br />
                                            <input type="date" name="birthdayDate" id="birthdayDate" required />
                                            <p id="birthday-error"></p>
                                        </div>
                                    </div>
                                    <div class="col-md-6 mb-4">
                                        <h6 class="mb-2 pb-1 font-weight-bold">Gender :</h6>
                                        <div class="form-check form-check-inline">
                                            <input class="form-check-input" type="radio" name="gender" id="femaleGender" value="Female" />
                                            <label class="form-check-label" for="femaleGender">Female</label>
                                        </div>
                                        <div class="form-check form-check-inline">
                                            <input class="form-check-input" type="radio" name="gender" id="maleGender" value="Male" checked />
                                            <label class="form-check-label" for="maleGender">Male</label>
                                        </div>
                                        <div class="form-check form-check-inline">
                                            <input class="form-check-input" type="radio" name="gender" id="otherGender" value="Other" />
                                            <label class="form-check-label" for="otherGender">Other</label>
                                        </div>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-md-6 mb-4 pb-2">
                                        <div class="form-outline">
                                            <label class="form-label font-weight-bold" for="emailAddress">Email :</label>
                                            <input type="email" id="emailAddress" class="form-control form-control-lg"
                                                name="emailAddress" required />
                                                <% if (request.getAttribute("emailError") != null) { %>
                                                        <p class="text-danger"><%= request.getAttribute("emailError") %></p>
                                                    <% } %>
                                            <p id="email-error"></p>
                                            <c:if test="${not empty requestScope.emailAddressError}">
                                                        <span style="color: red;">${requestScope.emailAddressError}</span>
                                            </c:if>
                                        </div>
                                    </div>
                                    <div class="col-md-6 mb-4">
                                        <div class="form-outline">
                                            <label class="form-label font-weight-bold" for="userName">Username :</label>
                                            <input type="text" id="userName" class="form-control form-control-lg"
                                                name="userName" required />
                                <% if (request.getAttribute("usernameError") != null) { %>
                                          <p class="text-danger"><%= request.getAttribute("usernameError") %></p>
                                <% } %>
                                            <p id="username-error"></p>
                                            <c:if test="${not empty requestScope.userNameError}">
                                                        <span style="color: red;">${requestScope.userNameError}</span>
                                            </c:if>
                                        </div>
                                    </div>
                                    <div class="col-md-6 mb-4 pb-2">
                                        <div class="form-outline">
                                            <label class="form-label font-weight-bold" for="password">Password :</label>
                                            <input type="password" id="password" class="form-control form-control-lg"
                                                name="password" required />
                                            <p id="password-error"></p>
                                            <c:if test="${not empty requestScope.passwordError}">
                                                        <span style="color: red;">${requestScope.passwordError}</span>
                                            </c:if>
                                        </div>
                                    </div>
                                    <div class="col-md-6 mb-4 pb-2">
                                        <div class="form-outline">
                                            <label class="form-label font-weight-bold" for="cpassword">Confirm Password :</label>
                                            <input type="password" id="cpassword" class="form-control form-control-lg"
                                                name="cpassword" required />
                                            <p id="cpassword-error"></p>
                                        </div>
                                    </div>
                                    <div class="col-md-6 mb-4">
                                        <div class="form-outline">
                                            <label class="form-label font-weight-bold" for="contactNo">Contact No. :</label>
                                            <input type="text" id="contactNo" class="form-control form-control-lg"
                                                name="contactNo" required />
                                            <p id="contact-error"></p>
                                            <c:if test="${not empty requestScope.contactNoError}">
                                                        <span style="color: red;">${requestScope.contactNoError}</span>
                                            </c:if>
                                        </div>
                                    </div>
                                    <div class="col-md-6 mb-4" style="display:none;">
                                         <div class="form-outline">
                                              <label class="form-label font-weight-bold">Role:</label>
                                                     <br><select class="select form-control-lg" name="role" required>
                                                         <option value="USER">User</option>
                                                         <option value="ADMIN">Admin</option>
                                              </select>
                                         </div>
                                    </div>
                                </div>
                                <div id="address-fields">
                                    <div class="row mt-4">
                                        <div class="col-md-6">
                                            <label class="form-label font-weight-bold" for="address1">Street Address :</label>
                                            <input type="text" class="form-control form-control-lg" name="address1" id="address1" required />
                                            <div id="streetAddressFeedback" class="d-none"></div>
                                             <c:if test="${not empty requestScope.address1Error}">
                                                        <span style="color: red;">${requestScope.address1Error}</span>
                                            </c:if>
                                        </div>
                                        <div class="col-md-3">
                                            <label class="form-label font-weight-bold" for="apartment1">Apartment No. :</label>
                                            <input type="text" class="form-control form-control-lg" name="apartment1" id="apartment1" required />
                                            <div id="apartmentNumberFeedback" class="d-none"></div>
                                            <c:if test="${not empty requestScope.address2Error}">
                                                     <span style="color: red;">${requestScope.address2Error}</span>
                                            </c:if>
                                        </div>
                                        <div class="col-md-3">
                                            <label class="form-label font-weight-bold" for="zipcode1">ZIP code :</label>
                                            <input type="text" class="form-control form-control-lg" name="zipcode1" id="zipcode1" required />
                                            <div id="zipCodeFeedback" class="d-none"></div>
                                            <c:if test="${not empty requestScope.address3Error}">
                                                        <span style="color: red;">${requestScope.address3Error}</span>
                                            </c:if>
                                        </div>
                                        <div class="col-md-6 mt-4">
                                                <label class="form-label font-weight-bold" for="selectCity">City :</label>
                                                <select class="select form-control-lg" name="selectCity" id="selectCity" required>
                                                    <option value="" selected hidden>Select</option>
                                                    <option value="Vadodara">Vadodara</option>
                                                    <option value="Ahmedabad">Ahmedabad</option>
                                                    <option value="Surat">Surat</option>
                                                    <option value="Bharuch">Bharuch</option>
                                                    <option value="Mumbai">Mumbai</option>
                                                    <option value="Ujjain">Ujjain</option>
                                                    <option value="Indore">Indore</option>
                                                    <option value="Udaipur">Udaipur</option>
                                                    <option value="Jodhpur">Jodhpur</option>
                                                    <option value="Prayagraj">Prayagraj</option>
                                                </select>
                                            </div>
                                        <div class="col-md-6 mt-4">
                                                 <label class="form-label font-weight-bold" for="selectState">State :</label>
                                                 <select class="select form-control-lg" name="selectState" id="selectState" required>
                                                      <option value="" selected hidden>Select</option>
                                                      <option value="Gujarat">Gujarat</option>
                                                      <option value="Maharashtra">Maharashtra</option>
                                                      <option value="Rajasthan">Rajasthan</option>
                                                      <option value="Uttar Pradesh">Uttar Pradesh</option>
                                                      <option value="Madhya Pradesh">Madhya Pradesh</option>
                                                 </select>
                                        </div>
                                    </div>
                                        <div id="error-messages" style="color: red;"></div>
                                </div>
                                <button type="button" class="btn btn-primary mt-2" id="add-address">Add Another Address</button>
                                <button type="button" class="btn btn-danger mt-2" id="remove-address">Remove Address</button>
                                <div class="mt-4 pt-2">
                                    <input type="submit" value="Submit" class="btn btn-primary" id="submit" disabled/>
                                    <input type="reset" value="Reset" class="btn btn-secondary" id="reset" />
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
        <jsp:include page="footer.jsp" />
    <script src="https://code.jquery.com/jquery-3.2.1.js"
        integrity="sha256-DZAnKJ/6XZ9si04Hgrsxu/8s717jcIzLy3oi35EouyE=" crossorigin="anonymous"></script>
    <script src="js/jquery.datetextentry.js"></script>
    <script>
        var currdate = new Date();
        var month = currdate.getMonth() + 1;
        var year = currdate.getUTCFullYear();
        var todayDate = currdate.getDate() - 3;
        if (todayDate < 10) {
            todayDate = '0' + todayDate;
        }
        if (month < 10) {
            month = '0' + month;
        }
        var maxDate = year + '-' + month + '-' + todayDate;
        $('#birthdayDate').attr('max', maxDate);

        $('#form').on('reset', function () {
            $('input[name=firstName]').removeClass('add-border-green');
            $('input[name=firstName]').addClass('add-border-red');
            $('input[name=lastName]').removeClass('add-border-green');
            $('input[name=lastName]').addClass('add-border-red');
            $('input[name=userName]').removeClass('add-border-green');
            $('input[name=userName]').addClass('add-border-red');
            $('input[name=emailAddress]').removeClass('add-border-green');
            $('input[name=emailAddress]').addClass('add-border-red');
            $('input[name=password]').removeClass('add-border-green');
            $('input[name=password]').addClass('add-border-red');
            $('input[name=cpassword]').removeClass('add-border-green');
            $('input[name=cpassword]').addClass('add-border-red');
        });

        var formValid = {
            firstname: false,
            lastname: false,
            username: false,
            birthdate: false,
            email: false,
            password: false,
            confirmPassword: false,
            contactNo: false,
            selectcity: false
        };

        function checkValidation() {
            if (formValid.firstname && formValid.lastname && formValid.email && formValid.password && formValid.confirmPassword) {
                $('#submit').removeAttr('disabled');
            } else {
                $('#submit').attr('disabled', true);
            }
        }

        $('#firstName').on('input', function () {
            var firstname = $(this).val();
            function msg(body) {
                $('#firstname-error').text(body).show();
            };
            function hide() {
                $('#firstname-error').hide();
            };
            if (firstname.length == 0) {
                msg('Please Enter Your First Name.');
                $(this).addClass('add-border-red');
                $(this).removeClass('add-border-green');
                formValid.firstname = false;
                checkValidation();
            } else {
                $(this).addClass('add-border-green');
                $(this).removeClass('add-border-red');
                hide();
                formValid.firstname = true;
                checkValidation();
                var testExp = new RegExp(/^[a-zA-Z]+$/);
                if (!testExp.test(firstname)) {
                    msg('Should not have any special characters or Numbers');
                    $(this).addClass('add-border-red');
                    $(this).removeClass('add-border-green');
                    formValid.firstname = false;
                    checkValidation();
                } else {
                    $(this).addClass('add-border-green');
                    $(this).removeClass('add-border-red');
                    hide();
                    formValid.firstname = true;
                    checkValidation();
                    if (firstname.length < 3 || firstname.length > 10) {
                        msg('Must be at least 3 characters but no more than 10');
                        $(this).addClass('add-border-red');
                        $(this).removeClass('add-border-green');
                        formValid.firstname = false;
                        checkValidation();
                    } else {
                        $(this).addClass('add-border-green');
                        $(this).removeClass('add-border-red');
                        hide();
                        formValid.firstname = true;
                        checkValidation();
                    }
                }
            }
        });

        $('#lastName').on('input', function () {
            var lastname = $(this).val();
            function msg(body) {
                $('#lastname-error').text(body).show();
            };
            function hide() {
                $('#lastname-error').hide();
            };
            if (lastname.length < 1) {
                msg('Please Enter Your Last Name.');
                $(this).addClass('add-border-red');
                $(this).removeClass('add-border-green');
                formValid.lastname = false;
                checkValidation();
            } else {
                $(this).addClass('add-border-green');
                $(this).removeClass('add-border-red');
                hide();
                formValid.lastname = true;
                checkValidation();
                var testExp = new RegExp(/^[a-zA-Z]+$/);
                if (!testExp.test(lastname)) {
                    msg('Should not have any special characters or Numbers');
                    $(this).addClass('add-border-red');
                    $(this).removeClass('add-border-green');
                    formValid.lastname = false;
                    checkValidation();
                } else {
                    $(this).addClass('add-border-green');
                    $(this).removeClass('add-border-red');
                    hide();
                    formValid.lastname = true;
                    checkValidation();
                    if (lastname.length < 3 || lastname.length > 10) {
                        msg('Must be at least 3 characters but no more than 10');
                        $(this).addClass('add-border-red');
                        $(this).removeClass('add-border-green');
                        formValid.lastname = false;
                        checkValidation();
                    } else {
                        $(this).addClass('add-border-green');
                        $(this).removeClass('add-border-red');
                        hide();
                        formValid.lastname = true;
                        checkValidation();
                    }
                }
            }
        });

        $('#userName').on('input', function () {
            var username = $(this).val();
            function msg(body) {
                $('#username-error').text(body).show();
            };
            function hide() {
                $('#username-error').hide();
            };
            if (username.length == 0) {
                msg('Please Enter Your User Name.');
                $(this).addClass('add-border-red');
                $(this).removeClass('add-border-green');
                formValid.firstname = false;
                checkValidation();
            } else {
                $(this).addClass('add-border-green');
                $(this).removeClass('add-border-red');
                hide();
                formValid.firstname = true;
                checkValidation();
                var testExp = new RegExp(/^[a-zA-Z]+$/);
                if (!testExp.test(username)) {
                    msg('Should not have any special characters or Numbers');
                    $(this).addClass('add-border-red');
                    $(this).removeClass('add-border-green');
                    formValid.firstname = false;
                    checkValidation();
                } else {
                    $(this).addClass('add-border-green');
                    $(this).removeClass('add-border-red');
                    hide();
                    formValid.firstname = true;
                    checkValidation();
                    if (username.length < 3 || username.length > 10) {
                        msg('Must be at least 3 characters but not more than 10');
                        $(this).addClass('add-border-red');
                        $(this).removeClass('add-border-green');
                        formValid.firstname = false;
                        checkValidation();
                    } else {
                        $(this).addClass('add-border-green');
                        $(this).removeClass('add-border-red');
                        hide();
                        formValid.firstname = true;
                        checkValidation();
                    }
                }
            }
        });

        $('#emailAddress').on('input', function () {
            var email = $(this).val();
            function msg(body) {
                $('#email-error').text(body).show();
            };
            function hide() {
                $('#email-error').hide();
            };
            if (email.length < 1) {
                msg('Please Enter Your Email.');
                $(this).addClass('add-border-red');
                $(this).removeClass('add-border-green');
                formValid.email = false;
                checkValidation();
            } else {
                $(this).addClass('add-border-green');
                $(this).removeClass('add-border-red');
                hide();
                formValid.email = true;
                checkValidation();
                var testExp = new RegExp(/[a-z0-9._%+-]+@[a-z0-9.-]+\.[a-z]{2,3}$/);
                if (!testExp.test(email)) {
                    msg('Enter A Valid Email Address.');
                    $(this).addClass('add-border-red');
                    $(this).removeClass('add-border-green');
                    formValid.email = false;
                    checkValidation();
                } else {
                    $(this).addClass('add-border-green');
                    $(this).removeClass('add-border-red');
                    hide();
                    formValid.email = true;
                    checkValidation();
                    if (email.length < 3 || email.length > 30) {
                        msg('Must be at least 3 characters but no more than 30');
                        $(this).addClass('add-border-red');
                        $(this).removeClass('add-border-green');
                        formValid.email = false;
                        checkValidation();
                    } else {
                        $(this).addClass('add-border-green');
                        $(this).removeClass('add-border-red');
                        hide();
                        formValid.email = true;
                        checkValidation();
                    }
                }
            }
        });

        $('#password').on('input', function () {
            var password = $(this).val();
            function msg(body) {
                $('#password-error').text(body).show();
            };
            function hide() {
                $('#password-error').hide();
            };
            if (password.length < 1) {
                msg('Please Enter Your Password.');
                $(this).addClass('add-border-red');
                $(this).removeClass('add-border-green');
                formValid.password = false;
                checkValidation();
            } else {
                $(this).addClass('add-border-green');
                $(this).removeClass('add-border-red');
                hide();
                formValid.password = true;
                checkValidation();
                if (password.length < 6 || password.length > 20) {
                    msg('Must be at least 6 characters but no more than 20');
                    $(this).addClass('add-border-red');
                    $(this).removeClass('add-border-green');
                    formValid.password = false;
                    checkValidation();
                } else {
                    $(this).addClass('add-border-green');
                    $(this).removeClass('add-border-red');
                    hide();
                    formValid.password = true;
                    checkValidation();
                }
            }
        });

        $('#cpassword').on('input', function () {
            var cpassword = $(this).val();
            function msg(body) {
                $('#cpassword-error').text(body).show();
            };
            function hide() {
                $('#cpassword-error').hide();
            };
            var password = $('#password').val();
            if (cpassword != password) {
                msg('Passwords do not match.');
                $(this).addClass('add-border-red');
                $(this).removeClass('add-border-green');
                formValid.confirmPassword = false;
                checkValidation();
            } else {
                $(this).addClass('add-border-green');
                $(this).removeClass('add-border-red');
                hide();
                formValid.confirmPassword = true;
                checkValidation();
            }
        });

        $('#contactNo').on('input', function () {
            var contactno = $(this).val();
            function msg(body) {
                $('#contact-error').text(body).show();
            };
            function hide() {
                $('#contact-error').hide();
            };
            if (contactno.length < 1) {
                msg('Please Enter Your Contact Number.');
                $(this).addClass('add-border-red');
                $(this).removeClass('add-border-green');
                formValid.contactNo = false;
                checkValidation();
            } else {
                $(this).addClass('add-border-green');
                $(this).removeClass('add-border-red');
                hide();
                formValid.contactNo = true;
                checkValidation();
                var testExp = new RegExp(/^[0-9]+$/);
                if (!testExp.test(contactno)) {
                    msg('Should not have any special characters or alphabets');
                    $(this).addClass('add-border-red');
                    $(this).removeClass('add-border-green');
                    formValid.contactNo = false;
                    checkValidation();
                } else {
                    $(this).addClass('add-border-green');
                    $(this).removeClass('add-border-red');
                    hide();
                    formValid.contactNo = true;
                    checkValidation();
                    if (contactno.length != 10) {
                        msg('Must be exactly 10 digits');
                        $(this).addClass('add-border-red');
                        $(this).removeClass('add-border-green');
                        formValid.contactNo = false;
                        checkValidation();
                    } else {
                        $(this).addClass('add-border-green');
                        $(this).removeClass('add-border-red');
                        hide();
                        formValid.contactNo = true;
                        checkValidation();
                    }
                }
            }
        });




       var cityValid = {};


       function checkValidation() {
           var allCityFieldsValid = true;


           $('[name^="selectCity"]').each(function() {
               var fieldName = $(this).attr('name');
               var cityValue = $(this).val();


               if (!cityValue) {
                   allCityFieldsValid = false;
                   cityValid[fieldName] = false;
               } else {
                   cityValid[fieldName] = true;
               }
           });


           if (
               formValid.firstname &&
               formValid.lastname &&
               formValid.email &&
               formValid.password &&
               formValid.confirmPassword &&
               formValid.contactNo &&
               allCityFieldsValid // Check if all city fields are valid
           ) {
               $('#submit').removeAttr('disabled');
           } else {
               $('#submit').attr('disabled', true);
           }
       }

       $('[name^="selectCity"]').on('change', function () {
           var cityValue = $(this).val();
           var fieldName = $(this).attr('name');

           if (!cityValue) {

               $(this).addClass('add-border-red');
               $(this).removeClass('add-border-green');
               cityValid[fieldName] = false;
           } else {

               $(this).addClass('add-border-green');
               $(this).removeClass('add-border-red');
               cityValid[fieldName] = true;
           }

           checkValidation();
       });

         $('#remove-address').hide();
         $('#add-address').on('click', function () {
            var addressFields = $('#address-fields');
            var addressCount = addressFields.find('.row').length + 1; //counts number of existing address rows within the container with class row, plus one is added to create new address field
            var newAddressField = `
                <div class="row mt-4">
                    <div class="col-md-6">
                        <label class="form-label font-weight-bold">Street Address ${addressCount} :</label>
                        <input type="text" class="form-control form-control-lg" name="address1${addressCount}" required />
                    </div>
                    <div class="col-md-3">
                        <label class="form-label font-weight-bold">Apartment No. ${addressCount} :</label>
                        <input type="text" class="form-control form-control-lg" name="apartment1${addressCount}" required />
                    </div>
                    <div class="col-md-3">
                        <label class="form-label font-weight-bold">ZIP code ${addressCount} :</label>
                        <input type="text" class="form-control form-control-lg" name="zipcode1${addressCount}" required />
                    </div>
                    <div class="col-md-6 mt-4">
                            <label class="form-label font-weight-bold">City ${addressCount} :</label>
                            <select class="select form-control-lg" name="selectCity${addressCount}" required>
                                <option value="" selected hidden>Select</option>
                                <option value="Vadodara">Vadodara</option>
                                <option value="Ahmedabad">Ahmedabad</option>
                                <option value="Surat">Surat</option>
                                <option value="Bharuch">Bharuch</option>
                                <option value="Mumbai">Mumbai</option>
                                <option value="Ujjain">Ujjain</option>
                                <option value="Indore">Indore</option>
                                <option value="Udaipur">Udaipur</option>
                                <option value="Jodhpur">Jodhpur</option>
                                <option value="Prayagraj">Prayagraj</option>
                            </select>
                        </div>
                    <div class="col-md-6 mt-4">
                             <label class="form-label font-weight-bold">State ${addressCount} :</label>
                             <select class="select form-control-lg" name="selectState${addressCount}" required>
                                <option value="" selected hidden>Select</option>
                                <option value="Vadodara">Gujarat</option>
                                <option value="Ahmedabad">Maharashtra</option>
                                <option value="Surat">Rajasthan</option>
                                <option value="Bharuch">Uttar Pradesh</option>
                                <option value="Bharuch">Madhya Pradesh</option>
                             </select>
                    </div>
                </div>
            `;

            addressFields.append(newAddressField);
            $('#remove-address').show();
        });
         $('#remove-address').on('click', function () {
                var addressFields = $('#address-fields');
                var addressCount = addressFields.find('.row').length;

                // Ensure there is at least one address section before removing
                if (addressCount > 1) {
                    // Remove the last added address section
                    addressFields.find('.row:last').remove();

                    // If there's only one address left, hide the "Remove Address" button
                    if (addressCount === 2) {
                        $('#remove-address').hide();
                    }
                }
            });
             $(document).ready(function () {
                    // Function to validate street address
                    $("#address1").on("input", function () {
                        var streetAddress = $(this).val();
                        var streetAddressPattern = /^[a-zA-Z0-9\s]+$/; // Allow only letters, numbers, and spaces
                        var isValid = streetAddressPattern.test(streetAddress);

                        var feedbackDiv = $("#streetAddressFeedback");

                        if (isValid) {
                            feedbackDiv.removeClass("invalid-feedback").addClass("valid-feedback").addClass("d-block").text("Valid");
                        } else {
                            feedbackDiv.removeClass("valid-feedback").addClass("invalid-feedback").addClass("d-block").text("Invalid street address ! No Special Characters Allowed");
                        }
                    });

                    // Function to validate apartment number
                    $("#apartment1").on("input", function () {
                        var apartmentNumber = $(this).val();
                        var apartmentNumberPattern = /^[0-9]+$/; // Allow only numbers
                        var isValid = apartmentNumberPattern.test(apartmentNumber);

                        var feedbackDiv = $("#apartmentNumberFeedback");

                        if (isValid) {
                            feedbackDiv.removeClass("invalid-feedback").addClass("valid-feedback").addClass("d-block").text("Valid");
                        } else {
                            feedbackDiv.removeClass("valid-feedback").addClass("invalid-feedback").addClass("d-block").text("Invalid apartment number. Only numbers are allowed.");
                        }
                    });

                    // Function to validate ZIP code
                    $("#zipcode1").on("input", function () {
                        var zipCode = $(this).val();
                        var zipCodePattern = /^[0-9]+$/; // Allow only numbers
                        var isValid = zipCodePattern.test(zipCode);

                        var feedbackDiv = $("#zipCodeFeedback");

                        if (isValid) {
                            feedbackDiv.removeClass("invalid-feedback").addClass("valid-feedback").addClass("d-block").text("Valid");
                        } else {
                            feedbackDiv.removeClass("valid-feedback").addClass("invalid-feedback").addClass("d-block").text("Invalid ZIP code. Only numbers are allowed.");
                        }
                    });
                });
    </script>
</body>
</html>
