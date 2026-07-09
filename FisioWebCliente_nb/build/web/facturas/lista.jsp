<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.Collections"%>
<%@page import="java.util.List"%>
<%@page import="fisioCore.dto.FacturaPacienteDTO"%>
<%@include file="../includes/header.jsp" %>
<%@include file="../includes/sidebar.jsp" %>
<%
    List<FacturaPacienteDTO> lista = (List<FacturaPacienteDTO>) request.getAttribute("listaFacturas");
    if (lista == null) lista = Collections.emptyList();
    String mensaje = (String) request.getAttribute("mensaje");
    String error = (String) request.getAttribute("error");
%>

<div class="animate-fade-in-up">
    <div class="flex flex-col md:flex-row justify-between items-start md:items-center mb-8 gap-4">
        <div>
            <h2 class="text-3xl font-bold text-slate-800">Facturación</h2>
            <p class="text-slate-500 text-lg">Control de comprobantes y pagos mediante RMI</p>
        </div>
        <div class="flex gap-3 w-full md:w-auto">
            <input id="searchInput" onkeyup="filtrarTabla()" placeholder="Buscar factura o paciente..."
                   class="w-full md:w-64 px-4 py-3 border rounded-xl">
            <a href="${pageContext.request.contextPath}/FacturaServlet?accion=nuevo"
               class="bg-gradient-to-r from-amber-500 to-orange-600 text-white font-semibold py-3 px-6 rounded-xl whitespace-nowrap">
                Nueva factura
            </a>
        </div>
    </div>

    <% if (mensaje != null) { %>
    <div class="mb-4 rounded-xl bg-emerald-50 text-emerald-700 px-4 py-3"><%= mensaje %></div>
    <% } %>
    <% if (error != null) { %>
    <div class="mb-4 rounded-xl bg-red-50 text-red-700 px-4 py-3"><%= error %></div>
    <% } %>

    <div class="bg-white shadow-xl rounded-2xl border border-slate-200 overflow-hidden">
        <div class="overflow-x-auto">
            <table class="w-full text-sm text-left" id="tablaFacturas">
                <thead class="bg-slate-50 border-b text-slate-500 uppercase text-xs">
                    <tr>
                        <th class="px-6 py-4">Comprobante</th>
                        <th class="px-6 py-4">Paciente / atención</th>
                        <th class="px-6 py-4">Importes</th>
                        <th class="px-6 py-4">Estado</th>
                        <th class="px-6 py-4">Método</th>
                        <th class="px-6 py-4 text-right">Acciones</th>
                    </tr>
                </thead>
                <tbody class="divide-y divide-slate-100">
                    <% if (lista.isEmpty()) { %>
                    <tr><td colspan="6" class="px-6 py-10 text-center text-slate-400">No hay facturas registradas.</td></tr>
                    <% } %>
                    <% for (FacturaPacienteDTO factura : lista) { %>
                    <tr class="hover:bg-slate-50">
                        <td class="px-6 py-4">
                            <div class="font-mono font-bold"><%= factura.getSerie() %>-<%= factura.getNumero() %></div>
                            <div class="text-xs text-slate-400"><%= factura.getFechaEmision() == null ? "-" : factura.getFechaEmision().toString().substring(0, 16) %></div>
                        </td>
                        <td class="px-6 py-4">
                            <div class="font-medium"><%= factura.getNombrePaciente() %></div>
                            <div class="text-xs text-slate-400">Atención #<%= factura.getIdAtencionMedica() %></div>
                        </td>
                        <td class="px-6 py-4">
                            <div class="font-bold">S/ <%= String.format("%.2f", factura.getTotal()) %></div>
                            <div class="text-xs text-slate-400">Sub. <%= String.format("%.2f", factura.getSubtotal()) %> · Imp. <%= String.format("%.2f", factura.getImpuesto()) %></div>
                        </td>
                        <td class="px-6 py-4"><span class="px-3 py-1 rounded-full bg-amber-50 text-amber-700"><%= factura.getNombreEstado() %></span></td>
                        <td class="px-6 py-4"><%= factura.getNombreMetodo() == null ? "Sin definir" : factura.getNombreMetodo() %></td>
                        <td class="px-6 py-4">
                            <div class="flex justify-end gap-2">
                                <a href="${pageContext.request.contextPath}/FacturaServlet?accion=ver&id=<%= factura.getIdFacturaPaciente() %>" class="px-3 py-2 rounded-lg bg-slate-100">Ver</a>
                                <a href="${pageContext.request.contextPath}/FacturaServlet?accion=editar&id=<%= factura.getIdFacturaPaciente() %>" class="px-3 py-2 rounded-lg bg-amber-50 text-amber-700">Editar</a>
                                <% if (factura.getIdEstadoFactura() != 3) { %>
                                <form action="${pageContext.request.contextPath}/FacturaServlet" method="post" onsubmit="return confirm('¿Anular esta factura?');">
                                    <input type="hidden" name="accion" value="anular">
                                    <input type="hidden" name="id" value="<%= factura.getIdFacturaPaciente() %>">
                                    <button class="px-3 py-2 rounded-lg bg-red-50 text-red-600">Anular</button>
                                </form>
                                <% } %>
                            </div>
                        </td>
                    </tr>
                    <% } %>
                </tbody>
            </table>
        </div>
    </div>
</div>

<script>
function filtrarTabla() {
    const filtro = document.getElementById('searchInput').value.toUpperCase();
    document.querySelectorAll('#tablaFacturas tbody tr').forEach(fila => {
        fila.style.display = fila.textContent.toUpperCase().includes(filtro) ? '' : 'none';
    });
}
</script>
<%@include file="../includes/footer.jsp" %>
