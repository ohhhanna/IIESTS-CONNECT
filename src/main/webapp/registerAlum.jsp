<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Register</title>
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
            background-color: #f9f9f9; /* Light background */
        }

        /* Centered Box Styling */
        .register-box {
            background-color: #4B8B3B; /* Olive green */
            padding: 40px;
            border-radius: 10px;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.2);
            text-align: center;
            width: 300px;
            color: white;
        }
        .register-box h2 {
            font-size: 24px;
            margin-bottom: 20px;
        }
        .register-box p {
            font-size: 16px;
            margin-bottom: 30px;
        }
        .register-box a {
            display: inline-block;
            width: 100%;
            padding: 12px;
            margin: 10px 0;
            text-decoration: none;
            color: #4B8B3B;
            background-color: white;
            border-radius: 5px;
            font-weight: bold;
            transition: background-color 0.3s ease, color 0.3s ease;
        }
        .register-box a:hover {
            background-color: #3f7a31;
            color: white;
        }
    </style>
</head>
<body>
    <!-- Centered Box with Login and Signup Links -->
    <div class="register-box">
        <h2>Welcome!</h2>
        <p>Select an option to get started:</p>
        <a href="loginAlum.jsp">Login</a>
        <a href="signupAlum.jsp">Sign Up</a>
    </div>
</body>
</html>
