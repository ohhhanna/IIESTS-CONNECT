<%@ page import="java.sql.*" %>
<%@ page import="javax.servlet.http.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Login</title>
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

        /* Login Box Styling */
        .login-box {
            background-color: #4B8B3B; /* Olive green */
            padding: 40px;
            border-radius: 15px;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.3);
            text-align: center;
            width: 350px;
            color: white;
        }

        .login-box h2 {
            font-size: 26px;
            margin-bottom: 25px;
        }

        .login-box input[type="text"],
        .login-box input[type="email"],
        .login-box input[type="password"] {
            padding: 12px;
            margin: 15px 0;
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

        .login-box input[type="text"]:focus,
        .login-box input[type="email"]:focus,
        .login-box input[type="password"]:focus {
            box-shadow: inset 0 2px 6px rgba(0, 0, 0, 0.2);
        }

        .login-box input[type="submit"] {
            background-color: white;
            color: #4B8B3B;
            border: none;
            padding: 12px 20px;
            font-weight: bold;
            cursor: pointer;
            border-radius: 20px;
            transition: background-color 0.3s ease, color 0.3s ease;
            width: 100%;
        }

        .login-box input[type="submit"]:hover {
            background-color: #3f7a31;
            color: white;
        }

        .error-message {
            color: #ffcccb;
            margin-top: 15px;
            font-size: 0.9em;
        }
    </style>
</head>
<body>
    <div class="login-box">
        <h2>Login</h2>
        
        <%
            HttpSession userSession = request.getSession();
            Integer attempts = (Integer) userSession.getAttribute("attempts");
            if (attempts == null) {
                attempts = 0;
            }

            String employeeId = request.getParameter("employee_id");
            String email = request.getParameter("email");
            String password = request.getParameter("password");

            boolean loginSuccess = false;
            String errorMessage = "";

            String dbUrl = "jdbc:mysql://localhost:3306/IIESTS?useSSL=false";
            String dbUsername = "root";
            String dbPassword = "big19boyfever"; 

            if (employeeId != null && email != null && password != null) {
                try {
                    Class.forName("com.mysql.cj.jdbc.Driver");
                    Connection conn = DriverManager.getConnection(dbUrl, dbUsername, dbPassword);
                    String sql = "SELECT * FROM faculty_list WHERE employee_id = ? AND email = ? AND password = ?";
                    PreparedStatement stmt = conn.prepareStatement(sql);
                    stmt.setInt(1, Integer.parseInt(employeeId));
                    stmt.setString(2, email);
                    stmt.setString(3, password);

                    ResultSet rs = stmt.executeQuery();
                    if (rs.next()) {
                        loginSuccess = true;
                        userSession.setAttribute("attempts", 0);

                        // Fetch user details from faculty_list table
                        userSession.setAttribute("fullName", rs.getString("full_name"));
                        userSession.setAttribute("dateOfBirth", rs.getString("date_of_birth"));
                        userSession.setAttribute("department", rs.getString("department"));
                        userSession.setAttribute("collegesAttended", rs.getString("colleges_unis_attended"));
                        userSession.setAttribute("position", rs.getString("position"));
                        userSession.setAttribute("whenJoined", rs.getString("when_joined"));
                        userSession.setAttribute("googleScholarLink", rs.getString("google_scholar_link"));

                        // Redirect to the update profile page
                        response.sendRedirect("updateProfile.jsp");
                        return;
                    } else {
                        attempts++;
                        userSession.setAttribute("attempts", attempts);
                        errorMessage = "Invalid credentials. Please try again.";
                    }

                    rs.close();
                    stmt.close();
                    conn.close();
                } catch (Exception e) {
                    e.printStackTrace();
                    errorMessage = "Database connection error.";
                }
            }

            if (attempts >= 3) {
                userSession.setAttribute("attempts", 0);
                response.sendRedirect("register.jsp");
                return;
            }
        %>
        
        <form method="post" action="login.jsp">
            <input type="text" name="employee_id" placeholder="Employee ID" required>
            <input type="email" name="email" placeholder="Email" required>
            <input type="password" name="password" placeholder="Password" required>
            <input type="submit" value="Login">
        </form>
        
        <% if (!loginSuccess && !errorMessage.isEmpty()) { %>
            <p class="error-message"><%= errorMessage %></p>
        <% } %>
    </div>
</body>
</html>
