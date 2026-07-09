<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>

<h1>Dashboard</h1>

<div class="cards-container">
    <div class="card">
        <h3>Total de pacientes</h3>
        <p>${totalPacientes}</p>
    </div>

    <div class="card">
        <h3>Total de doctores</h3>
        <p>${totalDoctores}</p>
    </div>

    <div class="card">
        <h3>Atenciones pendientes</h3>
        <p>${fn:length(atencionesPendientes)}</p>
    </div>

    <div class="card">
        <h3>Facturas pendientes</h3>
        <p>${fn:length(facturasPendientes)}</p>
    </div>
</div>

<hr/>

<h2>Atenciones pendientes</h2>
<c:if test="${empty atencionesPendientes}">
    <p>No hay atenciones pendientes.</p>
</c:if>
<c:if test="${not empty atencionesPendientes}">
    <table border="1" cellpadding="4" cellspacing="0">
        <tr>
            <th>Paciente</th>
            <th>Doctor</th>
            <th>Motivo</th>
            <th>Fecha / Hora</th>
            <th>Estado</th>
        </tr>
        <c:forEach var="a" items="${atencionesPendientes}">
            <tr>
                <td>${a.nombrePaciente}</td>
                <td>${a.nombreDoctor}</td>
                <td>${a.motivoConsulta}</td>
                <td>${a.fechaHora}</td>
                <td>${a.estadoAtencion}</td>
            </tr>
        </c:forEach>
    </table>
</c:if>

<h2>Facturas pendientes de pago</h2>
<c:if test="${empty facturasPendientes}">
    <p>No hay facturas pendientes.</p>
</c:if>
<c:if test="${not empty facturasPendientes}">
    <table border="1" cellpadding="4" cellspacing="0">
        <tr>
            <th>Paciente</th>
            <th>Monto</th>
            <th>Estado</th>
            <th>Método de pago</th>
            <th>Fecha emisión</th>
        </tr>
        <c:forEach var="f" items="${facturasPendientes}">
            <tr>
                <td>${f.nombrePaciente}</td>
                <td>S/. ${f.monto}</td>
                <td>${f.estadoFactura}</td>
                <td>${f.metodoPago}</td>
                <td>${f.fechaEmision}</td>
            </tr>
        </c:forEach>
    </table>
</c:if>

