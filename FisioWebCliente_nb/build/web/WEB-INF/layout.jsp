<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>${pageTitle}</title>
    <style>
        body { margin:0; font-family:Arial; display:flex; }
        .sidebar {
            width:220px; background:#b71c1c; color:#fff; min-height:100vh;
        }
        .sidebar h2 {
            text-align:center; padding:20px 10px; border-bottom:1px solid rgba(255,255,255,.2);
        }
        .sidebar a {
            display:block; padding:12px 16px; color:#fff; text-decoration:none;
        }
        .sidebar a:hover { background:#d32f2f; }
        .content {
            flex:1; padding:20px; background:#f9f9f9;
        }
        .top-bar { text-align:right; margin-bottom:10px; }
    </style>
</head>
<body>
<div class="sidebar">
    <h2>Admin</h2>
    <a href="dashboard">Dashboard</a>
    <a href="pacientes">Pacientes</a>
    <a href="doctores">Doctores</a>
    <a href="atenciones">Citas / Atenciones</a>
    <a href="facturas">Facturación</a>
    <a href="logout">Cerrar sesión</a>
</div>
<div class="content">
    <div class="top-bar">
        Bienvenido, ${sessionScope.adminLogueado.nombreCompleto}
    </div>
    <jsp:include page="${pageBody}"/>
</div>
</body>
</html>
