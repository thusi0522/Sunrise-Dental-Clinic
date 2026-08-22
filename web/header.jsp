<%@ page import="com.sunrisedental.model.User" %>
<%
    User user = (User) session.getAttribute("user");
    if (user == null) {
        response.sendRedirect("login.jsp");
        return;
    }
%>
<header>
    <h1>Sunrise Dental Clinic</h1>
    <p>Welcome, <%= user.getFullName() %> (<%= user.getRole() %>)</p>
</header>
<nav>
    <ul>
        <% if ("ADMIN".equals(user.getRole())) { %>
            <li><a href="admin_dashboard.jsp">Dashboard</a></li>
            <li><a href="register_appointment.jsp">New Appointment</a></li>
        <% } %>
        <% if ("DOCTOR".equals(user.getRole())) { %>
            <li><a href="doctor_dashboard.jsp">Dashboard</a></li>
            <li><a href="search_appointment.jsp">View Records</a></li>
        <% } %>
        <% if ("CASHIER".equals(user.getRole())) { %>
            <li><a href="cashier_dashboard.jsp">Dashboard</a></li>
            <li><a href="billing.jsp">Billing</a></li>
        <% } %>
        <% if ("PATIENT".equals(user.getRole())) { %>
            <li><a href="patient_dashboard.jsp">My Appointments</a></li>
        <% } %>
        <li><a href="help.jsp">Help</a></li>
        <li><a href="logout.jsp">Logout</a></li>
    </ul>
</nav>
<div class="container">
