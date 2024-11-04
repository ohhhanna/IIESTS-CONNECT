<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Alumni Directory</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f9f9f9;
            margin: 0;
            padding: 20px;
        }
        h1 {
            color: #4B8B3B; /* Olive green color */
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
        }
        table, th, td {
            border: 1px solid #4B8B3B; /* Olive green border */
            padding: 12px;
            text-align: left;
        }
        th {
            background-color: #e1f0d4;
            color: #4B8B3B;
        }
        tr:nth-child(even) {
            background-color: #f2f2f2;
        }
        tr:hover {
            background-color: #d0e9b1;
        }
        .search-bar {
            width: 90%;
            padding: 10px;
            border: 1px solid #4B8B3B;
            border-radius: 5px;
            margin-top: 20px;
            margin-right: 10px;
        }
        .search-button {
            padding: 10px 15px;
            background-color: #4B8B3B;
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
        }
        .search-button:hover {
            background-color: #3f7a31;
        }
        .top-right {
            position: absolute;
            top: 20px;
            right: 20px;
        }
        .register-button {
            padding: 10px 15px;
            background-color: #4B8B3B;
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            position: relative;
        }
        .dropdown-menu {
            display: none;
            position: absolute;
            top: 100%;
            right: 0;
            background-color: white;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
            border-radius: 5px;
            overflow: hidden;
            z-index: 10;
        }
        .dropdown-menu a {
            display: block;
            padding: 10px;
            text-decoration: none;
            color: #4B8B3B;
            font-weight: bold;
            transition: background-color 0.3s ease;
        }
        .dropdown-menu a:hover {
            background-color: #e1f0d4;
        }

        /* Responsive design */
        @media (max-width: 768px) {
            .search-bar {
                width: 80%;
            }
            table, th, td {
                font-size: 14px;
            }
        }
        @media (max-width: 480px) {
            .search-bar {
                width: 100%;
            }
        }
    </style>
    <script>
        function toggleDropdown() {
            const dropdownMenu = document.getElementById("dropdown-menu");
            dropdownMenu.style.display = dropdownMenu.style.display === "block" ? "none" : "block";
        }

        // Close the dropdown if the user clicks outside of it
        window.onclick = function(event) {
            const dropdownMenu = document.getElementById("dropdown-menu");
            const button = document.getElementById("register-button");
            if (event.target !== button && !button.contains(event.target)) {
                dropdownMenu.style.display = "none";
            }
        }
    </script>
</head>
<body>

<div class="top-right">
    <button id="register-button" class="register-button" onclick="toggleDropdown()">Register/Update</button>
    <div id="dropdown-menu" class="dropdown-menu">
        <a href="loginAlum.jsp">Update</a>
        <a href="signupAlum.jsp">Register</a>
    </div>
</div>

<h1>Alumni Directory</h1>

<form method="GET" action="alumni.jsp">
    <input type="text" name="search" placeholder="Search alumni..." class="search-bar" />
    <button type="submit" class="search-button">Search</button>
</form>

<table>
    <tr>
        <th>Full Name</th>
        <th>Email</th>
        <th>Date of Birth</th>
        <th>Department</th>
        <th>college</th>
        <th>Year Passed Out</th>
        <th>Discipline</th>
        <th>specialty</th>
        <th>Website</th>
    </tr>

    <%
        String dbUrl = "jdbc:mysql://localhost:3306/IIEST?useSSL=false";
        String dbUsername = "root";
        String dbPassword = "big19boyfever";

        Connection connection = null;
        Statement statement = null;
        ResultSet resultSet = null;

        String search = request.getParameter("search");

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            connection = DriverManager.getConnection(dbUrl, dbUsername, dbPassword);
            statement = connection.createStatement();

            String sql = "SELECT * FROM alum";
            if (search != null && !search.isEmpty()) {
                sql += " WHERE name LIKE '%" + search + "%' OR " +
                		"email LIKE '%" + search + "%' OR " +
                       "date_of_birth LIKE '%" + search + "%' OR " +
                       "department LIKE '%" + search + "%' OR " +
                       "college LIKE '%" + search + "%' OR " +
                       "pass_out_year LIKE '%" + search + "%' OR " +
                       "discpline LIKE '%" + search + "%' OR " +
                       "specialty LIKE '%" + search + "%' OR " +
                       "website_link LIKE '%" + search + "%' " ;
            }
            sql += " LIMIT 10";
            resultSet = statement.executeQuery(sql);

            while (resultSet.next()) {
                %>
                <tr>
                    <td><%= resultSet.getString("name") %></td>
                    <td><%= resultSet.getString("email") %></td>
                    <td><%= resultSet.getString("date_of_birth") %></td>
                    <td><%= resultSet.getString("department") %></td>
                    <td><%= resultSet.getString("college") %></td>
                     <td><%= resultSet.getString("pass_out_year") %></td>
                     <td><%= resultSet.getString("discipline") %></td>
                     <td><%= resultSet.getString("specialty") %></td>
                    <td><a href="<%= resultSet.getString("website_link") %>"><%= resultSet.getString("website_link") %></a></td>
                </tr>
                <%
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (resultSet != null) try { resultSet.close(); } catch (SQLException ignore) {}
            if (statement != null) try { statement.close(); } catch (SQLException ignore) {}
            if (connection != null) try { connection.close(); } catch (SQLException ignore) {}
        }
    %>
</table>

</body>
</html>
