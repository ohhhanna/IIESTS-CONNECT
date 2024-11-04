<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Home Page</title>
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
            flex-direction: column;
            align-items: center;
            padding: 20px;
            background-color: #f9f9f9; /* Light background */
        }

        /* Header Menu Styling */
        .header {
            width: 100%;
            background-color: #4B8B3B; /* Olive green */
            overflow: hidden;
        }
        .header nav {
            display: flex;
            justify-content: center;
            padding: 10px;
        }
        .header nav a {
            color: white;
            padding: 14px 20px;
            text-decoration: none;
            font-size: 18px;
            text-align: center;
        }
        .header nav a:hover {
            background-color: #3f7a31; /* Darker olive green */
        }

        /* Content Styling */
        .content {
            max-width: 800px;
            width: 100%;
            margin-top: 20px;
            text-align: center;
        }
        .content img {
            width: 100%;
            height: auto;
            max-height: 500px;
            border-radius: 8px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.2);
        }

        /* Responsive Design for Smaller Screens */
        @media (max-width: 768px) {
            .header nav a {
                font-size: 16px;
                padding: 10px;
            }
        }
    </style>
</head>
<body>
    <!-- Header with Navigation Menu -->
    <div class="header">
        <nav>
            <a href="faculty.jsp">Faculty Directory</a>
            <a href="adirec.jsp">Alumni Directory</a>
        </nav>
    </div>

    <!-- Content with Image -->
    <div class="content">
        <h2>Welcome to IIEST</h2>
        <p>Explore our faculty and alumni directory.</p>
        <img src="images\mainbuilding.jpg" alt="IIEST Image">
    </div>
</body>
</html>