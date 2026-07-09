<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.Collections"%>
<%@page import="java.util.List"%>
<%@page import="fisioCore.dto.AtencionMedicaDTO"%>
<%@include file="includes/header.jsp" %>
<%@include file="includes/sidebar.jsp" %>

<%
    // Check login
    if (session.getAttribute("adminLogueado") == null) {
        response.sendRedirect("login.jsp");
        return;
    }
    if (request.getAttribute("totalPacientes") == null) {
        response.sendRedirect(request.getContextPath() + "/DashboardServlet");
        return;
    }

    Integer pacientesRequest = (Integer) request.getAttribute("totalPacientes");
    Integer doctoresRequest = (Integer) request.getAttribute("totalDoctores");
    Integer atencionesRequest = (Integer) request.getAttribute("totalAtenciones");
    Integer facturasRequest = (Integer) request.getAttribute("totalFacturas");
    int countPacientes = pacientesRequest == null ? 0 : pacientesRequest;
    int countDoctores = doctoresRequest == null ? 0 : doctoresRequest;
    int countAtenciones = atencionesRequest == null ? 0 : atencionesRequest;
    int countFacturas = facturasRequest == null ? 0 : facturasRequest;
    List<AtencionMedicaDTO> atenciones =
            (List<AtencionMedicaDTO>) request.getAttribute("ultimasAtenciones");
    if (atenciones == null) atenciones = Collections.emptyList();
    String errorDashboard = (String) request.getAttribute("error");

    // Date Formatting in Spanish
    java.time.LocalDate hoy = java.time.LocalDate.now();
    java.time.format.DateTimeFormatter fmt = java.time.format.DateTimeFormatter.ofPattern("EEEE, d 'de' MMMM 'de' yyyy", new java.util.Locale("es", "ES"));
    String fechaStr = hoy.format(fmt);
    fechaStr = fechaStr.substring(0, 1).toUpperCase() + fechaStr.substring(1);
%>

<div class="mb-8 flex flex-col md:flex-row md:items-center justify-between gap-4">
    <div class="animate-fade-in-up">
        <h2 class="text-3xl font-bold text-slate-800 tracking-tight">Dashboard</h2>
        <p class="text-slate-500 mt-1 text-lg">Resumen general de la clínica</p>
    </div>
    <div class="flex gap-3 animate-fade-in-up" style="animation-delay: 0.1s">
        <div class="bg-white px-5 py-2.5 rounded-xl shadow-md border border-slate-200 flex items-center gap-2 text-slate-700 text-sm font-semibold">
            <i data-lucide="calendar" class="w-4 h-4 text-brand"></i>
            <span><%= fechaStr%></span>
        </div>
    </div>
</div>

<% if (errorDashboard != null) { %>
<div class="mb-6 rounded-xl bg-red-50 border border-red-200 text-red-700 px-4 py-3"><%= errorDashboard %></div>
<% } %>

<!-- Stats Cards -->
<div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-6 mb-10">
    <!-- Card 1 -->
    <div class="bg-gradient-to-br from-blue-500 to-blue-600 rounded-2xl p-6 text-white shadow-lg shadow-blue-500/30 transform hover:-translate-y-1 transition-all duration-300 animate-fade-in-up" style="animation-delay: 0.1s">
        <div class="flex justify-between items-start">
            <div>
                <p class="text-blue-100 font-medium text-sm uppercase tracking-wider">Pacientes</p>
                <h3 class="text-4xl font-bold mt-2"><%= countPacientes%></h3>
            </div>
            <div class="bg-white/20 p-3 rounded-xl backdrop-blur-sm">
                <i data-lucide="users" class="w-6 h-6 text-white"></i>
            </div>
        </div>
        <div class="mt-4 flex items-center text-blue-100 text-sm">
            <i data-lucide="trending-up" class="w-4 h-4 mr-1"></i>
            <span>Activos</span>
        </div>
    </div>

    <!-- Card 2 -->
    <div class="bg-gradient-to-br from-emerald-500 to-teal-600 rounded-2xl p-6 text-white shadow-lg shadow-emerald-500/30 transform hover:-translate-y-1 transition-all duration-300 animate-fade-in-up" style="animation-delay: 0.2s">
        <div class="flex justify-between items-start">
            <div>
                <p class="text-emerald-100 font-medium text-sm uppercase tracking-wider">Doctores</p>
                <h3 class="text-4xl font-bold mt-2"><%= countDoctores%></h3>
            </div>
            <div class="bg-white/20 p-3 rounded-xl backdrop-blur-sm">
                <i data-lucide="stethoscope" class="w-6 h-6 text-white"></i>
            </div>
        </div>
        <div class="mt-4 flex items-center text-emerald-100 text-sm">
            <span class="bg-white/20 px-2 py-0.5 rounded text-xs">Staff Médico</span>
        </div>
    </div>

    <!-- Card 3 -->
    <div class="bg-gradient-to-br from-brand to-purple-600 rounded-2xl p-6 text-white shadow-lg shadow-pink-500/30 transform hover:-translate-y-1 transition-all duration-300 animate-fade-in-up" style="animation-delay: 0.3s">
        <div class="flex justify-between items-start">
            <div>
                <p class="text-pink-100 font-medium text-sm uppercase tracking-wider">Atenciones</p>
                <h3 class="text-4xl font-bold mt-2"><%= countAtenciones%></h3>
            </div>
            <div class="bg-white/20 p-3 rounded-xl backdrop-blur-sm">
                <i data-lucide="activity" class="w-6 h-6 text-white"></i>
            </div>
        </div>
        <div class="mt-4 flex items-center text-pink-100 text-sm">
            <i data-lucide="clock" class="w-4 h-4 mr-1"></i>
            <span>Total Histórico</span>
        </div>
    </div>

    <!-- Card 4 -->
    <div class="bg-gradient-to-br from-amber-500 to-orange-600 rounded-2xl p-6 text-white shadow-lg shadow-orange-500/30 transform hover:-translate-y-1 transition-all duration-300 animate-fade-in-up" style="animation-delay: 0.4s">
        <div class="flex justify-between items-start">
            <div>
                <p class="text-orange-100 font-medium text-sm uppercase tracking-wider">Facturas</p>
                <h3 class="text-4xl font-bold mt-2"><%= countFacturas%></h3>
            </div>
            <div class="bg-white/20 p-3 rounded-xl backdrop-blur-sm">
                <i data-lucide="file-text" class="w-6 h-6 text-white"></i>
            </div>
        </div>
        <div class="mt-4 flex items-center text-orange-100 text-sm">
            <span>Registradas</span>
        </div>
    </div>
</div>

<!-- Content Grid -->
<div class="grid grid-cols-1 xl:grid-cols-3 gap-8 animate-fade-in-up" style="animation-delay: 0.5s">
    <!-- Recent Activity Table -->
    <div class="xl:col-span-2 bg-white rounded-2xl shadow-xl border border-slate-200 flex flex-col overflow-hidden relative">
        <div class="absolute top-0 left-0 w-1 h-full bg-gradient-to-b from-brand to-purple-600"></div>
        <div class="p-6 border-b border-slate-100 flex justify-between items-center bg-slate-50/30">
            <div>
                <h3 class="text-lg font-bold text-slate-800">Últimas Atenciones</h3>
                <p class="text-slate-500 text-sm">Registro reciente de pacientes</p>
            </div>
            <a href="${pageContext.request.contextPath}/AtencionServlet?accion=listar" class="text-sm font-medium text-brand hover:text-brand-dark flex items-center gap-1 transition-colors">
                Ver todas <i data-lucide="arrow-right" class="w-4 h-4"></i>
            </a>
        </div>
        <div class="overflow-x-auto flex-1">
            <table class="w-full text-sm text-left">
                <thead class="bg-slate-50 text-slate-500 font-semibold uppercase text-xs">
                    <tr>
                        <th class="px-6 py-4">Paciente</th>
                        <th class="px-6 py-4">Doctor</th>
                        <th class="px-6 py-4">Fecha</th>
                        <th class="px-6 py-4">Estado</th>
                    </tr>
                </thead>
                <tbody class="divide-y divide-slate-100">
                    <% if (atenciones.isEmpty()) { %>
                    <tr><td colspan="4" class="px-6 py-10 text-center text-slate-400">No hay atenciones registradas.</td></tr>
                    <% } %>
                    <%
                        for (AtencionMedicaDTO a : atenciones) {
                            String statusColor = "bg-slate-100 text-slate-600";
                            String statusIcon = "circle";
                            if ("Pendiente".equals(a.getNombreEstado())) {
                                statusColor = "bg-amber-100 text-amber-700";
                                statusIcon = "clock";
                            }
                            if ("En proceso".equals(a.getNombreEstado())) {
                                statusColor = "bg-blue-100 text-blue-700";
                                statusIcon = "loader";
                            }
                            if ("Finalizado".equals(a.getNombreEstado())) {
                                statusColor = "bg-emerald-100 text-emerald-700";
                                statusIcon = "check-circle";
                            }
                    %>
                    <tr class="hover:bg-slate-50/80 transition-colors group">
                        <td class="px-6 py-4">
                            <div class="flex items-center gap-3">
                                <div class="w-8 h-8 rounded-full bg-brand/10 flex items-center justify-center text-brand font-bold text-xs">
                                    <%= a.getNombrePaciente() == null || a.getNombrePaciente().isEmpty() ? "?" : a.getNombrePaciente().substring(0, 1)%>
                                </div>
                                <span class="font-medium text-slate-700 group-hover:text-brand transition-colors"><%= a.getNombrePaciente()%></span>
                            </div>
                        </td>
                        <td class="px-6 py-4 text-slate-600"><%= a.getNombreDoctor()%></td>
                        <td class="px-6 py-4 text-slate-500"><%= a.getFechaHora() == null ? "-" : a.getFechaHora().toString().substring(0, 16)%></td>
                        <td class="px-6 py-4">
                            <span class="<%= statusColor%> py-1 px-3 rounded-full text-xs font-semibold flex items-center w-fit gap-1.5">
                                <i data-lucide="<%= statusIcon%>" class="w-3 h-3"></i>
                                <%= a.getNombreEstado()%>
                            </span>
                        </td>
                    </tr>
                    <% }%>
                </tbody>
            </table>
        </div>
    </div>

    <!-- Side Widget / Quick Actions -->
    <div class="xl:col-span-1 space-y-6">
        <div class="bg-gradient-to-br from-slate-800 to-slate-900 rounded-2xl p-6 text-white shadow-xl relative overflow-hidden">
            <div class="absolute top-0 right-0 -mt-4 -mr-4 w-24 h-24 bg-white/10 rounded-full blur-xl"></div>
            <h3 class="text-xl font-bold mb-2 relative z-10">Acciones Rápidas</h3>
            <p class="text-slate-400 text-sm mb-6 relative z-10">Gestión eficiente para hoy</p>

            <div class="space-y-3 relative z-10">
                <a href="${pageContext.request.contextPath}/AtencionServlet?accion=nuevo" class="flex items-center p-3 bg-white/10 hover:bg-white/20 rounded-xl transition-all cursor-pointer border border-white/5">
                    <div class="bg-brand p-2 rounded-lg mr-3">
                        <i data-lucide="plus" class="w-5 h-5"></i>
                    </div>
                    <div>
                        <p class="font-semibold">Nueva Cita</p>
                        <p class="text-xs text-slate-400">Agendar atención médica</p>
                    </div>
                </a>
                <a href="${pageContext.request.contextPath}/PacienteServlet?accion=nuevo" class="flex items-center p-3 bg-white/10 hover:bg-white/20 rounded-xl transition-all cursor-pointer border border-white/5">
                    <div class="bg-blue-500 p-2 rounded-lg mr-3">
                        <i data-lucide="user-plus" class="w-5 h-5"></i>
                    </div>
                    <div>
                        <p class="font-semibold">Registrar Paciente</p>
                        <p class="text-xs text-slate-400">Añadir nuevo expediente</p>
                    </div>
                </a>
            </div>
        </div>

        <div class="bg-white rounded-2xl shadow-soft border border-slate-100 p-6">
            <h3 class="text-lg font-bold text-slate-800 mb-4">Datos sincronizados por RMI</h3>
            <div class="grid grid-cols-2 gap-3 text-sm">
                <div class="rounded-xl bg-blue-50 p-3"><span class="text-slate-500 block">Pacientes</span><strong class="text-blue-700 text-xl"><%= countPacientes %></strong></div>
                <div class="rounded-xl bg-emerald-50 p-3"><span class="text-slate-500 block">Doctores</span><strong class="text-emerald-700 text-xl"><%= countDoctores %></strong></div>
                <div class="rounded-xl bg-pink-50 p-3"><span class="text-slate-500 block">Atenciones</span><strong class="text-pink-700 text-xl"><%= countAtenciones %></strong></div>
                <div class="rounded-xl bg-amber-50 p-3"><span class="text-slate-500 block">Facturas</span><strong class="text-amber-700 text-xl"><%= countFacturas %></strong></div>
            </div>
        </div>
    </div>
</div>

<%@include file="includes/footer.jsp" %>
