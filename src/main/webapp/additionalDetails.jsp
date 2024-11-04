<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Full Registration</title>
    <style>
        /* Basic styling */
        body {
            font-family: Arial, sans-serif;
            background-color: #f0f4f1; /* Light background */
            margin: 0;
            padding: 0;
        }
        .registration-container {
            max-width: 600px;
            margin: 50px auto;
            padding: 30px;
            background-color: #4B8B3B; /* Olive green background */
            color: white;
            border-radius: 10px;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.2);
        }
        .registration-container h2 {
            text-align: center;
            margin-bottom: 20px;
        }
        .form-control {
            margin-bottom: 15px;
        }
        .form-control label {
            display: block;
            margin-bottom: 5px;
        }
        .form-control input {
            width: 100%;
            padding: 10px;
            border: none;
            border-radius: 5px;
            box-sizing: border-box;
        }
        .form-control input[type="text"],
        .form-control input[type="date"],
        .form-control input[type="url"] {
            background-color: #e6f2e6; /* Light green for input fields */
            color: #333;
        }
        .form-control input[type="text"]:focus,
        .form-control input[type="date"]:focus,
        .form-control input[type="url"]:focus {
            outline: none;
            border: 2px solid #a1d6a1; /* Darker green on focus */
        }
        .submit-btn {
            background-color: #ffffff; /* White background for button */
            color: #4B8B3B; /* Olive green text */
            padding: 10px 20px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-weight: bold;
            width: 100%;
            transition: background-color 0.3s;
        }
        .submit-btn:hover {
            background-color: #d1d1d1; /* Light grey on hover */
        }
    </style>
</head>
<body>

<div class="registration-container">
    <h2>Full Registration</h2>
    <form action="additionalDetails.jsp" method="post">
        <div class="form-control">
            <label for="full_name">Full Name:</label>
            <input type="text" id="full_name" name="full_name" required>
        </div>
        <div class="form-control">
            <label for="dob">Date of Birth:</label>
            <input type="date" id="dob" name="date_of_birth" required>
        </div>
        <div class="form-control">
            <label for="department">Department:</label>
            <input type="text" id="department" name="department" required>
        </div>
        <div class="form-control">
            <label for="colleges">Colleges/Universities Attended:</label>
            <input type="text" id="colleges" name="colleges_unis_attended">
        </div>
        <div class="form-control">
            <label for="position">Position:</label>
            <input type="text" id="position" name="position">
        </div>
        <div class="form-control">
            <label for="when_joined">When Joined:</label>
            <input type="date" id="when_joined" name="when_joined">
        </div>
        <div class="form-control">
            <label for="scholar_link">Google Scholar Link:</label>
            <input type="url" id="scholar_link" name="google_scholar_link">
        </div>
        <input type="hidden" name="employee_id" value="<%= request.getParameter("employee_id") %>">
        <input type="hidden" name="email" value="<%= request.getParameter("email") %>">
        <button type="submit" class="submit-btn">Complete Registration</button>
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
            String fullName = request.getParameter("full_name");
            String dateOfBirth = request.getParameter("date_of_birth");
            String department = request.getParameter("department");
            String colleges = request.getParameter("colleges_unis_attended");
            String position = request.getParameter("position");
            String whenJoined = request.getParameter("when_joined");
            String scholarLink = request.getParameter("google_scholar_link");
            String employeeId = request.getParameter("employee_id");
            String email = request.getParameter("email");

            // Connect to the database
            Class.forName("com.mysql.cj.jdbc.Driver");
            connection = DriverManager.getConnection(dbUrl, dbUsername, dbPassword);

            // Insert into Faculty
            String sql = "INSERT INTO Faculty (full_name, date_of_birth, email, department, colleges_unis_attended, position, when_joined, google_scholar_link) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
            stmt = connection.prepareStatement(sql);
            stmt.setString(1, fullName);
            stmt.setString(2, dateOfBirth);
            stmt.setString(3, email);
            stmt.setString(4, department);
            stmt.setString(5, colleges);
            stmt.setString(6, position);
            stmt.setString(7, whenJoined);
            stmt.setString(8, scholarLink);
            stmt.executeUpdate();

            // Redirect to thank you page
            response.sendRedirect("thankYou.jsp");
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
