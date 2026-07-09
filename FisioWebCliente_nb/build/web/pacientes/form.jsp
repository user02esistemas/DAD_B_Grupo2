<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="fisioCore.dto.PacienteDTO"%>
<%@include file="../includes/header.jsp" %>
<%@include file="../includes/sidebar.jsp" %>

<%
    if (session.getAttribute("adminLogueado") == null) {
        response.sendRedirect("../login.jsp");
        return;
    }

    PacienteDTO p = (PacienteDTO) request.getAttribute("paciente");
    String errorMsg = (String) request.getAttribute("error");
%>

<div class="max-w-4xl mx-auto bg-white shadow-md rounded px-8 pt-6 pb-8 mb-4">
    <div class="mb-6 border-b pb-2 flex justify-between items-center">
        <h2 class="text-2xl font-bold text-gray-800">
            <%= (p == null) ? "Registrar Nuevo Paciente" : "Editar Paciente" %>
        </h2>
        <a href="${pageContext.request.contextPath}/PacienteServlet?accion=listar" class="text-gray-500 hover:text-gray-700">
            <i data-lucide="x" class="w-6 h-6"></i>
        </a>
    </div>

    <% if(errorMsg != null) { %>
    <div class="bg-red-100 border-l-4 border-red-500 text-red-700 p-4 mb-6" role="alert">
        <p class="font-bold">Error</p>
        <p><%= errorMsg %></p>
    </div>
    <% } %>

    <form action="${pageContext.request.contextPath}/PacienteServlet" method="post" id="formPaciente">
        <input type="hidden" name="accion" value="<%= (p == null) ? "guardar" : "actualizar" %>">
        <% if(p != null) { %>
            <input type="hidden" name="id" value="<%= p.getIdPaciente() %>">
        <% } %>

        <div class="grid grid-cols-1 md:grid-cols-2 gap-4">
            <!-- Campos Obligatorios -->
             <div class="mb-4">
                <label class="block text-gray-700 text-sm font-bold mb-2" for="dni">DNI <span class="text-red-500">*</span></label>
                <input class="shadow appearance-none border rounded w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline" id="dni" name="dni" type="text" maxlength="8" value="<%= (p!=null)?p.getDni():"" %>" required>
            </div>
             <div class="mb-4">
                <label class="block text-gray-700 text-sm font-bold mb-2" for="hc">Historia Clínica (Opcional)</label>
                <input class="shadow appearance-none border rounded w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline" id="hc" name="hc" type="text" value="<%= (p!=null && p.getHistoriaClinicaCodigo()!=null)?p.getHistoriaClinicaCodigo():"" %>" placeholder="Auto-generado si vacío">
            </div>

            <div class="mb-4">
                <label class="block text-gray-700 text-sm font-bold mb-2" for="nombres">Nombres <span class="text-red-500">*</span></label>
                <input class="shadow appearance-none border rounded w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline" id="nombres" name="nombres" type="text" value="<%= (p!=null)?p.getNombres():"" %>" required>
            </div>
            <div class="mb-4">
                <label class="block text-gray-700 text-sm font-bold mb-2" for="apellidos">Apellidos <span class="text-red-500">*</span></label>
                <input class="shadow appearance-none border rounded w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline" id="apellidos" name="apellidos" type="text" value="<%= (p!=null)?p.getApellidos():"" %>" required>
            </div>
            
            <div class="mb-4">
                <label class="block text-gray-700 text-sm font-bold mb-2" for="genero">Género <span class="text-red-500">*</span></label>
                <select class="shadow border rounded w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline" id="genero" name="genero">
                    <option value="Femenino" <%= (p!=null && "Femenino".equals(p.getGenero()))?"selected":"" %>>Femenino</option>
                    <option value="Masculino" <%= (p!=null && "Masculino".equals(p.getGenero()))?"selected":"" %>>Masculino</option>
                </select>
            </div>
            <div class="mb-4">
                <label class="block text-gray-700 text-sm font-bold mb-2" for="fechaNacimiento">Fecha Nacimiento</label>
                <input class="shadow appearance-none border rounded w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline" id="fechaNacimiento" name="fechaNacimiento" type="date" value="<%= (p!=null && p.getFechaNacimiento()!=null)?p.getFechaNacimiento():"" %>">
            </div>
            <div class="mb-4">
                <label class="block text-gray-700 text-sm font-bold mb-2" for="telefono">Teléfono <span class="text-red-500">*</span></label>
                <input class="shadow appearance-none border rounded w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline" id="telefono" name="telefono" type="text" maxlength="9" value="<%= (p!=null)?p.getTelefono():"" %>">
            </div>
            <div class="mb-4">
                <label class="block text-gray-700 text-sm font-bold mb-2" for="correo">Correo Electrónico</label>
                <input class="shadow appearance-none border rounded w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline" id="correo" name="correo" type="email" value="<%= (p!=null)?p.getCorreoElectronico():"" %>">
            </div>
            <div class="mb-4 md:col-span-2">
                <label class="block text-gray-700 text-sm font-bold mb-2" for="direccion">Dirección</label>
                <input class="shadow appearance-none border rounded w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline" id="direccion" name="direccion" type="text" value="<%= (p!=null)?p.getDireccion():"" %>">
            </div>
        </div>

        <div class="flex items-center justify-end mt-6 gap-3">
            <a href="${pageContext.request.contextPath}/PacienteServlet?accion=listar" class="px-5 py-2.5 rounded-xl text-slate-600 font-medium hover:bg-slate-200 transition-colors">
                Cancelar
            </a>
            <button type="button" onclick="validarYGuardar()" class="px-5 py-2.5 rounded-xl bg-gradient-to-r from-blue-600 to-indigo-600 text-white font-bold shadow-lg shadow-blue-500/30 hover:shadow-blue-500/50 hover:-translate-y-0.5 transition-all flex items-center gap-2">
                <i data-lucide="save" class="w-4 h-4"></i> Guardar
            </button>
        </div>
    </form>
</div>

<!-- Custom Alert Modal -->
<div id="modalCustomAlert" class="fixed inset-0 bg-slate-900/60 backdrop-blur-sm hidden z-[70] flex items-center justify-center transition-opacity duration-300">
    <div class="bg-white w-full max-w-sm rounded-2xl shadow-2xl p-6 animate-fade-in-up text-center transform scale-100">
        <div class="w-16 h-16 bg-red-100 text-red-500 rounded-full flex items-center justify-center mx-auto mb-4 shadow-inner">
            <i data-lucide="alert-octagon" class="w-8 h-8"></i>
        </div>
        <h3 id="customAlertTitle" class="text-xl font-bold text-slate-800 mb-2"></h3>
        <p id="customAlertMessage" class="text-slate-500 text-sm mb-6 leading-relaxed"></p>
        <button onclick="cerrarModal('modalCustomAlert')" class="px-5 py-2.5 rounded-xl bg-gradient-to-r from-red-500 to-rose-500 text-white font-bold shadow-lg shadow-red-500/30 hover:shadow-red-500/50 hover:-translate-y-0.5 transition-all w-full flex justify-center">
            Entendido
        </button>
    </div>
</div>

<script>
    lucide.createIcons();

    function mostrarAlerta(titulo, mensaje) {
        document.getElementById('customAlertTitle').innerText = titulo;
        document.getElementById('customAlertMessage').innerText = mensaje;
        document.getElementById('modalCustomAlert').classList.remove('hidden');
        lucide.createIcons();
    }

    function cerrarModal(id) {
        document.getElementById(id).classList.add('hidden');
    }

    function validarYGuardar() {
        const dni = document.getElementById('dni').value;
        const nombres = document.getElementById('nombres').value;
        const apellidos = document.getElementById('apellidos').value;
        const telefono = document.getElementById('telefono').value; // telefono is optional here

        if(!dni || !nombres || !apellidos) { // telefono is optional
            mostrarAlerta("Campos Faltantes", "DNI, Nombres y Apellidos son obligatorios.");
            return;
        }

        if(!/^\d{8}$/.test(dni)) {
            mostrarAlerta("Formato DNI", "El DNI debe tener exactamente 8 dígitos numéricos.");
            return;
        }

        if(telefono && !/^\d{9}$/.test(telefono)) { // Only validate if telefono is provided
            mostrarAlerta("Formato Teléfono", "El teléfono debe tener exactamente 9 dígitos.");
            return;
        }
        
        // Si pasa validaciones
        document.getElementById('formPaciente').submit();
    }
</script>

<%@include file="../includes/footer.jsp" %>
