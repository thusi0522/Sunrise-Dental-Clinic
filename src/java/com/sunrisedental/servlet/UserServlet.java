package com.sunrisedental.servlet;

import com.sunrisedental.dao.UserDAO;
import com.sunrisedental.model.User;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/UserServlet")
public class UserServlet extends HttpServlet {
    private UserDAO userDAO = new UserDAO();

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");

        if ("register".equals(action)) {
            User user = new User();
            user.setUsername(request.getParameter("username"));
            user.setPassword(request.getParameter("password"));
            user.setFullName(request.getParameter("fullName"));
            
            // Only admin can set role, others default to PATIENT
            String role = request.getParameter("role");
            if (role == null || role.isEmpty()) {
                role = "PATIENT";
            }
            user.setRole(role);

            if (userDAO.registerUser(user)) {
                if ("ADMIN".equals(request.getParameter("source"))) {
                    response.sendRedirect("manage_users.jsp?msg=UserAdded");
                } else {
                    response.sendRedirect("login.jsp?msg=AccountCreated");
                }
            } else {
                response.sendRedirect("signup.jsp?error=UsernameExists");
            }
        } else if ("delete".equals(action)) {
            int id = Integer.parseInt(request.getParameter("id"));
            userDAO.deleteUser(id);
            response.sendRedirect("manage_users.jsp?msg=UserDeleted");
        }
    }
}
