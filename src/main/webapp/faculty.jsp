<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Faculty Directory</title>
    <style>
        /* Overall Page Style */
        body {
            font-family: Arial, sans-serif;
            background-color: #f0f7ec; /* Light olive background */
            color: #333;
            margin: 0;
            padding: 20px;
            display: flex;
            flex-direction: column;
            align-items: center;
        }

        h2 {
            color: #4B8B3B; /* Olive green */
            text-align: center;
            padding: 10px 0;
            font-size: 1.8em;
        }

        .top-right {
            position: absolute;
            top: 20px;
            right: 20px;
        }

        .top-right a {
            text-decoration: none;
            padding: 10px 20px;
            background-color: #4B8B3B; /* Olive green */
            color: white;
            border-radius: 25px;
            font-weight: bold;
            transition: background-color 0.3s;
            box-shadow: 0 3px 8px rgba(0, 0, 0, 0.2);
        }

        .top-right a:hover {
            background-color: #3f7a31; /* Darker olive green on hover */
        }

        /* Table Container Style */
        .table-container {
            width: 90%;
            max-width: 1000px;
            margin-top: 30px;
            border-radius: 20px;
            overflow: hidden;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.15);
            background-color: white;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            border-radius: 20px;
            overflow: hidden;
        }

        th, td {
            padding: 15px;
            text-align: left;
            font-size: 0.9em;
            border-bottom: 1px solid #e6f0db;
        }

        th {
            background-color: #e1f0d4; /* Light olive green */
            color: #4B8B3B;
            font-weight: bold;
        }

        tr:nth-child(even) {
            background-color: #f7fdf4; /* Very light olive for zebra striping */
        }

        tr:hover {
            background-color: #d0e9b1; /* Highlight on hover */
        }

        td {
            color: #666;
        }

        /* Filter Inputs */
        th input[type="text"] {
            width: 90%;
            padding: 8px;
            border-radius: 20px;
            border: 1px solid #cdd7c2;
            font-size: 0.85em;
            margin-top: 8px;
            outline: none;
        }

        /* Responsive Design */
        @media (max-width: 768px) {
            h2 {
                font-size: 1.5em;
            }

            th, td {
                padding: 10px;
                font-size: 0.85em;
            }

            .top-right a {
                padding: 8px 15px;
                font-size: 0.9em;
            }
        }
    </style>
    <script>
        // Enhanced filter function for the faculty table
        function filterTable() {
            let table = document.getElementById("facultyTable");
            let rows = table.getElementsByTagName("tr");
            for (let i = 1; i < rows.length; i++) {
                let row = rows[i];
                let cells = row.getElementsByTagName("td");
                let showRow = true;

                for (let j = 0; j < cells.length; j++) {
                    let filterInput = document.getElementById("filter" + j);
                    if (filterInput && filterInput.value) {
                        let filterValue = filterInput.value.toLowerCase();
                        let cellValue = cells[j].textContent || cells[j].innerText;

                        if (!cellValue.toLowerCase().includes(filterValue)) {
                            showRow = false;
                            break;
                        }
                    }
                }
                row.style.display = showRow ? "" : "none";
            }
        }
    </script>
</head>
<body>

<div class="top-right">
    <a href="register.jsp">Register/Update</a>
</div>

<h2>Faculty Directory</h2>

<div class="table-container">
    <table id="facultyTable">
        <thead>
            <tr>
                <th>Name <input type="text" id="filter0" onkeyup="filterTable()" placeholder="Filter by Name"></th>
                <th>Date of Birth <input type="text" id="filter1" onkeyup="filterTable()" placeholder="Filter by DOB"></th>
                <th>Email <input type="text" id="filter2" onkeyup="filterTable()" placeholder="Filter by Email"></th>
                <th>Department <input type="text" id="filter3" onkeyup="filterTable()" placeholder="Filter by Dept"></th>
                <th>Colleges/Universities <input type="text" id="filter4" onkeyup="filterTable()" placeholder="Filter by College"></th>
                <th>Position <input type="text" id="filter5" onkeyup="filterTable()" placeholder="Filter by Position"></th>
                <th>Year Joined <input type="text" id="filter6" onkeyup="filterTable()" placeholder="Filter by Year"></th>
                <th>Website Link</th>
            </tr>
        </thead>
        <tbody>
        <%
            // Database connection setup
            String dbUrl = "jdbc:mysql://localhost:3306/IIESTS";
            String dbUsername = "root";
            String dbPassword = "your_password"; // Replace with actual password
            Connection connection = null;
            Statement statement = null;
            ResultSet resultSet = null;

            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                connection = DriverManager.getConnection(dbUrl, dbUsername, dbPassword);
                String sql = "SELECT * FROM faculty_list ORDER BY id LIMIT 10";
                statement = connection.createStatement();
                resultSet = statement.executeQuery(sql);

                while (resultSet.next()) {
                    %>
                    <tr>
                        <td><%= resultSet.getString("full_name") %></td>
                        <td><%= resultSet.getString("date_of_birth") %></td>
                        <td><%= resultSet.getString("email") %></td>
                        <td><%= resultSet.getString("department") %></td>
                        <td><%= resultSet.getString("colleges_unis_attended") %></td>
                        <td><%= resultSet.getString("position") %></td>
                        <td><%= resultSet.getString("when_joined") %></td>
                        <td><a href="<%= resultSet.getString("google_scholar_link") %>" target="_blank">Google Scholar</a></td>
                    </tr>
                    <%
                }
            } catch (Exception e) {
                e.printStackTrace();
            } finally {
                if (resultSet != null) resultSet.close();
                if (statement != null) statement.close();
                if (connection != null) connection.close();
            }
        %>
        </tbody>
    </table>
</div>

</body>
</html>
