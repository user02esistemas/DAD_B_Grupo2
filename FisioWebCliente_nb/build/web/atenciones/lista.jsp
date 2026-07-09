<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.Collections"%>
<%@page import="java.util.List"%>
<%@page import="fisioCore.dto.AtencionMedicaDTO"%>
<%@include file="../includes/header.jsp" %>
<%@include file="../includes/sidebar.jsp" %>

<%
    List<AtencionMedicaDTO> lista = (List<AtencionMedicaDTO>) request.getAttribute("listaAtenciones");
    if (lista == null) {
        lista = Collections.emptyList();
    }
    String mensaje = (String) request.getAttribute("mensaje");
%>

<div class="animate-fade-in-up">
    <% if (mensaje != null) { %>
    <div class="mb-6 bg-emerald-50 border-l-4 border-emerald-500 text-emerald-700 p-4 rounded-r-lg">
        <%= mensaje %>
    </div>
    <% } %>
    <% if (request.getAttribute("error") != null) { %>
    <div class="mb-6 bg-red-50 border-l-4 border-red-500 text-red-700 p-4 rounded-r-lg">
        <%= request.getAttribute("error") %>
    </div>
    <% } %>

    <div class="flex flex-col md:flex-row justify-between items-start md:items-center mb-8 gap-4">
        <div>
            <h2 class="text-3xl font-bold text-slate-800 tracking-tight">Citas y Atenciones</h2>
            <p class="text-slate-500 text-lg">Gestiona el flujo de pacientes</p>
        </div>
        <div class="flex gap-3 w-full md:w-auto">
            <input type="text" id="searchInput" onkeyup="filtrarTabla()" placeholder="Buscar cita..."
                   class="w-full md:w-64 px-4 py-3 border border-slate-200 rounded-xl">
            <a href="${pageContext.request.contextPath}/AtencionServlet?accion=nuevo"
               class="bg-gradient-to-r from-pink-600 to-purple-600 text-white font-semibold py-3 px-6 rounded-xl shadow-lg whitespace-nowrap">
                Nueva Cita
            </a>
        </div>
    </div>

    <div class="bg-white shadow-xl rounded-2xl border border-slate-200 overflow-hidden">
        <div class="overflow-x-auto">
            <table class="w-full text-sm text-left" id="tablaAtenciones">
                <thead class="bg-slate-50 border-b text-slate-500 uppercase text-xs">
                    <tr>
                        <th class="px-6 py-4">Fecha / Hora</th>
                        <th class="px-6 py-4">Paciente</th>
                        <th class="px-6 py-4">Doctor</th>
                        <th class="px-6 py-4">Servicio / Especialización</th>
                        <th class="px-6 py-4">Estado</th>
                        <th class="px-6 py-4">Motivo / Costo</th>
                        <th class="px-6 py-4 text-right">Acciones</th>
                    </tr>
                </thead>
                <tbody class="divide-y divide-slate-100">
                    <% for (AtencionMedicaDTO atencion : lista) { %>
                    <tr class="hover:bg-slate-50">
                        <td class="px-6 py-4">
                            <div class="font-mono font-medium"><%= atencion.getFechaHora() == null ? "-" : atencion.getFechaHora().toString().substring(0, 16) %></div>
                            <div class="text-xs text-slate-400"><%= atencion.getDuracionMinutos() %> minutos</div>
                        </td>
                        <td class="px-6 py-4 font-medium"><%= atencion.getNombrePaciente() %></td>
                        <td class="px-6 py-4">Dr. <%= atencion.getNombreDoctor() %></td>
                        <td class="px-6 py-4">
                            <%= atencion.getNombreEspecializacion() == null
                                    ? "Sin clasificar" : atencion.getNombreEspecializacion() %>
                        </td>
                        <td class="px-6 py-4">
                            <span class="px-3 py-1 rounded-full bg-slate-100 text-slate-700 text-xs font-semibold">
                                <%= atencion.getNombreEstado() %>
                            </span>
                        </td>
                        <td class="px-6 py-4">
                            <div><%= atencion.getMotivoConsulta() == null ? "Sin motivo" : atencion.getMotivoConsulta() %></div>
                            <div class="text-xs text-slate-400">S/ <%= String.format("%.2f", atencion.getCostoConsulta()) %></div>
                        </td>
                        <td class="px-6 py-4 text-right">
                            <div class="flex justify-end gap-2">
                                <a href="${pageContext.request.contextPath}/AtencionServlet?accion=ver&id=<%= atencion.getIdAtencionMedica() %>"
                                   class="px-3 py-2 rounded-lg bg-slate-100 text-slate-600">Ver</a>
                                <a href="${pageContext.request.contextPath}/AtencionServlet?accion=editar&id=<%= atencion.getIdAtencionMedica() %>"
                                   class="px-3 py-2 rounded-lg bg-blue-50 text-blue-600">Editar</a>
                                <% if (atencion.getIdEstadoAtencion() != 5) { %>
                                <form action="${pageContext.request.contextPath}/AtencionServlet" method="post">
                                    <input type="hidden" name="accion" value="cancelar">
                                    <input type="hidden" name="id" value="<%= atencion.getIdAtencionMedica() %>">
                                    <button type="submit" onclick="return confirm('¿Cancelar esta atención?')"
                                            class="px-3 py-2 rounded-lg bg-red-50 text-red-600">Cancelar</button>
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
        document.querySelectorAll('#tablaAtenciones tbody tr').forEach(row => {
            row.style.display = row.innerText.toUpperCase().includes(filtro) ? '' : 'none';
        });
    }
    lucide.createIcons();
</script>

<%@include file="../includes/footer.jsp" %>
