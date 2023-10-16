package com.webapp.dao;

import com.webapp.model.Address;
import com.webapp.model.User;
import com.webapp.util.DBConnection;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Base64;


public class UserDAO {
    public boolean isUsernameExists(String username) {
        try (Connection con = DBConnection.getConnection();
             PreparedStatement preparedStatement = con.prepareStatement("SELECT COUNT(*) FROM user_login WHERE user_name = ?")) {
            preparedStatement.setString(1, username);
            try (ResultSet resultSet = preparedStatement.executeQuery()) {
                if (resultSet.next()) {
                    int count = resultSet.getInt(1);
                    return count > 0;
                }
            }
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean isEmailExists(String email) {
        try (Connection con = DBConnection.getConnection();
             PreparedStatement preparedStatement = con.prepareStatement("SELECT COUNT(*) FROM user_login WHERE email = ?")) {
            preparedStatement.setString(1, email);
            try (ResultSet resultSet = preparedStatement.executeQuery()) {
                if (resultSet.next()) {
                    int count = resultSet.getInt(1);
                    return count > 0;
                }
            }
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean registerUser(String username, String password, String firstName, String lastName,
                                String email, String contact, String gender, String role,
                                String[] streetAddresses, String[] apartmentNumbers, String[] zipCodes,
                                String[] cities, String[] states) {
        try (Connection con = DBConnection.getConnection()) {
            // Check if the username or email already exists
            if (isUsernameExists(username)) {
                return false; // Username already exists
            }
            if (isEmailExists(email)) {
                return false; // Email already exists
            }

            // Continue with user registration
            String userInsertQuery = "INSERT INTO user_login (user_name, user_pass, first_name, last_name, email, contact, gender, role)"
                    + " VALUES (?, ?, ?, ?, ?, ?, ?, ?)";

            // Use a PreparedStatement for user insertion
            try (PreparedStatement userInsertStmt = con.prepareStatement(userInsertQuery, PreparedStatement.RETURN_GENERATED_KEYS)) {
                userInsertStmt.setString(1, username);
                userInsertStmt.setString(2, password);
                userInsertStmt.setString(3, firstName);
                userInsertStmt.setString(4, lastName);
                userInsertStmt.setString(5, email);
                userInsertStmt.setString(6, contact);
                userInsertStmt.setString(7, gender);
                userInsertStmt.setString(8, role);

                int userInsertResult = userInsertStmt.executeUpdate();

                if (userInsertResult > 0) {
                    // Retrieve the user's ID after inserting
                    ResultSet generatedKeys = userInsertStmt.getGeneratedKeys();
                    int userId = -1;
                    if (generatedKeys.next()) {
                        userId = generatedKeys.getInt(1);
                    }

                    // Insert address information into the address table
                    String addressInsertQuery = "INSERT INTO user_addresses (user_id, street_address, apartment_number, zip_code, city, state)"
                            + " VALUES (?, ?, ?, ?, ?, ?)";

                    try (PreparedStatement addressInsertStmt = con.prepareStatement(addressInsertQuery)) {
                        for (int i = 0; i < streetAddresses.length; i++) {
                            addressInsertStmt.setInt(1, userId);
                            addressInsertStmt.setString(2, streetAddresses[i]);
                            addressInsertStmt.setString(3, apartmentNumbers[i]);
                            addressInsertStmt.setString(4, zipCodes[i]);
                            addressInsertStmt.setString(5, cities[i]);
                            addressInsertStmt.setString(6, states[i]);


                            int addressInsertResult = addressInsertStmt.executeUpdate();

                            if (addressInsertResult <= 0) {
                                return false; // Failed to insert user address
                            }
                        }
                    }

                    return true; // Registration successful
                } else {
                    return false; // Failed to add user
                }
            }
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
            return false; // Database error
        }
    }

    public static boolean isUsernameRegistered(String username) {
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;

        try {
            conn = DBConnection.getConnection();
            String query = "SELECT COUNT(*) FROM user_login WHERE user_name = ? ";
            stmt = conn.prepareStatement(query);
            stmt.setString(1, username);
//            stmt.setString(2, password);
            rs = stmt.executeQuery();

            if (rs.next()) {
                int count = rs.getInt(1);
                return count > 0; // If count is greater than 0, the username is registered
            }

            return false;
        } catch (SQLException | ClassNotFoundException e) {
            throw new RuntimeException(e);
        } finally {
            try {
                if (rs != null) {
                    rs.close();
                }
                if (stmt != null) {
                    stmt.close();
                }
                if (conn != null) {
                    conn.close();
                }
            } catch (SQLException e) {
                // Handle any cleanup or error here
                e.printStackTrace();
            }
        }
    }
    public static int authenticateUserAndGetId(String username, String password) {
        try (Connection con = DBConnection.getConnection();
             PreparedStatement preparedStatement = con.prepareStatement("SELECT user_id, user_pass FROM user_login WHERE user_name = ?")) {
            preparedStatement.setString(1, username);
            try (ResultSet resultSet = preparedStatement.executeQuery()) {
                if (resultSet.next()) {
                    String storedEncodedPwd = resultSet.getString("user_pass");
                    String decodedPassword = new String(Base64.getDecoder().decode(storedEncodedPwd));

                    if (decodedPassword.equals(password)) {
                        return resultSet.getInt("user_id"); // Return the user_id if authentication is successful
                    }
                }
            }
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
        }
        return -1; // Authentication failed or an error occurred
    }

    public static String getUserRole(String username) {    //for loginservlet
        try (Connection con = DBConnection.getConnection();
             PreparedStatement preparedStatement = con.prepareStatement("SELECT role FROM user_login WHERE user_name = ?")) {
            preparedStatement.setString(1, username);
            try (ResultSet resultSet = preparedStatement.executeQuery()) {
                if (resultSet.next()) {
                    return resultSet.getString("role");
                }
            }
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
        }
        return null; // User not found or error occurred
    }

    public List<User> getAllUsers() throws SQLException, ClassNotFoundException {
        List<User> userList = new ArrayList<>();

        try (Connection con = DBConnection.getConnection();
             PreparedStatement preparedStatement = con.prepareStatement("SELECT user_name, first_name, last_name, email, contact, gender, user_id, role FROM user_login");
             ResultSet resultSet = preparedStatement.executeQuery()) {

            while (resultSet.next()) {
                String userName = resultSet.getString("user_name");
                String firstName = resultSet.getString("first_name");
                String lastName = resultSet.getString("last_name");
                String email = resultSet.getString("email");
                String contact = resultSet.getString("contact");
                String gender = resultSet.getString("gender");
                int userId = resultSet.getInt("user_id");
                String role = resultSet.getString("role");


                User user = new User(userName, firstName, lastName, email, contact, gender,userId, role);
                userList.add(user);
            }
        }

        return userList;
    }

    public static boolean updateUserAndAddresses(User user, List<Address> addresses) throws SQLException {
        try (Connection conn = DBConnection.getConnection()) {
            conn.setAutoCommit(false); // Start a transaction

            // Update user information
            String updateUserSQL = "UPDATE user_login SET first_name=?, last_name=?, email=?, contact=?, gender=? WHERE user_id=?";
            try (PreparedStatement updateUserStmt = conn.prepareStatement(updateUserSQL)) {
                updateUserStmt.setString(1, user.getFirstName());
                updateUserStmt.setString(2, user.getLastName());
                updateUserStmt.setString(3, user.getEmail());
                updateUserStmt.setString(4, user.getContact());
                updateUserStmt.setString(5, user.getGender());
                updateUserStmt.setInt(6, user.getUserId());
                System.out.println("fname : " +user.getFirstName());
                System.out.println("lname :" +user.getLastName());
                System.out.println("email : " +user.getEmail());
                System.out.println("contact :" +user.getContact());
                int userUpdateCount = updateUserStmt.executeUpdate();

                if (userUpdateCount <= 0) {
                    conn.rollback(); // Rollback if user update fails
                    return false;
                }
            }

            // Update addresses
            String updateAddressSQL = "UPDATE user_addresses SET street_address=?, apartment_number=?, zip_code=?, city=?, state=? WHERE address_id=?";
            try (PreparedStatement updateAddressStmt = conn.prepareStatement(updateAddressSQL)) {
                for (Address address : addresses) {
                    updateAddressStmt.setString(1, address.getAddress1());
                    updateAddressStmt.setString(2, address.getApartment1());
                    updateAddressStmt.setString(3, address.getZipcode1());
                    updateAddressStmt.setString(4, address.getSelectCity());
                    updateAddressStmt.setString(5, address.getSelectState());
                    updateAddressStmt.setInt(6, address.getAddressId());
                    System.out.println("Updating Address - ID: " + address.getAddressId());
                    System.out.println("Street Address: " + address.getAddress1());
                    System.out.println("Apartment Number: " + address.getApartment1());
                    System.out.println("Zip Code: " + address.getZipcode1());
                    System.out.println("City: " + address.getSelectCity());
                    System.out.println("State: " + address.getSelectState());

                    int addressUpdateCount = updateAddressStmt.executeUpdate();
                    if (addressUpdateCount <= 0) {
                        conn.rollback(); // Rollback if any address update fails
                        return false;
                    }

                }
            }

            conn.commit(); // Commit the transaction if everything is successful
            return true;
        } catch (SQLException e) {
            // Handle database-related exceptions here
            e.printStackTrace(); // Log the exception for debugging
            throw e; // Rethrow the exception to indicate failure
        } catch (ClassNotFoundException e) {
            throw new RuntimeException(e);
        }
    }

    public boolean deleteAddress(int addressId) throws SQLException {
        Connection conn = null;
        PreparedStatement stmt;

        try {
            conn = DBConnection.getConnection();
            String query = "DELETE FROM user_addresses WHERE address_id = ?";
            stmt = conn.prepareStatement(query);
            stmt.setInt(1, addressId);

            int rowsAffected = stmt.executeUpdate();

            if(rowsAffected > 0){
                System.out.println("Row Removed successfully");
            }
            // Check if the deletion was successful
            return rowsAffected > 0;
        } catch (ClassNotFoundException e) {
            throw new RuntimeException(e);
        } finally {
            assert conn != null;
            conn.close();
        }
    }

    public boolean saveaddress(Address address){   //for adding another address
        int rowAffected;
        try{
            Connection conn = DBConnection.getConnection();
            PreparedStatement pst = conn.prepareStatement("INSERT INTO user_addresses (user_id, street_address, apartment_number, zip_code, city, state) VALUES (?, ?, ?, ?, ?, ?)");
            pst.setInt(1,address.getUserId());
            pst.setString(2, address.getAddress1());
            pst.setString(3, address.getApartment1());
            pst.setString(4,address.getZipcode1());
            pst.setString(5,address.getSelectCity());
            pst.setString(6,address.getSelectState());
            rowAffected = pst.executeUpdate();

        } catch (SQLException | ClassNotFoundException e) {
            throw new RuntimeException(e);
        }

        return rowAffected > 0;
    }

    public List<Address> getAddressByUserId(int userId){
        List<Address> addresses = new ArrayList<>();
        try {
            Connection conn = DBConnection.getConnection();
            String query = "select * from user_addresses where user_id=?";
            PreparedStatement preparedStatement = conn.prepareStatement(query);
            preparedStatement.setInt(1, userId);
            ResultSet set = preparedStatement.executeQuery();
            while (set.next()){
                Address address = new Address();
                address.setUserId(set.getInt(1));
                address.setAddress1(set.getString(2));
                address.setApartment1(set.getString(3));
                address.setZipcode1(set.getString(4));
                address.setSelectCity(set.getString(5));
                address.setSelectState(set.getString(6));
                address.setAddressId(set.getInt(7));
                addresses.add(address);
            }

            preparedStatement.close();

        }catch (Exception ignored){

        }

        return addresses;

    }

    public static User getUserById(int id){
        User user = new User();
        try {
            Connection conn = DBConnection.getConnection();
            PreparedStatement pst = conn.prepareStatement("SELECT * FROM user_login WHERE user_id=?");
            pst.setInt(1,id);
            ResultSet rs = pst.executeQuery();
            if(rs.next()){
                user.setUserName(rs.getString(1));
                user.setPassword(rs.getString(2));
                user.setFirstName(rs.getString(3));
                user.setLastName(rs.getString(4));
                user.setEmail(rs.getString(5));
                user.setContact(rs.getString(6));
                user.setGender(rs.getString(7));
                user.setUserId(rs.getInt(8));
                user.setRole(rs.getString(9));
            }
           pst.close();
        } catch (SQLException | ClassNotFoundException e) {
            throw new RuntimeException(e);
        }
        return user;
    }
    public boolean deleteUser(int userId) {
        // Define the SQL query to delete the user by their ID
        String deleteQuery = "DELETE FROM user_login WHERE user_id = ?";

        // Initialize the database connection and prepared statement
        try (Connection connection = DBConnection.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(deleteQuery)) {

            // Set the user ID in the prepared statement
            preparedStatement.setInt(1, userId);

            // Execute the delete query
            int rowsAffected = preparedStatement.executeUpdate();

            // Check if any rows were affected (user deleted)
            return rowsAffected > 0;

        } catch (SQLException e) {
            // Handle any SQL exceptions here
            e.printStackTrace();
            return false;
        } catch (ClassNotFoundException e) {
            throw new RuntimeException(e);
        }
    }
    public static int getUserIdByUsername(String username) throws SQLException, ClassNotFoundException {
        int userId = -1;

        try (Connection con = DBConnection.getConnection();
             PreparedStatement preparedStatement = con.prepareStatement("SELECT user_id FROM user_login WHERE user_name = ?")) {
            preparedStatement.setString(1, username);
            try (ResultSet resultSet = preparedStatement.executeQuery()) {
                if (resultSet.next()) {
                    userId = resultSet.getInt("user_id");
                }
            }
        }

        return userId;
    }

    public static List<Address> fetchUserAddresses(int userId) {
        List<Address> addresses = new ArrayList<>();

        try {
            // Modify the SQL query to fetch addresses based on the user's identifier (e.g., user_id)
            try (Connection con = DBConnection.getConnection();
                 PreparedStatement preparedStatement = con.prepareStatement("SELECT street_address, apartment_number, zip_code, city, state, address_id FROM user_addresses WHERE user_id = ?")) {
                preparedStatement.setInt(1, userId);
                try (ResultSet resultSet = preparedStatement.executeQuery()) {
                    while (resultSet.next()) {
                        String streetAddress = resultSet.getString("street_address");
                        String apartmentNumber = resultSet.getString("apartment_number");
                        String zipCode = resultSet.getString("zip_code");
                        String city = resultSet.getString("city");
                        String state = resultSet.getString("state");
                        int addressId = resultSet.getInt("address_id");

                        Address address = new Address(streetAddress, apartmentNumber, zipCode, city, state, addressId);
                        addresses.add(address);
                    }
                }
            }
        } catch (SQLException | ClassNotFoundException e) {
            // Handle any exceptions here
            e.printStackTrace();
        }

        return addresses;
    }

    public static boolean updateUserPassword(String email, String newPassword) {   //while resetting pw during forgotpw functionality
        Connection con = null;
        PreparedStatement pst = null;

        try {
            con = DBConnection.getConnection();
            pst = con.prepareStatement("UPDATE user_login SET user_pass = ? WHERE email = ?");
            pst.setString(1, newPassword);
            pst.setString(2, email);

            int rowCount = pst.executeUpdate();
            return rowCount > 0;
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
            return false;
        } finally {
            try {
                if (pst != null) {
                    pst.close();
                }
                if (con != null) {
                    con.close();
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }

    public static int checkEmailExistence(String email) {   //for forgot pw functionality
        int emailCount = 0;
        Connection con = null;
        PreparedStatement emailCheckStmt;
        ResultSet emailCheckResult;

        try {
            con = DBConnection.getConnection();
            String emailCheckQuery = "SELECT COUNT(*) FROM user_login WHERE email = ?";
            emailCheckStmt = con.prepareStatement(emailCheckQuery);
            emailCheckStmt.setString(1, email);
            emailCheckResult = emailCheckStmt.executeQuery();
            if (emailCheckResult.next()) {
                emailCount = emailCheckResult.getInt(1);
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                if (con != null) {
                    con.close();
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }


    }

        return emailCount;
    }
}


