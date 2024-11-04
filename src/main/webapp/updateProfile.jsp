<%@ page import="java.sql.*" %>
<%@ page import="javax.servlet.http.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Update Profile</title>
    <style>
        /* Basic Reset */
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        /* Page Styling */
        body {
            font-family: Arial, sans-serif;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            background-color: #f7fdf4; /* Light olive background */
        }
        /* Update Box Styling */
        .update-box {
            background-color: #4B8B3B; /* Olive green */
            padding: 40px;
            border-radius: 15px;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.3);
            color: white;
            width: 400px;
            text-align: center;
        }
        .update-box h2 {
            font-size: 26px;
            margin-bottom: 20px;
        }
        .update-box input[type="text"],
        .update-box input[type="submit"] {
            padding: 12px;
            margin: 10px 0;
            width: 100%;
            border-radius: 20px;
            border: none;
            font-size: 16px;
            outline: none;
            color: #4B8B3B;
            background-color: #ffffff;
            box-shadow: inset 0 2px 4px rgba(0, 0, 0, 0.1);
            transition: box-shadow 0.2s ease;
        }
        .update-box input[type="text"]:focus {
            box-shadow: inset 0 2px 6px rgba(0, 0, 0, 0.2);
        }
        .update-box input[type="submit"] {
            background-color: white;
            color: #4B8B3B;
            border: none;
            padding: 12px 20px;
            font-weight: bold;
            cursor: pointer;
            border-radius: 20px;
            transition: background-color 0.3s ease, color 0.3s ease;
        }
        .update-box input[type="submit"]:hover {
            background-color: #3f7a31;
            color: white;
        }
    </style>
</head>
<body>
<%
    // Database connection details
    String dbUrl = "jdbc:mysql://localhost:3306/IIESTS?useSSL=false";
    String dbUsername = "root";
    String dbPassword = "big19boyfever"; 

    Connection connection = null;
    PreparedStatement fetchStmt = null;
    PreparedStatement updateStmt = null;
    HttpSession userSession = request.getSession();

    // Retrieve email from session to fetch user details
    String email = (String) userSession.getAttribute("email");
    if (email == null) {
        out.println("<p>User not logged in. Please log in first.</p>");
        return;
    }

    String fullName = "";
    String dateOfBirth = "";
    String department = "";
    String collegesAttended = "";
    String position = "";
    String whenJoined = "";
    String googleScholarLink = "";

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        connection = DriverManager.getConnection(dbUrl, dbUsername, dbPassword);

        // Fetch user details from faculty_list based on email
        String fetchSql = "SELECT * FROM faculty_list WHERE email = ?";
        fetchStmt = connection.prepareStatement(fetchSql);
        fetchStmt.setString(1, email);

        ResultSet rs = fetchStmt.executeQuery();
        if (rs.next()) {
            fullName = rs.getString("name");
            dateOfBirth = rs.getString("date_of_birth");
            department = rs.getString("department");
            collegesAttended = rs.getString("colleges_attended");
            position = rs.getString("position");
            whenJoined = rs.getString("joined");
            googleScholarLink = rs.getString("website_link");
        }
        rs.close();

        // Check if the update form was submitted
        if (request.getParameter("full_name") != null) {
            // Retrieve updated values from the form
            fullName = request.getParameter("full_name");
            dateOfBirth = request.getParameter("date_of_birth");
            department = request.getParameter("department");
            collegesAttended = request.getParameter("colleges_unis_attended");
            position = request.getParameter("position");
            whenJoined = request.getParameter("when_joined");
            googleScholarLink = request.getParameter("google_scholar_link");

            // Update statement
            String updateSql = "UPDATE faculty_list SET name = ?, date_of_birth = ?, department = ?, colleges_attended = ?, position = ?, joined = ?, website_link = ? WHERE email = ?";
            updateStmt = connection.prepareStatement(updateSql);
            updateStmt.setString(1, fullName);
            updateStmt.setString(2, dateOfBirth);
            updateStmt.setString(3, department);
            updateStmt.setString(4, collegesAttended);
            updateStmt.setString(5, position);
            updateStmt.setString(6, whenJoined);
            updateStmt.setString(7, googleScholarLink);
            updateStmt.setString(8, email);

            int rowsUpdated = updateStmt.executeUpdate();
            if (rowsUpdated > 0) {
                response.sendRedirect("thankYouUp.jsp");
                return;
            } else {
                out.println("<p>Update failed. Please try again.</p>");
            }
        }
    } catch (SQLException e) {
        e.printStackTrace();
        out.println("<p>Database connection error.</p>");
    } catch (ClassNotFoundException e) {
        e.printStackTrace();
        out.println("<p>Driver not found.</p>");
    } finally {
        if (fetchStmt != null) try { fetchStmt.close(); } catch (SQLException ignore) {}
        if (updateStmt != null) try { updateStmt.close(); } catch (SQLException ignore) {}
        if (connection != null) try { connection.close(); } catch (SQLException ignore) {}
    }
%>

<div class="update-box">
    <h2>Update Profile</h2>
    <form method="post" action="updateProfile.jsp">
        <input type="text" name="full_name" placeholder="Full Name" value="<%= fullName %>" required>
        <input type="text" name="date_of_birth" placeholder="Date of Birth" value="<%= dateOfBirth %>" required>
        <input type="text" name="department" placeholder="Department" value="<%= department %>" required>
        <input type="text" name="colleges_unis_attended" placeholder="Colleges/Universities Attended" value="<%= collegesAttended %>">
        <input type="text" name="position" placeholder="Position" value="<%= position %>">
        <input type="text" name="when_joined" placeholder="When Joined" value="<%= whenJoined %>">
        <input type="text" name="google_scholar_link" placeholder="Google Scholar Link" value="<%= googleScholarLink %>">
        <input type="submit" value="Update">
    </form>
</div>
</body>
</html>
