<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.Collections"%>
<%@page import="java.util.List"%>
<%@page import="fisioCore.dto.EspecializacionDTO"%>
<%@include file="../includes/header.jsp" %>
<%@include file="../includes/sidebar.jsp" %>
<%
    List<EspecializacionDTO> lista =
            (List<EspecializacionDTO>) request.getAttribute("listaEspecializaciones");
    EspecializacionDTO especializacion =
            (EspecializacionDTO) request.getAttribute("especializacion");
    boolean mostrarFormulario = Boolean.TRUE.equals(request.getAttribute("mostrarFormulario"));
    String filtroActual = (String) request.getAttribute("filtroActual");
    String mensaje = (String) request.getAttribute("mensaje");
    String error = (String) request.getAttribute("error");
    if (lista == null) lista = Collections.emptyList();
    if (filtroActual == null) filtroActual = "activas";
%>

<div class="animate-fade-in-up">
    <div class="flex flex-col md:flex-row justify-between items-start md:items-center mb-8 gap-4">
        <div>
            <h2 class="text-3xl font-bold text-slate-800">Servicios / Especializaciones</h2>
            <p class="text-slate-500 text-lg">Catálogo clínico, costos base y disponibilidad</p>
        </div>
        <div class="flex gap-3 w-full md:w-auto">
            <input id="searchInput" onkeyup="filtrarTabla()" placeholder="Buscar especialización..."
                   class="w-full md:w-64 px-4 py-3 border rounded-xl">
            <a href="${pageContext.request.contextPath}/EspecializacionServlet?accion=nuevo&vista=<%= filtroActual %>"
               class="bg-gradient-to-r from-purple-600 to-violet-600 text-white font-semibold py-3 px-6 rounded-xl whitespace-nowrap">
                Nuevo servicio
            </a>
        </div>
    </div>

    <div class="flex flex-wrap gap-2 mb-5">
        <a href="${pageContext.request.contextPath}/EspecializacionServlet?accion=listarActivas"
           class="px-4 py-2 rounded-xl <%= "activas".equals(filtroActual) ? "bg-purple-600 text-white" : "bg-white border text-slate-600" %>">Activos</a>
        <a href="${pageContext.request.contextPath}/EspecializacionServlet?accion=listarInactivas"
           class="px-4 py-2 rounded-xl <%= "inactivas".equals(filtroActual) ? "bg-purple-600 text-white" : "bg-white border text-slate-600" %>">Inactivos</a>
        <a href="${pageContext.request.contextPath}/EspecializacionServlet?accion=listarTodas"
           class="px-4 py-2 rounded-xl <%= "todas".equals(filtroActual) ? "bg-purple-600 text-white" : "bg-white border text-slate-600" %>">Todos</a>
    </div>

    <% if (mensaje != null) { %>
    <div class="mb-4 rounded-xl bg-emerald-50 text-emerald-700 px-4 py-3"><%= mensaje %></div>
    <% } %>
    <% if (error != null) { %>
    <div class="mb-4 rounded-xl bg-red-50 text-red-700 px-4 py-3"><%= error %></div>
    <% } %>

    <% if (mostrarFormulario) { %>
    <div class="mb-8 bg-white shadow-xl rounded-2xl border border-purple-100 p-6">
        <h3 class="text-xl font-bold text-slate-800 mb-5">
            <%= especializacion == null ? "Nueva especialización" : "Editar especialización" %>
        </h3>
        <form action="${pageContext.request.contextPath}/EspecializacionServlet" method="post"
              class="grid grid-cols-1 md:grid-cols-2 gap-5">
            <input type="hidden" name="accion" value="<%= especializacion == null ? "guardar" : "actualizar" %>">
            <input type="hidden" name="vista" value="<%= filtroActual %>">
            <% if (especializacion != null) { %>
            <input type="hidden" name="id" value="<%= especializacion.getIdEspecializacion() %>">
            <input type="hidden" name="estado" value="<%= especializacion.isEstado() %>">
            <% } %>

            <label class="block">Nombre
                <input name="nombre" maxlength="150" required
                       value="<%= especializacion == null ? "" : especializacion.getNombre() %>"
                       class="w-full border rounded-xl px-3 py-2.5 mt-1">
            </label>
            <label class="block">Costo base sugerido
                <input type="number" name="costoBase" min="0" step="0.01"
                       value="<%= especializacion == null || especializacion.getCostoBase() == null ? "" : especializacion.getCostoBase() %>"
                       class="w-full border rounded-xl px-3 py-2.5 mt-1">
            </label>
            <label class="block md:col-span-2">Descripción
                <textarea name="descripcion" maxlength="500" rows="3"
                          class="w-full border rounded-xl px-3 py-2.5 mt-1"><%= especializacion == null || especializacion.getDescripcion() == null ? "" : especializacion.getDescripcion() %></textarea>
            </label>
            <div class="md:col-span-2 flex justify-end gap-3">
                <a href="${pageContext.request.contextPath}/EspecializacionServlet?accion=<%= "todas".equals(filtroActual) ? "listarTodas" : "inactivas".equals(filtroActual) ? "listarInactivas" : "listarActivas" %>"
                   class="px-5 py-2.5 text-slate-600">Cancelar</a>
                <button class="px-5 py-2.5 rounded-xl bg-purple-600 text-white font-semibold">Guardar</button>
            </div>
        </form>
    </div>
    <% } %>

    <div class="bg-white shadow-xl rounded-2xl border border-slate-200 overflow-hidden">
        <div class="overflow-x-auto">
            <table class="w-full text-sm text-left" id="tablaEspecializaciones">
                <thead class="bg-slate-50 border-b text-slate-500 uppercase text-xs">
                    <tr>
                        <th class="px-6 py-4">Nombre</th>
                        <th class="px-6 py-4">Descripción</th>
                        <th class="px-6 py-4">Costo base</th>
                        <th class="px-6 py-4">Estado</th>
                        <th class="px-6 py-4">Auditoría</th>
                        <th class="px-6 py-4 text-right">Acciones</th>
                    </tr>
                </thead>
                <tbody class="divide-y divide-slate-100">
                    <% if (lista.isEmpty()) { %>
                    <tr><td colspan="6" class="px-6 py-10 text-center text-slate-400">No hay servicios para este filtro.</td></tr>
                    <% } %>
                    <% for (EspecializacionDTO item : lista) { %>
                    <tr class="hover:bg-slate-50">
                        <td class="px-6 py-4 font-bold text-slate-700"><%= item.getNombre() %></td>
                        <td class="px-6 py-4 text-slate-600"><%= item.getDescripcion() == null ? "-" : item.getDescripcion() %></td>
                        <td class="px-6 py-4 font-semibold"><%= item.getCostoBase() == null ? "Sin definir" : "S/ " + item.getCostoBase() %></td>
                        <td class="px-6 py-4">
                            <span class="px-3 py-1 rounded-full bg-emerald-50 text-emerald-700"><%= item.isEstado() ? "Activo" : "Inactivo" %></span>
                        </td>
                        <td class="px-6 py-4 text-xs text-slate-400">
                            <div>Creado: <%= item.getFechaCreacion() == null ? "-" : item.getFechaCreacion().toString().substring(0, 10) %></div>
                            <div>Actualizado: <%= item.getFechaActualizacion() == null ? "-" : item.getFechaActualizacion().toString().substring(0, 10) %></div>
                        </td>
                        <td class="px-6 py-4">
                            <div class="flex justify-end gap-2">
                                <a href="${pageContext.request.contextPath}/EspecializacionServlet?accion=editar&id=<%= item.getIdEspecializacion() %>&vista=<%= filtroActual %>"
                                   class="px-3 py-2 rounded-lg bg-purple-50 text-purple-700">Editar</a>
                                <% if (item.isEstado()) { %>
                                <form action="${pageContext.request.contextPath}/EspecializacionServlet" method="post"
                                      onsubmit="return confirm('¿Desactivar esta especialización?');">
                                    <input type="hidden" name="accion" value="desactivar">
                                    <input type="hidden" name="id" value="<%= item.getIdEspecializacion() %>">
                                    <button class="px-3 py-2 rounded-lg bg-red-50 text-red-600">Desactivar</button>
                                </form>
                                <% } else { %>
                                <form action="${pageContext.request.contextPath}/EspecializacionServlet" method="post"
                                      onsubmit="return confirm('¿Reactivar esta especialización?');">
                                    <input type="hidden" name="accion" value="reactivar">
                                    <input type="hidden" name="id" value="<%= item.getIdEspecializacion() %>">
                                    <button class="px-3 py-2 rounded-lg bg-emerald-50 text-emerald-700">Reactivar</button>
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
    document.querySelectorAll('#tablaEspecializaciones tbody tr').forEach(fila => {
        fila.style.display = fila.textContent.toUpperCase().includes(filtro) ? '' : 'none';
    });
}
</script>
<%@include file="../includes/footer.jsp" %>
