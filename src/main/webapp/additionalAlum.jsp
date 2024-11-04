<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Additional Alumni Details</title>
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
    <h2>Additional Alumni Details</h2>
    <form action="additionalAlum.jsp" method="post">
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
            <label for="website_link">Website Link:</label>
            <input type="url" id="website_link" name="website_link">
        </div>
        <div class="form-control">
            <label for="year_passed_out">Year Passed Out:</label>
            <input type="text" id="year_passed_out" name="year_passed_out" required>
        </div>
        <div class="form-control">
            <label for="discipline">Discipline:</label>
            <input type="text" id="discipline" name="discipline">
        </div>
        <div class="form-control">
            <label for="years_in_college">Years in College:</label>
            <input type="text" id="years_in_college" name="years_in_college">
        </div>
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
            String websiteLink = request.getParameter("website_link");
            String yearPassedOut = request.getParameter("year_passed_out");
            String discipline = request.getParameter("discipline");
            String yearsInCollege = request.getParameter("years_in_college");
            String email = request.getParameter("email");

            // Connect to the database
            Class.forName("com.mysql.cj.jdbc.Driver");
            connection = DriverManager.getConnection(dbUrl, dbUsername, dbPassword);

            // Insert into aluminit
            String sql = "INSERT INTO aluminit (full_name, date_of_birth, email, website_link, year_passed_out, department, discipline, years_in_college) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
            stmt = connection.prepareStatement(sql);
            stmt.setString(1, fullName);
            stmt.setString(2, dateOfBirth);
            stmt.setString(3, email);
            stmt.setString(4, websiteLink);
            stmt.setString(5, yearPassedOut);
            stmt.setString(6, department);
            stmt.setString(7, discipline);
            stmt.setString(8, yearsInCollege);
            stmt.executeUpdate();

            // Redirect to thankYou.jsp
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
