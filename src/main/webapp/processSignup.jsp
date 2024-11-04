<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Processing Signup</title>
</head>
<body>
<%
    // Collect parameters from the signup form
    String email = request.getParameter("email");
    String employeeId = request.getParameter("employee_id");
    String password = request.getParameter("password");

    // Database credentials
    String dbUrl = "jdbc:mysql://localhost:3306/IIEST?useSSL=false";
    String dbUsername = "root";
    String dbPassword = "big19boyfever";

    Connection connection = null;
    PreparedStatement statement = null;

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        connection = DriverManager.getConnection(dbUrl, dbUsername, dbPassword);

        // Insert into Faculty_users table
        String sqlUsers = "INSERT INTO Faculty_users (employee_id, email, password) VALUES (?, ?, ?)";
        statement = connection.prepareStatement(sqlUsers);
        statement.setInt(1, Integer.parseInt(employeeId));
        statement.setString(2, email);
        statement.setString(3, password);
        statement.executeUpdate();

        // Redirect to the full registration page
        response.sendRedirect("additionalDetails.jsp");
    } catch (Exception e) {
        e.printStackTrace();
        // Optionally handle the error, e.g., display an error message
    } finally {
        if (statement != null) try { statement.close(); } catch (SQLException ignore) {}
        if (connection != null) try { connection.close(); } catch (SQLException ignore) {}
    }
%>
</body>
</html>
