<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.sunrisedental.dao.UserDAO, com.sunrisedental.model.User, java.util.List" %>
<!DOCTYPE html>
<html>
<head>
    <title>Manage Users - Admin</title>
    <link rel="stylesheet" type="text/css" href="css/style.css">
</head>
<body>
    <%@ include file="header.jsp" %>

    <%
        if(!"ADMIN".equals(user.getRole())) {
            response.sendRedirect("login.jsp");
            return;
        }
    %>

    <div class="dashboard-card">
        <h2>Add New Doctor / Staff</h2>
        <form action="UserServlet" method="post">
            <input type="hidden" name="action" value="register">
            <input type="hidden" name="source" value="ADMIN">
            <div style="display: flex; gap: 10px; flex-wrap: wrap;">
                <div class="form-group" style="flex: 1;">
                    <label>Full Name</label>
                    <input type="text" name="fullName" required>
                </div>
                <div class="form-group" style="flex: 1;">
                    <label>Username</label>
                    <input type="text" name="username" required>
                </div>
                <div class="form-group" style="flex: 1;">
                    <label>Password</label>
                    <input type="password" name="password" required>
                </div>
                <div class="form-group" style="flex: 1;">
                    <label>Role</label>
                    <select name="role">
                        <option value="DOCTOR">DOCTOR</option>
                        <option value="CASHIER">CASHIER</option>
                        <option value="ADMIN">ADMIN</option>
                        <option value="PATIENT">PATIENT</option>
                    </select>
                </div>
            </div>
            <button type="submit">Create Account</button>
        </form>
    </div>

    <div class="dashboard-card">
        <h3>System Users List</h3>
        <table>
            <tr>
                <th>ID</th>
                <th>Name</th>
                <th>Username</th>
                <th>Role</th>
                <th>Action</th>
            </tr>
            <%
                UserDAO dao = new UserDAO();
                List<User> userList = dao.getAllUsers();
                for(User u : userList) {
            %>
            <tr>
                <td><%= u.getId() %></td>
                <td><%= u.getFullName() %></td>
                <td><%= u.getUsername() %></td>
                <td><%= u.getRole() %></td>
                <td>
                    <form action="UserServlet" method="post" onsubmit="return confirm('Are you sure?')">
                        <input type="hidden" name="action" value="delete">
                        <input type="hidden" name="id" value="<%= u.getId() %>">
                        <button type="submit" style="background: red;">Delete</button>
                    </form>
                </td>
            </tr>
            <% } %>
        </table>
    </div>

    <%@ include file="footer.jsp" %>
</body>
</html>
