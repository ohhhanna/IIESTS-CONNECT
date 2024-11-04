<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Faculty Signup</title>
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
    </style>
</head>
<body>

<div class="signup-form">
    <h2>Faculty Signup</h2>
    <form action="processSignup.jsp" method="post">
        <div class="form-control">
            <label for="email">Email Address</label>
            <input type="email" id="email" name="email" required>
        </div>
        <div class="form-control">
            <label for="employee_id">Employee ID</label>
            <input type="text" id="employee_id" name="employee_id" required>
        </div>
        <div class="form-control">
            <label for="password">Password</label>
            <input type="password" id="password" name="password" required>
        </div>
        <button type="submit" class="submit-btn">Next</button>
    </form>
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
            String employeeId = request.getParameter("employee_id");
            String password = request.getParameter("password");

            // Connect to the database
            Class.forName("com.mysql.cj.jdbc.Driver");
            connection = DriverManager.getConnection(dbUrl, dbUsername, dbPassword);

            // Insert into Faculty_users
            String sql = "INSERT INTO Faculty_users (employee_id, email, password) VALUES (?, ?, ?)";
            stmt = connection.prepareStatement(sql);
            stmt.setInt(1, Integer.parseInt(employeeId));
            stmt.setString(2, email);
            stmt.setString(3, password);
            stmt.executeUpdate();

            // Redirect to additionalDetails.jsp with employee_id and email
            response.sendRedirect("additionalDetails.jsp?employee_id=" + employeeId + "&email=" + email);
        }
    } catch (SQLException e) {
        e.printStackTrace();
    } catch (ClassNotFoundException e) {
        e.printStackTrace();
    } finally {
        if (stmt != null) try { stmt.close(); } catch (SQLException ignore) {}
        if (connection != null) try { connection.close(); } catch (SQLException ignore) {}
    }
%>
</body>
</html>
