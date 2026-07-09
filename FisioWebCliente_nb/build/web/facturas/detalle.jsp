<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<c:if test="${empty factura}">
    <h1>Detalle de factura</h1>
    <p>No se encontró la factura.</p>
</c:if>

<c:if test="${not empty factura}">
    <h1>Detalle de Factura #${factura.idFacturaPaciente}</h1>

    <h3>Datos generales</h3>
    <ul>
        <li><strong>Paciente:</strong> ${factura.nombrePaciente}</li>
        <li><strong>Monto:</strong> S/. ${factura.monto}</li>
        <li><strong>Estado:</strong> ${factura.estadoFactura}</li>
        <li><strong>Método de pago:</strong> ${factura.metodoPago}</li>
        <li><strong>Fecha emisión:</strong> ${factura.fechaEmision}</li>
        <li><strong>Fecha pago:</strong> ${factura.fechaPago}</li>
    </ul>

    <hr/>

    <!-- Si aún no tiene fecha de pago, mostramos el formulario para pagar -->
    <c:if test="${empty factura.fechaPago}">
        <h3>Registrar pago</h3>
        <form action="facturas" method="post">
            <input type="hidden" name="idFacturaPaciente"
                   value="${factura.idFacturaPaciente}">

            <label>Método de pago:</label>
            <select name="idMetodoPago" required>
                <option value="">--Seleccione--</option>
                <!-- Ajusta los IDs según tu tabla metodo_pago -->
                <option value="1">Efectivo</option>
                <option value="2">Yape</option>
                <option value="3">Tarjeta</option>
            </select>
            <br><br>

            <button type="submit">Confirmar pago</button>
        </form>
    </c:if>

    <c:if test="${not empty factura.fechaPago}">
        <p><strong>Esta factura ya está pagada.</strong></p>
    </c:if>

    <br>
    <a href="facturas?action=pendientes">Volver a facturas pendientes</a> |
    <a href="facturas?action=todas">Ver todas las facturas</a>
</c:if>
