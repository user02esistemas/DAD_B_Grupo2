<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.Collections"%>
<%@page import="java.util.List"%>
<%@page import="fisioCore.dto.DoctorDTO"%>
<%@include file="../includes/header.jsp" %>
<%@include file="../includes/sidebar.jsp" %>

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
            <h2 class="text-3xl font-bold text-slate-800 tracking-tight">Doctores</h2>
            <p class="text-slate-500 text-lg">Staff médico y especialistas</p>
        </div>
        
        <div class="flex flex-col sm:flex-row gap-3 w-full md:w-auto">
            <!-- Search Bar -->
            <div class="relative w-full md:w-64">
                <i data-lucide="search" class="absolute left-3 top-1/2 -translate-y-1/2 w-5 h-5 text-slate-400"></i>
                <input type="text" id="searchInput" onkeyup="filtrarTabla()" placeholder="Buscar doctor..." class="w-full pl-10 pr-4 py-3 border border-slate-200 rounded-xl focus:outline-none focus:ring-2 focus:ring-emerald-500/20 focus:border-emerald-500 transition-all shadow-sm">
            </div>

            <button onclick="abrirModalNuevo()" class="bg-gradient-to-r from-emerald-500 to-teal-600 hover:from-emerald-600 hover:to-teal-700 text-white font-semibold py-3 px-6 rounded-xl shadow-lg shadow-emerald-500/30 hover:shadow-emerald-500/50 transform hover:-translate-y-0.5 transition-all flex items-center justify-center gap-2 whitespace-nowrap">
                <i data-lucide="user-plus" class="w-5 h-5"></i>
                <span>Nuevo Doctor</span>
            </button>
        </div>
    </div>

    <!-- Table Card -->
    <div class="bg-white shadow-xl rounded-2xl border border-slate-200 overflow-hidden relative">
        <div class="absolute top-0 left-0 w-1 h-full bg-gradient-to-b from-emerald-500 to-teal-600"></div>
        
        <div class="overflow-x-auto">
            <table class="w-full text-sm text-left" id="tablaDoctores">
                <thead class="bg-slate-50/80 border-b border-slate-100 text-slate-500 font-semibold uppercase text-xs">
                    <tr>
                        <th class="px-6 py-4 pl-8">Doctor</th>
                        <th class="px-6 py-4">Estado</th>
                        <th class="px-6 py-4">Identificación</th>
                        <th class="px-6 py-4">Contacto</th>
                        <th class="px-6 py-4">Auditoría</th>
                        <th class="px-6 py-4 text-right pr-8">Acciones</th>
                    </tr>
                </thead>
                <tbody class="divide-y divide-slate-100">
                    <%
                        List<DoctorDTO> lista = (List<DoctorDTO>) request.getAttribute("listaDoctores");
                        if (lista == null) {
                            lista = Collections.emptyList();
                        }
                        
                        for(DoctorDTO d : lista) {
                            String inicial = (d.getNombres() != null && d.getNombres().length() > 0) ? d.getNombres().substring(0,1) : "?";
                            String fechaCrea = (d.getFechaRegistro()!=null)?d.getFechaRegistro().toString().substring(0,10):"-";
                            String fechaAct = (d.getFechaActualizacion()!=null)?d.getFechaActualizacion().toString().substring(0,10):"-";
                    %>
                    <tr class="hover:bg-slate-50 transition-colors group">
                        <td class="px-6 py-4 pl-8">
                            <div class="flex items-center gap-4">
                                <div class="w-12 h-12 rounded-full bg-emerald-50 text-emerald-600 flex items-center justify-center font-bold text-lg border border-emerald-100 shadow-sm">
                                    <%= inicial %>
                                </div>
                                <div>
                                    <div class="font-bold text-slate-800 text-base group-hover:text-emerald-600 transition-colors">
                                        Dr. <%= d.getNombres() %> <%= d.getApellidos() %>
                                    </div>
                                    <span class="text-xs bg-emerald-50 text-emerald-700 px-2 py-0.5 rounded border border-emerald-100 font-medium">
                                        CMP: <%= (d.getNumeroColegiatura()!=null)?d.getNumeroColegiatura():"Pendiente" %>
                                    </span>
                                </div>
                            </div>
                        </td>
                        <td class="px-6 py-4">
                            <span class="bg-emerald-50 text-emerald-700 px-2 py-1 rounded text-xs border border-emerald-100 font-medium">
                                <%= d.isEstado() ? "Activo" : "Inactivo" %>
                            </span>
                        </td>
                        <td class="px-6 py-4">
                            <div class="flex items-center gap-2 text-slate-600">
                                <i data-lucide="credit-card" class="w-4 h-4 text-slate-400"></i>
                                <span><%= (d.getDni()!=null)?d.getDni():"-" %></span>
                            </div>
                        </td>
                        <td class="px-6 py-4">
                            <div class="space-y-1">
                                <div class="flex items-center gap-2 text-slate-600">
                                    <i data-lucide="phone" class="w-3.5 h-3.5 text-slate-400"></i>
                                    <span><%= (d.getTelefono()!=null)?d.getTelefono():"-" %></span>
                                </div>
                                <div class="flex items-center gap-2 text-slate-600">
                                    <i data-lucide="mail" class="w-3.5 h-3.5 text-slate-400"></i>
                                    <span class="text-xs"><%= (d.getCorreo()!=null)?d.getCorreo():"-" %></span>
                                </div>
                            </div>
                        </td>
                        <td class="px-6 py-4 text-xs text-slate-400">
                            <div>Reg: <%= fechaCrea %></div>
                            <% if(!fechaAct.equals("-")) { %>
                                <div class="text-emerald-600">Mod: <%= fechaAct %></div>
                            <% } %>
                        </td>
                        <td class="px-6 py-4 pr-8 text-right">
                            <div class="flex items-center justify-end gap-2">
                                <button onclick="editarDoctor('<%= d.getIdDoctor() %>', '<%= d.getNombres() %>', '<%= d.getApellidos() %>', '<%= d.getNumeroColegiatura() %>', '<%= d.getDni() %>', '<%= d.getTelefono() %>', '<%= d.getCorreo() %>')" 
                                        class="w-9 h-9 rounded-lg bg-emerald-50 text-emerald-600 hover:bg-emerald-500 hover:text-white flex items-center justify-center transition-all shadow-sm hover:shadow-md" 
                                        title="Editar">
                                    <i data-lucide="pencil" class="w-4 h-4"></i>
                                </button>
                                <button onclick="confirmarEliminar('<%= d.getIdDoctor() %>')" 
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

<!-- Modal Doctor -->
<div id="modalDoctor" class="fixed inset-0 bg-slate-900/60 backdrop-blur-sm hidden z-50 flex items-center justify-center transition-opacity duration-300">
    <div class="bg-white w-full max-w-lg rounded-2xl shadow-2xl flex flex-col overflow-hidden animate-fade-in-up max-h-[90vh]">
        <div class="p-6 border-b border-slate-100 flex justify-between items-center bg-slate-50/50">
            <h3 class="text-xl font-bold text-slate-800 flex items-center gap-2" id="modalTitle">
                Nuevo Doctor
            </h3>
            <button onclick="cerrarModal('modalDoctor')" class="text-slate-400 hover:text-red-500 transition-colors p-1 hover:bg-red-50 rounded-full">
                <i data-lucide="x" class="w-6 h-6"></i>
            </button>
        </div>
        
        <div class="p-8 overflow-y-auto">
            <form action="${pageContext.request.contextPath}/DoctorServlet" method="post" id="formDoctor">
                <input type="hidden" id="accion" name="accion" value="guardar">
                <input type="hidden" id="id" name="id" value="">
                
                <div class="grid grid-cols-1 gap-4">
                    <div>
                        <label class="text-sm font-medium text-slate-700 mb-1 block">Nombres <span class="text-red-500">*</span></label>
                        <input type="text" id="nombres" name="nombres" class="w-full border border-slate-200 bg-slate-50 rounded-xl text-sm py-2.5 px-3 focus:ring-2 focus:ring-emerald-200 focus:border-emerald-500 transition-all focus:bg-white" required>
                    </div>
                    <div>
                        <label class="text-sm font-medium text-slate-700 mb-1 block">Apellidos <span class="text-red-500">*</span></label>
                        <input type="text" id="apellidos" name="apellidos" class="w-full border border-slate-200 bg-slate-50 rounded-xl text-sm py-2.5 px-3 focus:ring-2 focus:ring-emerald-200 focus:border-emerald-500 transition-all focus:bg-white" required>
                    </div>
                    
                    <div class="grid grid-cols-2 gap-4">
                        <div>
                            <label class="text-sm font-medium text-slate-700 mb-1 block">DNI <span class="text-red-500">*</span></label>
                            <div class="relative">
                                <i data-lucide="credit-card" class="absolute left-3 top-1/2 -translate-y-1/2 w-4 h-4 text-slate-400"></i>
                                <input type="text" id="dni" name="dni" maxlength="8" class="w-full pl-10 border border-slate-200 bg-slate-50 rounded-xl text-sm py-2.5 focus:ring-2 focus:ring-emerald-200 focus:border-emerald-500 transition-all focus:bg-white">
                            </div>
                        </div>
                        <div>
                            <label class="text-sm font-medium text-slate-700 mb-1 block">N° Colegiatura <span class="text-red-500">*</span></label>
                            <div class="relative">
                                <i data-lucide="award" class="absolute left-3 top-1/2 -translate-y-1/2 w-4 h-4 text-slate-400"></i>
                                <input type="text" id="cmp" name="cmp" class="w-full pl-10 border border-slate-200 bg-slate-50 rounded-xl text-sm py-2.5 focus:ring-2 focus:ring-emerald-200 focus:border-emerald-500 transition-all focus:bg-white">
                            </div>
                        </div>
                    </div>

                    <div>
                        <label class="text-sm font-medium text-slate-700 mb-1 block">Teléfono <span class="text-red-500">*</span></label>
                        <div class="relative">
                            <i data-lucide="phone" class="absolute left-3 top-1/2 -translate-y-1/2 w-4 h-4 text-slate-400"></i>
                            <input type="text" id="telefono" name="telefono" minlength="9" maxlength="9" class="w-full pl-10 border border-slate-200 bg-slate-50 rounded-xl text-sm py-2.5 focus:ring-2 focus:ring-emerald-200 focus:border-emerald-500 transition-all focus:bg-white">
                        </div>
                    </div>
                    <div>
                        <label class="text-sm font-medium text-slate-700 mb-1 block">Correo <span class="text-red-500">*</span></label>
                        <div class="relative">
                            <i data-lucide="mail" class="absolute left-3 top-1/2 -translate-y-1/2 w-4 h-4 text-slate-400"></i>
                            <input type="email" id="correo" name="correo" class="w-full pl-10 border border-slate-200 bg-slate-50 rounded-xl text-sm py-2.5 focus:ring-2 focus:ring-emerald-200 focus:border-emerald-500 transition-all focus:bg-white">
                        </div>
                    </div>
                </div>
            </form>
        </div>

        <div class="p-6 border-t border-slate-100 bg-slate-50 flex justify-end gap-3">
            <button type="button" onclick="cerrarModal('modalDoctor')" class="px-5 py-2.5 rounded-xl text-slate-600 font-medium hover:bg-slate-200 transition-colors">Cancelar</button>
            <button type="button" onclick="validarYGuardar()" class="px-5 py-2.5 rounded-xl bg-gradient-to-r from-emerald-500 to-teal-600 text-white font-bold shadow-lg shadow-emerald-500/30 hover:shadow-emerald-500/50 hover:-translate-y-0.5 transition-all flex items-center gap-2">
                <i data-lucide="save" class="w-4 h-4"></i> Guardar
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
            <form action="${pageContext.request.contextPath}/DoctorServlet" method="post" class="w-full">
                <input type="hidden" name="accion" value="eliminar">
                <input type="hidden" id="deleteDoctorId" name="id" value="">
                <button type="submit" class="px-5 py-2.5 rounded-xl bg-gradient-to-r from-red-600 to-rose-600 text-white font-bold shadow-lg shadow-red-500/30 hover:shadow-red-500/50 hover:-translate-y-0.5 transition-all w-full flex justify-center">Sí, Eliminar</button>
            </form>
        </div>
    </div>
</div>

<script>
    document.addEventListener('DOMContentLoaded', function() {
        lucide.createIcons();
    });

    function filtrarTabla() {
        const input = document.getElementById("searchInput");
        const filter = input.value.toUpperCase();
        const table = document.getElementById("tablaDoctores");
        const tr = table.getElementsByTagName("tr");

        for (let i = 0; i < tr.length; i++) {
            const td = tr[i].getElementsByTagName("td");
            if (td.length > 0) {
                const txtValue = tr[i].textContent || tr[i].innerText;
                if (txtValue.toUpperCase().indexOf(filter) > -1) {
                    tr[i].style.display = "";
                } else {
                    tr[i].style.display = "none";
                }
            }
        }
    }

    function abrirModalNuevo() {
        document.getElementById('modalTitle').innerHTML = '<i data-lucide="user-plus" class="w-6 h-6 text-emerald-500"></i> Nuevo Doctor';
        document.getElementById('accion').value = "guardar";
        document.getElementById('id').value = "";
        document.getElementById('modalDoctor').classList.remove('hidden');
        
        ['nombres','apellidos','dni','cmp','telefono','correo'].forEach(id => document.getElementById(id).value = "");
        
        lucide.createIcons();
    }

    function editarDoctor(id, nom, ape, cmp, dni, tel, corr) {
        document.getElementById('modalTitle').innerHTML = '<i data-lucide="pencil" class="w-6 h-6 text-emerald-500"></i> Editar Doctor';
        document.getElementById('accion').value = "actualizar";
        document.getElementById('id').value = id;
        document.getElementById('modalDoctor').classList.remove('hidden');
        
        document.getElementById('nombres').value = nom;
        document.getElementById('apellidos').value = ape;
        document.getElementById('dni').value = (dni==='null')?'':dni;
        document.getElementById('cmp').value = (cmp==='null')?'':cmp;
        document.getElementById('telefono').value = (tel==='null')?'':tel;
        document.getElementById('correo').value = (corr==='null')?'':corr;
        
        lucide.createIcons();
    }

    function cerrarModal(id) {
        document.getElementById(id).classList.add('hidden');
    }
    
    function confirmarEliminar(id) {
        document.getElementById('deleteDoctorId').value = id;
        document.getElementById('modalDelete').classList.remove('hidden');
    }

    function validarYGuardar() {
        const fields = ['nombres', 'apellidos', 'dni', 'cmp', 'telefono', 'correo'];
        let isValid = true;

        // Validar campos de texto
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

        // Validar longitud del teléfono
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
            document.getElementById('formDoctor').submit();
        }
    }
    
    lucide.createIcons();
</script>

<%@include file="../includes/footer.jsp" %>
