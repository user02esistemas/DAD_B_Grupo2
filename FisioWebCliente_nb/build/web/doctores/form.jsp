<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="fisioCore.dto.DoctorDTO"%>
<%@include file="../includes/header.jsp" %>
<%@include file="../includes/sidebar.jsp" %>

<%
    DoctorDTO doctor = (DoctorDTO) request.getAttribute("doctor");
    String error = (String) request.getAttribute("error");
%>

<div class="max-w-3xl mx-auto bg-white shadow-xl rounded-2xl border border-slate-200 p-8">
    <div class="mb-6 flex justify-between items-center border-b border-slate-100 pb-4">
        <h2 class="text-2xl font-bold text-slate-800">
            <%= doctor == null ? "Nuevo Doctor" : "Editar Doctor" %>
        </h2>
        <a href="${pageContext.request.contextPath}/DoctorServlet?accion=listar" class="text-slate-500 hover:text-slate-700">
            <i data-lucide="x" class="w-6 h-6"></i>
        </a>
    </div>

    <% if (error != null) { %>
    <div class="mb-6 bg-red-50 border-l-4 border-red-500 text-red-700 p-4 rounded-r-lg">
        <%= error %>
    </div>
    <% } %>

    <form action="${pageContext.request.contextPath}/DoctorServlet" method="post" class="grid grid-cols-1 md:grid-cols-2 gap-5">
        <input type="hidden" name="accion" value="<%= doctor == null ? "guardar" : "actualizar" %>">
        <% if (doctor != null) { %>
        <input type="hidden" name="id" value="<%= doctor.getIdDoctor() %>">
        <% } %>

        <div>
            <label class="block text-sm font-medium text-slate-700 mb-1">Nombres</label>
            <input type="text" name="nombres" required value="<%= doctor == null ? "" : doctor.getNombres() %>"
                   class="w-full border border-slate-200 rounded-xl px-3 py-2.5">
        </div>
        <div>
            <label class="block text-sm font-medium text-slate-700 mb-1">Apellidos</label>
            <input type="text" name="apellidos" required value="<%= doctor == null ? "" : doctor.getApellidos() %>"
                   class="w-full border border-slate-200 rounded-xl px-3 py-2.5">
        </div>
        <div>
            <label class="block text-sm font-medium text-slate-700 mb-1">DNI</label>
            <input type="text" name="dni" required maxlength="8" value="<%= doctor == null || doctor.getDni() == null ? "" : doctor.getDni() %>"
                   class="w-full border border-slate-200 rounded-xl px-3 py-2.5">
        </div>
        <div>
            <label class="block text-sm font-medium text-slate-700 mb-1">Número de colegiatura</label>
            <input type="text" name="cmp" required value="<%= doctor == null || doctor.getNumeroColegiatura() == null ? "" : doctor.getNumeroColegiatura() %>"
                   class="w-full border border-slate-200 rounded-xl px-3 py-2.5">
        </div>
        <div>
            <label class="block text-sm font-medium text-slate-700 mb-1">Teléfono</label>
            <input type="text" name="telefono" value="<%= doctor == null || doctor.getTelefono() == null ? "" : doctor.getTelefono() %>"
                   class="w-full border border-slate-200 rounded-xl px-3 py-2.5">
        </div>
        <div>
            <label class="block text-sm font-medium text-slate-700 mb-1">Correo</label>
            <input type="email" name="correo" value="<%= doctor == null || doctor.getCorreo() == null ? "" : doctor.getCorreo() %>"
                   class="w-full border border-slate-200 rounded-xl px-3 py-2.5">
        </div>

        <div class="md:col-span-2 flex justify-end gap-3 pt-4">
            <a href="${pageContext.request.contextPath}/DoctorServlet?accion=listar"
               class="px-5 py-2.5 rounded-xl text-slate-600 hover:bg-slate-100">Cancelar</a>
            <button type="submit" class="px-5 py-2.5 rounded-xl bg-emerald-600 text-white font-bold hover:bg-emerald-700">
                Guardar
            </button>
        </div>
    </form>
</div>

<script>lucide.createIcons();</script>
<%@include file="../includes/footer.jsp" %>
