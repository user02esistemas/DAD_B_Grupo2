<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.Collections"%>
<%@page import="java.util.List"%>
<%@page import="java.util.Map"%>
<%@page import="fisioCore.dto.AtencionMedicaDTO"%>
<%@page import="fisioCore.dto.DoctorDTO"%>
<%@page import="fisioCore.dto.EspecializacionDTO"%>
<%@page import="fisioCore.dto.PacienteDTO"%>
<%@include file="../includes/header.jsp" %>
<%@include file="../includes/sidebar.jsp" %>

<%
    AtencionMedicaDTO atencion = (AtencionMedicaDTO) request.getAttribute("atencion");
    List<PacienteDTO> pacientes = (List<PacienteDTO>) request.getAttribute("listaPacientes");
    List<DoctorDTO> doctores = (List<DoctorDTO>) request.getAttribute("listaDoctores");
    List<EspecializacionDTO> especializaciones = (List<EspecializacionDTO>) request.getAttribute("listaEspecializaciones");
    Map<Integer, String> estados = (Map<Integer, String>) request.getAttribute("listaEstados");
    boolean soloLectura = Boolean.TRUE.equals(request.getAttribute("soloLectura"));
    if (pacientes == null) pacientes = Collections.emptyList();
    if (doctores == null) doctores = Collections.emptyList();
    if (especializaciones == null) especializaciones = Collections.emptyList();
    if (estados == null) estados = Collections.emptyMap();
    String fecha = atencion == null || atencion.getFechaHora() == null ? "" : atencion.getFechaHora().toString().substring(0, 10);
    String hora = atencion == null || atencion.getFechaHora() == null ? "" : atencion.getFechaHora().toString().substring(11, 16);
    String disabled = soloLectura ? "disabled" : "";
%>

<div class="max-w-4xl mx-auto bg-white shadow-xl rounded-2xl border border-slate-200 p-8">
    <div class="flex justify-between items-center border-b pb-4 mb-6">
        <h2 class="text-2xl font-bold text-slate-800">
            <%= soloLectura ? "Detalle de atención" : atencion == null ? "Nueva atención" : "Editar atención" %>
        </h2>
        <a href="${pageContext.request.contextPath}/AtencionServlet?accion=listar">Cerrar</a>
    </div>

    <form action="${pageContext.request.contextPath}/AtencionServlet" method="post" class="grid grid-cols-1 md:grid-cols-2 gap-5">
        <input type="hidden" name="accion" value="<%= atencion == null ? "guardar" : "actualizar" %>">
        <% if (atencion != null) { %>
        <input type="hidden" name="id" value="<%= atencion.getIdAtencionMedica() %>">
        <% } %>

        <div>
            <label class="block text-sm font-medium mb-1">Paciente</label>
            <select name="idPaciente" required <%= disabled %> class="w-full border rounded-xl px-3 py-2.5">
                <option value="">Seleccione</option>
                <% for (PacienteDTO paciente : pacientes) { %>
                <option value="<%= paciente.getIdPaciente() %>" <%= atencion != null && atencion.getIdPaciente() == paciente.getIdPaciente() ? "selected" : "" %>>
                    <%= paciente.getNombres() %> <%= paciente.getApellidos() %> - <%= paciente.getDni() %>
                </option>
                <% } %>
            </select>
        </div>
        <div>
            <label class="block text-sm font-medium mb-1">Servicio / Especialización</label>
            <select id="idEspecializacion" name="idEspecializacion" required <%= disabled %>
                    onchange="actualizarServicio(true)"
                    class="w-full border rounded-xl px-3 py-2.5">
                <option value="">Seleccione</option>
                <% for (EspecializacionDTO item : especializaciones) { %>
                <option value="<%= item.getIdEspecializacion() %>"
                        data-costo="<%= item.getCostoBase() == null ? "" : item.getCostoBase().toPlainString() %>"
                        <%= atencion != null && atencion.getIdEspecializacion() == item.getIdEspecializacion() ? "selected" : "" %>>
                    <%= item.getNombre() %>
                </option>
                <% } %>
            </select>
        </div>
        <div>
            <label class="block text-sm font-medium mb-1">Doctor</label>
            <select id="idDoctor" name="idDoctor" required <%= disabled %> class="w-full border rounded-xl px-3 py-2.5">
                <option value="">Seleccione</option>
                <% for (DoctorDTO doctor : doctores) {
                    StringBuilder idsEspecializaciones = new StringBuilder();
                    for (EspecializacionDTO item : doctor.getEspecializaciones()) {
                        if (idsEspecializaciones.length() > 0) idsEspecializaciones.append(',');
                        idsEspecializaciones.append(item.getIdEspecializacion());
                    }
                %>
                <option value="<%= doctor.getIdDoctor() %>"
                        data-especializaciones="<%= idsEspecializaciones %>"
                        <%= atencion != null && atencion.getIdDoctor() == doctor.getIdDoctor() ? "selected" : "" %>>
                    Dr. <%= doctor.getNombres() %> <%= doctor.getApellidos() %>
                </option>
                <% } %>
            </select>
        </div>
        <div>
            <label class="block text-sm font-medium mb-1">Fecha</label>
            <input type="date" name="fechaSolo" required value="<%= fecha %>" <%= disabled %> class="w-full border rounded-xl px-3 py-2.5">
        </div>
        <div>
            <label class="block text-sm font-medium mb-1">Hora</label>
            <input type="time" name="horaSolo" required value="<%= hora %>" <%= disabled %> class="w-full border rounded-xl px-3 py-2.5">
        </div>
        <div>
            <label class="block text-sm font-medium mb-1">Duración (minutos)</label>
            <input type="number" name="duracion" min="1" required value="<%= atencion == null ? 30 : atencion.getDuracionMinutos() %>" <%= disabled %> class="w-full border rounded-xl px-3 py-2.5">
        </div>
        <div>
            <label class="block text-sm font-medium mb-1">Estado</label>
            <select name="idEstado" required <%= disabled %> class="w-full border rounded-xl px-3 py-2.5">
                <% for (Map.Entry<Integer, String> estado : estados.entrySet()) { %>
                <option value="<%= estado.getKey() %>" <%= atencion != null && atencion.getIdEstadoAtencion() == estado.getKey() ? "selected" : "" %>>
                    <%= estado.getValue() %>
                </option>
                <% } %>
            </select>
        </div>
        <div class="md:col-span-2">
            <label class="block text-sm font-medium mb-1">Motivo u observaciones adicionales</label>
            <textarea name="motivo" <%= disabled %> class="w-full border rounded-xl px-3 py-2.5"><%= atencion == null || atencion.getMotivoConsulta() == null ? "" : atencion.getMotivoConsulta() %></textarea>
        </div>
        <div>
            <label class="block text-sm font-medium mb-1">Costo</label>
            <input id="costo" type="number" name="costo" min="0" step="0.01" required value="<%= atencion == null ? "0.00" : atencion.getCostoConsulta() %>" <%= disabled %> class="w-full border rounded-xl px-3 py-2.5">
        </div>

        <div class="md:col-span-2 flex justify-end gap-3 pt-4">
            <a href="${pageContext.request.contextPath}/AtencionServlet?accion=listar" class="px-5 py-2.5 rounded-xl text-slate-600">Volver</a>
            <% if (!soloLectura) { %>
            <button type="submit" class="px-5 py-2.5 rounded-xl bg-pink-600 text-white font-bold">Guardar</button>
            <% } %>
        </div>
    </form>
</div>

<script>
function actualizarServicio(actualizarCosto) {
    const servicio = document.getElementById('idEspecializacion');
    const doctores = document.getElementById('idDoctor');
    const idEspecializacion = servicio.value;
    const doctorSeleccionado = doctores.value;

    Array.from(doctores.options).forEach((opcion, indice) => {
        if (indice === 0) return;
        const ids = (opcion.dataset.especializaciones || '').split(',').filter(Boolean);
        const compatible = !idEspecializacion || ids.includes(idEspecializacion);
        opcion.hidden = !compatible;
        opcion.disabled = !compatible;
    });

    const opcionDoctor = doctores.options[doctores.selectedIndex];
    if (doctorSeleccionado && opcionDoctor && opcionDoctor.disabled) {
        doctores.value = '';
    }

    if (actualizarCosto) {
        const opcionServicio = servicio.options[servicio.selectedIndex];
        const costoBase = opcionServicio ? opcionServicio.dataset.costo : '';
        if (costoBase !== '') {
            document.getElementById('costo').value = Number(costoBase).toFixed(2);
        }
    }
}

document.addEventListener('DOMContentLoaded', function () {
    actualizarServicio(false);
});
</script>

<%@include file="../includes/footer.jsp" %>
