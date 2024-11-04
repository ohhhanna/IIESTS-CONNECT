<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Alumni Signup</title>
    <style>
        /* Basic styling */
        body {
            font-family: Arial, sans-serif;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            background-color: #f9f9f9;
            margin: 0;
        }
        .signup-form {
            background-color: #4B8B3B;
            color: white;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.2);
            width: 350px;
            text-align: center;
        }
        .signup-form h2 {
            margin-bottom: 20px;
        }
        .form-control {
            margin-bottom: 15px;
            text-align: left;
        }
        .form-control label {
            display: block;
            margin-bottom: 5px;
        }
        .form-control input {
            width: 100%;
            padding: 8px;
            border: none;
            border-radius: 5px;
            box-sizing: border-box;
        }
        .submit-btn {
            background-color: white;
            color: #4B8B3B;
            padding: 10px 20px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-weight: bold;
            width: 100%;
        }
        .error {
            color: red;
        }
    </style>
</head>
<body>

<div class="signup-form">
    <h2>Alumni Signup</h2>
    <form action="signupAlum.jsp" method="post">
        <div class="form-control">
            <label for="email">Email Address</label>
            <input type="email" id="email" name="email" required>
        </div>
        <div class="form-control">
            <label for="password">Password</label>
            <input type="password" id="password" name="password" required>
        </div>
        <button type="submit" class="submit-btn">Next</button>
    </form>
    <div class="error">
        <% 
            if (request.getParameter("error") != null) { 
                out.println("Email already exists. Please choose another one."); 
            } 
        %>
    </div>
</div>

<%
    // Database connection details
    String dbUrl = "jdbc:mysql://localhost:3306/IIEST?useSSL=false";
    String dbUsername = "root";
    String dbPassword = "big19boyfever";

    Connection connection = null;
    PreparedStatement stmt = null;

    try {
        // Check if the request method is POST
        if ("POST".equalsIgnoreCase(request.getMethod())) {
            // Get form data
            String email = request.getParameter("email");
            String password = request.getParameter("password");

            // Connect to the database
            Class.forName("com.mysql.cj.jdbc.Driver");
            connection = DriverManager.getConnection(dbUrl, dbUsername, dbPassword);

            // Insert into alum_users
            String sql = "INSERT INTO alum_users (email, password) VALUES (?, ?)";
            stmt = connection.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
            stmt.setString(1, email);
            stmt.setString(2, password);
            stmt.executeUpdate();

            // Get generated keys
            ResultSet rs = stmt.getGeneratedKeys();
            if (rs.next()) {
                int generatedId = rs.getInt(1); // This is your alum_id
                System.out.println("Generated alum_id: " + generatedId);
            }

            // Redirect to additionalAlum.jsp with email
            response.sendRedirect("additionalAlum.jsp?email=" + email);
        }
    } catch (SQLException e) {
        // Check if the error is a duplicate entry error
        if (e.getErrorCode() == 1062) {
            // Redirect back to the form with an error message
            response.sendRedirect("signupAlum.jsp?error=true");
        } else {
            e.printStackTrace();
        }
    } catch (ClassNotFoundException e) {
        e.printStackTrace();
    } finally {
        if (stmt != null) try { stmt.close(); } catch (SQLException ignore) {}
        if (connection != null) try { connection.close(); } catch (SQLException ignore) {}
    }
%>
</body>
</html>
