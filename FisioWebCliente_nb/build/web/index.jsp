<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    if (session.getAttribute("adminLogueado") != null) {
        response.sendRedirect("DashboardServlet");
    } else {
        response.sendRedirect("login.jsp");
    }
%>
