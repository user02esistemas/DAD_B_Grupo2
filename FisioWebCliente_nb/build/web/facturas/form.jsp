<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.Collections"%>
<%@page import="java.util.List"%>
<%@page import="java.util.Map"%>
<%@page import="fisioCore.dto.AtencionMedicaDTO"%>
<%@page import="fisioCore.dto.FacturaPacienteDTO"%>
<%@include file="../includes/header.jsp" %>
<%@include file="../includes/sidebar.jsp" %>
<%
    FacturaPacienteDTO factura = (FacturaPacienteDTO) request.getAttribute("factura");
    List<AtencionMedicaDTO> atenciones = (List<AtencionMedicaDTO>) request.getAttribute("listaAtenciones");
    Map<Integer, String> estados = (Map<Integer, String>) request.getAttribute("listaEstadosFactura");
    Map<Integer, String> metodos = (Map<Integer, String>) request.getAttribute("listaMetodosPago");
    String serieDefecto = (String) request.getAttribute("serieDefecto");
    String numeroSugerido = (String) request.getAttribute("numeroSugerido");
    boolean soloLectura = Boolean.TRUE.equals(request.getAttribute("soloLectura"));
    if (atenciones == null) atenciones = Collections.emptyList();
    if (estados == null) estados = Collections.emptyMap();
    if (metodos == null) metodos = Collections.emptyMap();
    if (serieDefecto == null) serieDefecto = "F001";
    if (numeroSugerido == null) numeroSugerido = "";
    String disabled = soloLectura ? "disabled" : "";
    String fechaEmision = factura == null || factura.getFechaEmision() == null
            ? "" : factura.getFechaEmision().toString().substring(0, 16).replace(' ', 'T');
    String fechaPago = factura == null || factura.getFechaPago() == null
            ? "" : factura.getFechaPago().toString().substring(0, 16).replace(' ', 'T');
%>

<div class="max-w-5xl mx-auto bg-white shadow-xl rounded-2xl border p-8">
    <div class="flex justify-between items-center mb-7">
        <div>
            <h2 class="text-3xl font-bold text-slate-800"><%= soloLectura ? "Detalle de factura" : factura == null ? "Nueva factura" : "Editar factura" %></h2>
            <p class="text-slate-500">Datos del comprobante y pago</p>
        </div>
        <a href="${pageContext.request.contextPath}/FacturaServlet?accion=listar" class="text-slate-500">Cerrar</a>
    </div>

    <form action="${pageContext.request.contextPath}/FacturaServlet" method="post" class="grid grid-cols-1 md:grid-cols-3 gap-5">
        <input type="hidden" name="accion" value="<%= factura == null ? "guardar" : "actualizar" %>">
        <% if (factura != null) { %><input type="hidden" name="id" value="<%= factura.getIdFacturaPaciente() %>"><% } %>

        <label class="md:col-span-3">Atención
            <select id="idAtencion" name="idAtencion" required <%= disabled %>
                    onchange="cargarCostoAtencion(this)"
                    class="w-full border rounded-xl px-3 py-2.5 mt-1">
                <option value="">Seleccione...</option>
                <% for (AtencionMedicaDTO atencion : atenciones) { %>
                <option value="<%= atencion.getIdAtencionMedica() %>"
                        data-costo="<%= Double.toString(atencion.getCostoConsulta()) %>"
                        <%= factura != null && factura.getIdAtencionMedica() == atencion.getIdAtencionMedica() ? "selected" : "" %>>
                    #<%= atencion.getIdAtencionMedica() %> · <%= atencion.getNombrePaciente() %> · <%= atencion.getFechaHora() %>
                </option>
                <% } %>
            </select>
        </label>

        <label>Serie<input name="serie" maxlength="10" required <%= disabled %> value="<%= factura == null ? serieDefecto : factura.getSerie() %>" class="w-full border rounded-xl px-3 py-2.5 mt-1"></label>
        <label>Número<input name="numero" maxlength="20" required <%= disabled %> value="<%= factura == null ? numeroSugerido : factura.getNumero() %>" class="w-full border rounded-xl px-3 py-2.5 mt-1"></label>
        <label>RUC emisor<input name="ruc" maxlength="20" <%= disabled %> value="<%= factura == null || factura.getRucEmisor() == null ? "20601234567" : factura.getRucEmisor() %>" class="w-full border rounded-xl px-3 py-2.5 mt-1"></label>

        <label>Subtotal<input id="subtotal" type="number" name="subtotal" min="0" step="0.01" required <%= disabled %> value="<%= factura == null ? "0.00" : factura.getSubtotal() %>" class="monto w-full border rounded-xl px-3 py-2.5 mt-1"></label>
        <label>Impuesto<input id="impuesto" type="number" name="impuesto" min="0" step="0.01" required <%= disabled %> value="<%= factura == null ? "0.00" : factura.getImpuesto() %>" class="monto w-full border rounded-xl px-3 py-2.5 mt-1"></label>
        <label>Total<input id="total" type="number" name="total" min="0.01" step="0.01" required <%= disabled %> value="<%= factura == null ? "0.00" : factura.getTotal() %>" class="w-full border rounded-xl px-3 py-2.5 mt-1"></label>

        <label>Estado
            <select name="idEstado" required <%= disabled %> class="w-full border rounded-xl px-3 py-2.5 mt-1">
                <% for (Map.Entry<Integer, String> estado : estados.entrySet()) { %>
                <option value="<%= estado.getKey() %>" <%= factura != null && factura.getIdEstadoFactura() == estado.getKey() ? "selected" : factura == null && estado.getKey() == 1 ? "selected" : "" %>><%= estado.getValue() %></option>
                <% } %>
            </select>
        </label>
        <label>Método de pago
            <select name="idMetodo" <%= disabled %> class="w-full border rounded-xl px-3 py-2.5 mt-1">
                <option value="">Sin definir</option>
                <% for (Map.Entry<Integer, String> metodo : metodos.entrySet()) { %>
                <option value="<%= metodo.getKey() %>" <%= factura != null && factura.getIdMetodoPago() != null && factura.getIdMetodoPago().equals(metodo.getKey()) ? "selected" : "" %>><%= metodo.getValue() %></option>
                <% } %>
            </select>
        </label>
        <label>Fecha de emisión<input type="datetime-local" name="fechaEmision" <%= disabled %> value="<%= fechaEmision %>" class="w-full border rounded-xl px-3 py-2.5 mt-1"></label>
        <label>Fecha de pago<input type="datetime-local" name="fechaPago" <%= disabled %> value="<%= fechaPago %>" class="w-full border rounded-xl px-3 py-2.5 mt-1"></label>

        <div class="md:col-span-3 flex justify-end gap-3 mt-3">
            <a href="${pageContext.request.contextPath}/FacturaServlet?accion=listar" class="px-5 py-2.5 text-slate-600">Volver</a>
            <% if (!soloLectura) { %><button class="px-5 py-2.5 rounded-xl bg-amber-500 text-white font-semibold">Guardar factura</button><% } %>
        </div>
    </form>
</div>
<script>
function cargarCostoAtencion(select) {
    const opcion = select.options[select.selectedIndex];
    const total = Number.parseFloat(opcion ? opcion.dataset.costo : "");
    const totalValido = Number.isFinite(total) && total > 0 ? total : 0;
    const subtotal = totalValido / 1.18;
    const impuesto = totalValido - subtotal;

    document.getElementById('total').value = totalValido.toFixed(2);
    document.getElementById('subtotal').value = subtotal.toFixed(2);
    document.getElementById('impuesto').value = impuesto.toFixed(2);
}
</script>
<%@include file="../includes/footer.jsp" %>
