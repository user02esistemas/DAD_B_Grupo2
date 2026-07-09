<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.Collections"%>
<%@page import="java.util.List"%>
<%@page import="fisioCore.dto.PacienteDTO"%>
<%@include file="../includes/header.jsp" %>
<%@include file="../includes/sidebar.jsp" %>

<%
    if (session.getAttribute("adminLogueado") == null) {
        response.sendRedirect("../login.jsp");
        return;
    }
%>

<div class="animate-fade-in-up">
    <%
        String mensaje = (String) request.getAttribute("mensaje");
        if (mensaje != null) {
    %>
    <div class="mb-6 bg-emerald-50 border-l-4 border-emerald-500 text-emerald-700 p-4 rounded-r-lg">
        <%= mensaje %>
    </div>
    <% } %>
    <% if (request.getAttribute("error") != null) { %>
    <div class="mb-6 bg-red-50 border-l-4 border-red-500 text-red-700 p-4 rounded-r-lg">
        <%= request.getAttribute("error") %>
    </div>
    <% } %>

    <!-- Header Section -->
    <div class="flex flex-col md:flex-row justify-between items-start md:items-center mb-8 gap-4">
        <div>
            <h2 class="text-3xl font-bold text-slate-800 tracking-tight">Pacientes</h2>
            <p class="text-slate-500 text-lg">Directorio general de expedientes</p>
        </div>
        
        <div class="flex flex-col sm:flex-row gap-3 w-full md:w-auto">
            <div class="relative w-full md:w-64">
                <i data-lucide="search" class="absolute left-3 top-1/2 -translate-y-1/2 w-5 h-5 text-slate-400"></i>
                <input type="text" id="searchInput" onkeyup="filtrarTabla()" placeholder="Buscar paciente..." class="w-full pl-10 pr-4 py-3 border border-slate-200 rounded-xl focus:outline-none focus:ring-2 focus:ring-blue-500/20 focus:border-blue-500 transition-all shadow-sm">
            </div>

            <button onclick="abrirModalNuevo()" class="bg-gradient-to-r from-blue-600 to-indigo-600 hover:from-blue-700 hover:to-indigo-700 text-white font-semibold py-3 px-6 rounded-xl shadow-lg shadow-blue-500/30 hover:shadow-blue-500/50 transform hover:-translate-y-0.5 transition-all flex items-center justify-center gap-2 whitespace-nowrap">
                <i data-lucide="user-plus" class="w-5 h-5"></i>
                <span>Nuevo Paciente</span>
            </button>
        </div>
    </div>

    <!-- Table Card -->
    <div class="bg-white shadow-xl rounded-2xl border border-slate-200 overflow-hidden relative">
        <div class="absolute top-0 left-0 w-1 h-full bg-gradient-to-b from-blue-500 to-indigo-600"></div>
        
        <div class="overflow-x-auto">
            <table class="w-full text-sm text-left" id="tablaPacientes">
                <thead class="bg-slate-50/80 border-b border-slate-100 text-slate-500 font-semibold uppercase text-xs">
                    <tr>
                        <th class="px-6 py-4 pl-8">Perfil Paciente</th>
                        <th class="px-6 py-4">Historia Clínica</th>
                        <th class="px-6 py-4">Contacto</th>
                        <th class="px-6 py-4">Ubicación</th>
                        <th class="px-6 py-4">Auditoría</th>
                        <th class="px-6 py-4 text-right pr-8">Acciones</th>
                    </tr>
                </thead>
                <tbody class="divide-y divide-slate-100">
                    <%
                        List<PacienteDTO> lista = (List<PacienteDTO>) request.getAttribute("listaPacientes");
                        if (lista == null) {
                            lista = Collections.emptyList();
                        }
                        for(PacienteDTO p : lista) {
                            String inicial = (p.getNombres() != null && p.getNombres().length() > 0) ? p.getNombres().substring(0,1) : "?";
                            String generoColor = "Femenino".equalsIgnoreCase(p.getGenero()) ? "bg-pink-100 text-pink-600" : "bg-blue-100 text-blue-600";
                            String fechaCrea = (p.getFechaCreacion()!=null)?p.getFechaCreacion().toString().substring(0,10):"-";
                            String fechaAct = (p.getFechaActualizacion()!=null)?p.getFechaActualizacion().toString().substring(0,10):"-";
                    %>
                    <tr class="hover:bg-slate-50 transition-colors group">
                        <td class="px-6 py-4 pl-8">
                            <div class="flex items-center gap-4">
                                <div class="w-12 h-12 rounded-full bg-gradient-to-br from-slate-100 to-slate-200 border border-slate-300 flex items-center justify-center text-slate-600 font-bold text-lg shadow-sm">
                                    <%= inicial %>
                                </div>
                                <div>
                                    <div class="font-bold text-slate-800 text-base group-hover:text-blue-600 transition-colors">
                                        <%= p.getNombres() %> <%= p.getApellidos() %>
                                    </div>
                                    <div class="flex items-center gap-2 mt-1">
                                        <span class="text-xs bg-slate-100 text-slate-500 px-2 py-0.5 rounded border border-slate-200 font-mono">
                                            DNI: <%= (p.getDni()!=null)?p.getDni():"N/A" %>
                                        </span>
                                        <span class="text-xs <%= generoColor %> px-2 py-0.5 rounded border border-current opacity-70 font-medium">
                                            <%= p.getGenero() %>
                                        </span>
                                    </div>
                                </div>
                            </div>
                        </td>
                        <td class="px-6 py-4">
                            <div class="flex items-center gap-2 text-slate-700 bg-slate-50 px-3 py-1.5 rounded-lg w-fit border border-slate-200">
                                <i data-lucide="file-digit" class="w-4 h-4 text-blue-500"></i>
                                <span class="font-semibold font-mono"><%= (p.getHistoriaClinicaCodigo()!=null)?p.getHistoriaClinicaCodigo():"-" %></span>
                            </div>
                        </td>
                        <td class="px-6 py-4">
                            <div class="space-y-1">
                                <div class="flex items-center gap-2 text-slate-600">
                                    <i data-lucide="phone" class="w-3.5 h-3.5 text-slate-400"></i>
                                    <span><%= (p.getTelefono()!=null && !p.getTelefono().isEmpty())?p.getTelefono():"Sin teléfono" %></span>
                                </div>
                                <div class="flex items-center gap-2 text-slate-600">
                                    <i data-lucide="mail" class="w-3.5 h-3.5 text-slate-400"></i>
                                    <span class="text-xs"><%= (p.getCorreoElectronico()!=null && !p.getCorreoElectronico().isEmpty())?p.getCorreoElectronico():"Sin correo" %></span>
                                </div>
                            </div>
                        </td>
                        <td class="px-6 py-4 text-slate-500 text-sm max-w-xs truncate">
                            <div class="flex items-center gap-2" title="<%= p.getDireccion() %>">
                                <i data-lucide="map-pin" class="w-3.5 h-3.5 text-slate-400"></i>
                                <%= (p.getDireccion()!=null && !p.getDireccion().isEmpty()) ? p.getDireccion() : "-" %>
                            </div>
                        </td>
                        <td class="px-6 py-4 text-xs text-slate-400">
                            <div>Creado: <%= fechaCrea %></div>
                            <% if(!fechaAct.equals("-")) { %>
                                <div class="text-blue-400">Mod: <%= fechaAct %></div>
                            <% } %>
                        </td>
                        <td class="px-6 py-4 pr-8 text-right">
                            <div class="flex items-center justify-end gap-2">
                                <button onclick="editarPaciente('<%= p.getIdPaciente() %>', '<%= p.getNombres() %>', '<%= p.getApellidos() %>', '<%= p.getDni() %>', '<%= p.getGenero() %>', '<%= p.getFechaNacimiento() %>', '<%= p.getTelefono() %>', '<%= p.getCorreoElectronico() %>', '<%= p.getDireccion() %>', '<%= p.getHistoriaClinicaCodigo() %>')" 
                                        class="w-9 h-9 rounded-lg bg-blue-50 text-blue-600 hover:bg-blue-500 hover:text-white flex items-center justify-center transition-all shadow-sm hover:shadow-md tooltip" 
                                        title="Editar">
                                    <i data-lucide="pencil" class="w-4 h-4"></i>
                                </button>
                                <button onclick="confirmarEliminar('<%= p.getIdPaciente() %>')" 
                                   class="w-9 h-9 rounded-lg bg-red-50 text-red-500 hover:bg-red-500 hover:text-white flex items-center justify-center transition-all shadow-sm hover:shadow-md tooltip" 
                                   title="Eliminar">
                                    <i data-lucide="trash-2" class="w-4 h-4"></i>
                                </button>
                            </div>
                        </td>
                    </tr>
                    <% } %>
                </tbody>
            </table>
        </div>
    </div>
</div>

<!-- MODAL STYLE -->
<style>
    .modal-enter { animation: modalEnter 0.3s ease-out forwards; }
    @keyframes modalEnter {
        from { opacity: 0; transform: translateY(20px) scale(0.95); }
        to { opacity: 1; transform: translateY(0) scale(1); }
    }
</style>

<!-- Modal Paciente (Formulario) -->
<div id="modalPaciente" class="fixed inset-0 bg-slate-900/60 backdrop-blur-sm hidden z-50 flex items-center justify-center transition-opacity duration-300">
    <div class="modal-enter bg-white w-full max-w-3xl rounded-2xl shadow-2xl flex flex-col max-h-[90vh] overflow-hidden">
        <div class="p-6 border-b border-slate-100 flex justify-between items-center bg-slate-50/50">
            <h3 class="text-xl font-bold text-slate-800 flex items-center gap-2" id="modalTitle">
                <i data-lucide="user-plus" class="w-6 h-6 text-blue-500"></i> Nuevo Paciente
            </h3>
            <button onclick="cerrarModal('modalPaciente')" class="text-slate-400 hover:text-red-500 transition-colors p-1 hover:bg-red-50 rounded-full">
                <i data-lucide="x" class="w-6 h-6"></i>
            </button>
        </div>
        
        <div class="p-8 overflow-y-auto">
            <form action="${pageContext.request.contextPath}/PacienteServlet" method="post" id="formPaciente">
                <input type="hidden" id="accion" name="accion" value="guardar">
                <input type="hidden" id="id" name="id" value="">
                
                <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
                    <div class="md:col-span-2">
                        <h4 class="text-xs font-bold text-blue-500 uppercase tracking-wider mb-4 border-b border-blue-100 pb-2">Identificación</h4>
                    </div>

                    <div class="space-y-2">
                        <label class="text-sm font-medium text-slate-700">DNI <span class="text-red-500">*</span></label>
                        <div class="relative">
                            <i data-lucide="credit-card" class="absolute left-3 top-1/2 -translate-y-1/2 w-4 h-4 text-slate-400"></i>
                            <input type="text" id="dni" name="dni" maxlength="8" class="w-full pl-10 border border-slate-200 bg-slate-50 rounded-xl text-sm py-2.5 focus:ring-2 focus:ring-blue-200 focus:border-blue-500 transition-all focus:bg-white" placeholder="8 dígitos" required>
                        </div>
                    </div>
                    <div class="space-y-2">
                        <label class="text-sm font-medium text-slate-700">Historia Clínica (HC) <span class="text-red-500">*</span></label>
                        <div class="relative">
                            <i data-lucide="file-digit" class="absolute left-3 top-1/2 -translate-y-1/2 w-4 h-4 text-slate-400"></i>
                            <input type="text" id="hc" name="hc" class="w-full pl-10 border border-slate-200 bg-slate-50 rounded-xl text-sm py-2.5 focus:ring-2 focus:ring-blue-200 focus:border-blue-500 transition-all focus:bg-white" placeholder="Ej: HC-001">
                        </div>
                    </div>

                    <div class="space-y-2">
                        <label class="text-sm font-medium text-slate-700">Nombres <span class="text-red-500">*</span></label>
                        <input type="text" id="nombres" name="nombres" class="w-full border border-slate-200 bg-slate-50 rounded-xl text-sm py-2.5 focus:ring-2 focus:ring-blue-200 focus:border-blue-500 transition-all focus:bg-white" placeholder="Nombres completos" required>
                    </div>
                    <div class="space-y-2">
                        <label class="text-sm font-medium text-slate-700">Apellidos <span class="text-red-500">*</span></label>
                        <input type="text" id="apellidos" name="apellidos" class="w-full border border-slate-200 bg-slate-50 rounded-xl text-sm py-2.5 focus:ring-2 focus:ring-blue-200 focus:border-blue-500 transition-all focus:bg-white" placeholder="Apellidos completos" required>
                    </div>

                    <div class="space-y-2">
                        <label class="text-sm font-medium text-slate-700">Género <span class="text-red-500">*</span></label>
                        <select id="genero" name="genero" class="w-full border border-slate-200 bg-slate-50 rounded-xl text-sm py-2.5 focus:ring-2 focus:ring-blue-200 focus:border-blue-500 transition-all focus:bg-white">
                            <option value="Femenino">Femenino</option>
                            <option value="Masculino">Masculino</option>
                        </select>
                    </div>
                    <div class="space-y-2">
                        <label class="text-sm font-medium text-slate-700">Fecha Nacimiento <span class="text-red-500">*</span></label>
                        <input type="date" id="fechaNacimiento" name="fechaNacimiento" class="w-full border border-slate-200 bg-slate-50 rounded-xl text-sm py-2.5 focus:ring-2 focus:ring-blue-200 focus:border-blue-500 transition-all text-slate-600 focus:bg-white">
                    </div>

                    <div class="md:col-span-2 mt-2">
                        <h4 class="text-xs font-bold text-blue-500 uppercase tracking-wider mb-4 border-b border-blue-100 pb-2">Contacto</h4>
                    </div>

                    <div class="space-y-2">
                        <label class="text-sm font-medium text-slate-700">Teléfono <span class="text-red-500">*</span></label>
                        <div class="relative">
                            <i data-lucide="phone" class="absolute left-3 top-1/2 -translate-y-1/2 w-4 h-4 text-slate-400"></i>
                            <input type="text" id="telefono" name="telefono" minlength="9" maxlength="9" class="w-full pl-10 border border-slate-200 bg-slate-50 rounded-xl text-sm py-2.5 focus:ring-2 focus:ring-blue-200 focus:border-blue-500 transition-all focus:bg-white" placeholder="Celular o fijo">
                        </div>
                    </div>
                    <div class="space-y-2">
                        <label class="text-sm font-medium text-slate-700">Correo Electrónico</label>
                        <div class="relative">
                            <i data-lucide="mail" class="absolute left-3 top-1/2 -translate-y-1/2 w-4 h-4 text-slate-400"></i>
                            <input type="email" id="correo" name="correo" class="w-full pl-10 border border-slate-200 bg-slate-50 rounded-xl text-sm py-2.5 focus:ring-2 focus:ring-blue-200 focus:border-blue-500 transition-all focus:bg-white" placeholder="ejemplo@correo.com">
                        </div>
                    </div>
                    <div class="md:col-span-2 space-y-2">
                        <label class="text-sm font-medium text-slate-700">Dirección</label>
                        <div class="relative">
                            <i data-lucide="map-pin" class="absolute left-3 top-1/2 -translate-y-1/2 w-4 h-4 text-slate-400"></i>
                            <input type="text" id="direccion" name="direccion" class="w-full pl-10 border border-slate-200 bg-slate-50 rounded-xl text-sm py-2.5 focus:ring-2 focus:ring-blue-200 focus:border-blue-500 transition-all focus:bg-white" placeholder="Dirección completa">
                        </div>
                    </div>
                </div>
            </form>
        </div>

        <div class="p-6 border-t border-slate-100 bg-slate-50 flex justify-end gap-3">
            <button type="button" onclick="cerrarModal('modalPaciente')" class="px-5 py-2.5 rounded-xl text-slate-600 font-medium hover:bg-slate-200 transition-colors">
                Cancelar
            </button>
            <button type="button" onclick="validarYGuardar()" class="px-5 py-2.5 rounded-xl bg-gradient-to-r from-blue-600 to-indigo-600 text-white font-bold shadow-lg shadow-blue-500/30 hover:shadow-blue-500/50 hover:-translate-y-0.5 transition-all flex items-center gap-2">
                <i data-lucide="save" class="w-4 h-4"></i> Guardar Paciente
            </button>
        </div>
    </div>
</div>

<!-- Modal Validación (Estilo Alerta) -->
<div id="modalValidation" class="fixed inset-0 bg-slate-900/60 backdrop-blur-sm hidden z-[70] flex items-center justify-center transition-opacity duration-300">
    <div class="bg-white w-full max-w-sm rounded-2xl shadow-2xl p-6 animate-fade-in-up text-center transform scale-100">
        <div class="w-16 h-16 bg-amber-100 text-amber-500 rounded-full flex items-center justify-center mx-auto mb-4 shadow-inner">
            <i data-lucide="alert-circle" class="w-8 h-8"></i>
        </div>
        <h3 class="text-xl font-bold text-slate-800 mb-2">Campos Incompletos</h3>
        <p class="text-slate-500 text-sm mb-6 leading-relaxed">Por favor, completa todos los campos obligatorios marcados con asterisco (*) para continuar.</p>
        <button onclick="cerrarModal('modalValidation')" class="px-5 py-2.5 rounded-xl bg-gradient-to-r from-amber-500 to-orange-500 text-white font-bold shadow-lg shadow-amber-500/30 hover:shadow-amber-500/50 hover:-translate-y-0.5 transition-all w-full flex justify-center">
            Entendido
        </button>
    </div>
</div>

<!-- Modal Eliminar (Generic) -->
<div id="modalDelete" class="fixed inset-0 bg-slate-900/60 backdrop-blur-sm hidden z-[60] flex items-center justify-center transition-opacity duration-300">
    <div class="bg-white w-full max-w-sm rounded-2xl shadow-2xl p-6 animate-fade-in-up text-center transform scale-100">
        <div class="w-16 h-16 bg-red-100 text-red-500 rounded-full flex items-center justify-center mx-auto mb-4 shadow-inner">
            <i data-lucide="alert-triangle" class="w-8 h-8"></i>
        </div>
        <h3 class="text-xl font-bold text-slate-800 mb-2">¿Eliminar registro?</h3>
        <p class="text-slate-500 text-sm mb-6 leading-relaxed">Esta acción no se puede deshacer. El registro será eliminado permanentemente del sistema.</p>
        <div class="flex gap-3 justify-center">
            <button onclick="cerrarModal('modalDelete')" class="px-5 py-2.5 rounded-xl text-slate-600 font-medium hover:bg-slate-100 transition-colors border border-slate-200 w-full">Cancelar</button>
            <form action="${pageContext.request.contextPath}/PacienteServlet" method="post" class="w-full">
                <input type="hidden" name="accion" value="eliminar">
                <input type="hidden" id="deleteId" name="id" value="">
                <button type="submit" class="px-5 py-2.5 rounded-xl bg-gradient-to-r from-red-600 to-rose-600 text-white font-bold shadow-lg shadow-red-500/30 hover:shadow-red-500/50 hover:-translate-y-0.5 transition-all w-full flex justify-center">Sí, Eliminar</button>
            </form>
        </div>
    </div>
</div>

<script>
    function filtrarTabla() {
        const input = document.getElementById("searchInput");
        const filter = input.value.toUpperCase();
        const table = document.getElementById("tablaPacientes");
        const tr = table.getElementsByTagName("tr");
        for (let i = 0; i < tr.length; i++) {
            const td = tr[i].getElementsByTagName("td");
            if (td.length > 0) {
                const txtValue = tr[i].textContent || tr[i].innerText;
                if (txtValue.toUpperCase().indexOf(filter) > -1) tr[i].style.display = "";
                else tr[i].style.display = "none";
            }
        }
    }

    function abrirModalNuevo() {
        document.getElementById('modalTitle').innerHTML = '<i data-lucide="user-plus" class="w-6 h-6 text-blue-500"></i> Nuevo Paciente';
        document.getElementById('accion').value = "guardar";
        document.getElementById('id').value = "";
        
        const ids = ['dni','hc','nombres','apellidos','telefono','correo','direccion','fechaNacimiento'];
        ids.forEach(id => {
            const el = document.getElementById(id);
            el.value = "";
            if(['dni','nombres','apellidos','fechaNacimiento'].includes(id)) {
                el.removeAttribute('readonly');
                el.classList.remove('bg-slate-200', 'text-slate-500', 'cursor-not-allowed');
                el.classList.add('bg-slate-50', 'focus:bg-white');
            }
        });

        const gen = document.getElementById('genero');
        gen.classList.remove('pointer-events-none', 'bg-slate-200', 'text-slate-500');
        gen.classList.add('bg-white');
        
        document.getElementById('modalPaciente').classList.remove('hidden');
        lucide.createIcons(); 
    }

    function editarPaciente(id, nombres, apellidos, dni, genero, fecha, tel, correo, dir, hc) {
        document.getElementById('modalTitle').innerHTML = '<i data-lucide="pencil" class="w-6 h-6 text-blue-500"></i> Editar Paciente';
        document.getElementById('accion').value = "actualizar";
        document.getElementById('id').value = id;
        
        document.getElementById('nombres').value = nombres;
        document.getElementById('apellidos').value = apellidos;
        document.getElementById('dni').value = (dni === 'null') ? '' : dni;
        document.getElementById('genero').value = genero;
        document.getElementById('fechaNacimiento').value = (fecha === 'null') ? '' : fecha;
        document.getElementById('telefono').value = (tel === 'null') ? '' : tel;
        document.getElementById('correo').value = (correo === 'null') ? '' : correo;
        document.getElementById('direccion').value = (dir === 'null') ? '' : dir;
        document.getElementById('hc').value = (hc === 'null') ? '' : hc;
        
        const lockIds = ['dni','nombres','apellidos','fechaNacimiento'];
        lockIds.forEach(id => {
            const el = document.getElementById(id);
            el.setAttribute('readonly', true);
            el.classList.remove('bg-slate-50', 'focus:bg-white');
            el.classList.add('bg-slate-200', 'text-slate-500', 'cursor-not-allowed');
        });

        const gen = document.getElementById('genero');
        gen.classList.add('pointer-events-none', 'bg-slate-200', 'text-slate-500');
        gen.classList.remove('bg-white');
        
        document.getElementById('modalPaciente').classList.remove('hidden');
        lucide.createIcons();
    }

    function cerrarModal(id) {
        document.getElementById(id).classList.add('hidden');
    }
    
    function confirmarEliminar(id) {
        document.getElementById('deleteId').value = id;
        document.getElementById('modalDelete').classList.remove('hidden');
    }

    function validarYGuardar() {
        const fields = ['dni', 'hc', 'nombres', 'apellidos', 'genero', 'fechaNacimiento', 'telefono'];
        let isValid = true;

        fields.forEach(id => {
            const el = document.getElementById(id);
            if (!el.value || el.value.trim() === '') {
                isValid = false;
                el.classList.add('border-red-500', 'ring-1', 'ring-red-500');
                el.classList.remove('border-slate-200');
                
                el.addEventListener('input', function() {
                    this.classList.remove('border-red-500', 'ring-1', 'ring-red-500');
                    this.classList.add('border-slate-200');
                }, { once: true });
            }
        });

        const telefonoEl = document.getElementById('telefono');
        if (telefonoEl.value && telefonoEl.value.length !== 9) {
            isValid = false;
            telefonoEl.classList.add('border-red-500', 'ring-1', 'ring-red-500');
            telefonoEl.classList.remove('border-slate-200');
            telefonoEl.addEventListener('input', function() {
                this.classList.remove('border-red-500', 'ring-1', 'ring-red-500');
                this.classList.add('border-slate-200');
            }, { once: true });
        }

        if (!isValid) {
            document.getElementById('modalValidation').classList.remove('hidden');
            lucide.createIcons();
        } else {
            document.getElementById('formPaciente').submit();
        }
    }
    
    lucide.createIcons();
</script>

<%@include file="../includes/footer.jsp" %>
