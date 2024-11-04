<%@ page import="java.sql.*" %>
<%@ page import="javax.servlet.http.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Login Alum</title>
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
            background-color: #f2f5f2; /* Subtle background color */
        }

        /* Login Box Styling */
        .login-box {
            background-color: #4B8B3B; /* Olive green */
            padding: 50px;
            border-radius: 12px;
            box-shadow: 0 10px 20px rgba(0, 0, 0, 0.3); /* Deeper shadow for a floating effect */
            text-align: center;
            width: 320px;
            color: white;
            transition: transform 0.3s ease;
        }
        .login-box:hover {
            transform: translateY(-5px); /* Slight lift on hover */
            box-shadow: 0 15px 25px rgba(0, 0, 0, 0.3); /* Stronger shadow on hover */
        }
        .login-box h2 {
            font-size: 28px;
            margin-bottom: 25px;
            letter-spacing: 1px;
        }
        .login-box form {
            display: flex;
            flex-direction: column;
        }
        .login-box input[type="text"],
        .login-box input[type="email"],
        .login-box input[type="password"] {
            padding: 12px;
            margin: 10px 0;
            border-radius: 8px;
            border: none;
            font-size: 16px;
            box-shadow: inset 0 2px 5px rgba(0, 0, 0, 0.1);
        }
        .login-box input[type="submit"] {
            background-color: white;
            color: #4B8B3B;
            border: none;
            padding: 14px;
            font-weight: bold;
            cursor: pointer;
            border-radius: 8px;
            transition: background-color 0.3s ease, color 0.3s ease;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.2);
        }
        .login-box input[type="submit"]:hover {
            background-color: #3f7a31;
            color: white;
            box-shadow: 0 6px 15px rgba(0, 0, 0, 0.3);
        }
        .error-message {
            color: #FFD1D1;
            margin-top: 15px;
            font-size: 14px;
            font-weight: bold;
            text-shadow: 0 1px 2px rgba(0, 0, 0, 0.2);
        }
    </style>
</head>
<body>
    <div class="login-box">
        <h2>Alumni Login</h2>
        
        <%
            // Retrieve the session to store the attempt count with a different variable name
            HttpSession userSession = request.getSession();
            Integer attempts = (Integer) userSession.getAttribute("attempts");
            if (attempts == null) {
                attempts = 0;
            }

            String name = request.getParameter("name");
            String email = request.getParameter("email");
            String password = request.getParameter("password");

            boolean loginSuccess = false;
            String errorMessage = "";

            String dbUrl = "jdbc:mysql://localhost:3306/IIEST?useSSL=false";
            String dbUsername = "root";
            String dbPassword = "big19boyfever";

            if (name != null && email != null && password != null) {
                try {
                    Class.forName("com.mysql.cj.jdbc.Driver");
                    Connection conn = DriverManager.getConnection(dbUrl, dbUsername, dbPassword);
                    String sql = "SELECT * FROM Alum WHERE name = ? AND email = ? AND password = ?";
                    PreparedStatement stmt = conn.prepareStatement(sql);
                    stmt.setString(1, name);
                    stmt.setString(2, email);
                    stmt.setString(3, password);

                    ResultSet rs = stmt.executeQuery();
                    if (rs.next()) {
                        loginSuccess = true;
                        userSession.setAttribute("attempts", 0);
                        response.sendRedirect("update.jsp");
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
        
        <form method="post" action="loginAlum.jsp">
            <input type="text" name="name" placeholder="Name" required>
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
