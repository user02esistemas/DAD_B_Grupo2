<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!-- Sidebar Wrapper -->
<div class="flex h-screen overflow-hidden bg-slate-50">
    
    <!-- Mobile Overlay (Background dimming) -->
    <div id="mobileOverlay" onclick="toggleSidebarMobile()" class="fixed inset-0 bg-slate-900/50 z-40 hidden md:hidden transition-opacity backdrop-blur-sm"></div>

    <!-- Sidebar Element -->
    <aside id="mainSidebar" class="bg-slate-900 text-white shadow-2xl flex flex-col transition-all duration-300 z-50 fixed md:relative h-full w-64 -translate-x-full md:translate-x-0 group/sidebar">
        
        <!-- Header / Logo -->
            <div class="h-20 flex items-center px-8 border-b border-slate-800 bg-slate-950">
                <div class="flex items-center gap-3 text-brand-DEFAULT">
                    <div class="min-w-[32px] flex justify-center">
                        <img src="${pageContext.request.contextPath}/assets/logo-sidebar.png" alt="Zully Logo" class="w-8 h-auto object-contain">
                    </div>
                    <span class="text-2xl font-bold tracking-tight text-white sidebar-text opacity-100 transition-opacity duration-300">Zully<span class="text-brand-DEFAULT">.Admin</span></span>
                </div>
            </div>

        <!-- Toggle Button (Desktop) - Absolute positioned on the border -->
        <button onclick="toggleSidebarDesktop()" class="hidden md:flex absolute -right-3 top-24 bg-brand text-white p-1.5 rounded-full shadow-lg border-2 border-slate-50 hover:bg-pink-700 transition-transform hover:scale-110 z-50 items-center justify-center">
            <i id="toggleIcon" data-lucide="chevron-left" class="w-4 h-4"></i>
        </button>

        <!-- Navigation Links -->
        <nav class="flex-1 overflow-y-auto overflow-x-hidden py-6 px-3 space-y-1 custom-scrollbar">
            
            <!-- Section Label -->
            <p class="px-4 text-xs font-bold text-slate-600 uppercase tracking-wider mb-2 mt-2 sidebar-text truncate transition-all duration-300">Principal</p>
            
            <a href="${pageContext.request.contextPath}/DashboardServlet" 
               class="flex items-center px-3 py-3 text-slate-300 rounded-xl hover:bg-white/10 hover:text-white transition-all group relative" title="Dashboard">
                <div class="min-w-[40px] flex justify-center">
                    <i data-lucide="layout-dashboard" class="w-6 h-6 group-hover:text-brand-DEFAULT transition-colors"></i>
                </div>
                <span class="font-medium whitespace-nowrap sidebar-text opacity-100 transition-opacity duration-300 ml-2">Dashboard</span>
                
                <!-- Tooltip for collapsed state -->
                <div class="absolute left-14 bg-slate-800 text-white text-xs px-2 py-1 rounded opacity-0 group-hover:opacity-100 md:hidden pointer-events-none transition-opacity z-50 whitespace-nowrap sidebar-tooltip">
                    Dashboard
                </div>
            </a>

            <p class="px-4 text-xs font-bold text-slate-600 uppercase tracking-wider mb-2 mt-6 sidebar-text truncate transition-all duration-300">Gestión</p>

            <a href="${pageContext.request.contextPath}/PacienteServlet?accion=listar" 
               class="flex items-center px-3 py-3 text-slate-300 rounded-xl hover:bg-white/10 hover:text-white transition-all group relative" title="Pacientes">
                <div class="min-w-[40px] flex justify-center">
                    <i data-lucide="users" class="w-6 h-6 group-hover:text-blue-400 transition-colors"></i>
                </div>
                <span class="font-medium whitespace-nowrap sidebar-text opacity-100 transition-opacity duration-300 ml-2">Pacientes</span>
            </a>
            
            <a href="${pageContext.request.contextPath}/DoctorServlet?accion=listar" 
               class="flex items-center px-3 py-3 text-slate-300 rounded-xl hover:bg-white/10 hover:text-white transition-all group relative" title="Doctores">
                <div class="min-w-[40px] flex justify-center">
                    <i data-lucide="stethoscope" class="w-6 h-6 group-hover:text-emerald-400 transition-colors"></i>
                </div>
                <span class="font-medium whitespace-nowrap sidebar-text opacity-100 transition-opacity duration-300 ml-2">Doctores</span>
            </a>
            
            <a href="${pageContext.request.contextPath}/AtencionServlet?accion=listar" 
               class="flex items-center px-3 py-3 text-slate-300 rounded-xl hover:bg-white/10 hover:text-white transition-all group relative" title="Citas & Atenciones">
                <div class="min-w-[40px] flex justify-center">
                    <i data-lucide="calendar-heart" class="w-6 h-6 group-hover:text-brand-DEFAULT transition-colors"></i>
                </div>
                <span class="font-medium whitespace-nowrap sidebar-text opacity-100 transition-opacity duration-300 ml-2">Atenciones</span>
            </a>
            
            <a href="${pageContext.request.contextPath}/FacturaServlet?accion=listar" 
               class="flex items-center px-3 py-3 text-slate-300 rounded-xl hover:bg-white/10 hover:text-white transition-all group relative" title="Facturación">
                <div class="min-w-[40px] flex justify-center">
                    <i data-lucide="receipt" class="w-6 h-6 group-hover:text-amber-400 transition-colors"></i>
                </div>
                <span class="font-medium whitespace-nowrap sidebar-text opacity-100 transition-opacity duration-300 ml-2">Facturación</span>
            </a>

            <p class="px-4 text-xs font-bold text-slate-600 uppercase tracking-wider mb-2 mt-6 sidebar-text truncate transition-all duration-300">Sistema</p>

            <a href="${pageContext.request.contextPath}/EspecializacionServlet?accion=listarActivas" 
               class="flex items-center px-3 py-3 text-slate-300 rounded-xl hover:bg-white/10 hover:text-white transition-all group relative" title="Servicios">
                <div class="min-w-[40px] flex justify-center">
                    <i data-lucide="settings-2" class="w-6 h-6 group-hover:text-purple-400 transition-colors"></i>
                </div>
                <span class="font-medium whitespace-nowrap sidebar-text opacity-100 transition-opacity duration-300 ml-2">Servicios</span>
            </a>
        </nav>

        <!-- User / Logout Area -->
        <div class="p-4 border-t border-slate-800 bg-slate-950">
            <a href="${pageContext.request.contextPath}/logout.jsp" 
               class="flex items-center px-3 py-3 text-slate-400 rounded-xl hover:bg-red-500/10 hover:text-red-400 transition-all w-full group relative" title="Cerrar Sesión">
                <div class="min-w-[40px] flex justify-center">
                    <i data-lucide="log-out" class="w-6 h-6"></i>
                </div>
                <span class="font-medium whitespace-nowrap sidebar-text opacity-100 transition-opacity duration-300 ml-2">Cerrar Sesión</span>
            </a>
        </div>
    </aside>
    
    <!-- Content Wrapper -->
    <div class="flex-1 flex flex-col h-screen overflow-hidden bg-slate-50 relative w-full transition-all duration-300">
        
        <!-- Topbar (Mobile Only) -->
        <header class="md:hidden bg-white shadow-sm h-16 flex items-center justify-between px-4 z-30 sticky top-0">
            <div class="flex items-center gap-2 text-brand-DEFAULT">
                <i data-lucide="flower-2" class="w-6 h-6"></i>
                <span class="font-bold text-lg text-slate-800">Zully</span>
            </div>
            <button onclick="toggleSidebarMobile()" class="p-2 text-slate-500 hover:bg-slate-100 rounded-lg">
                <i data-lucide="menu" class="w-6 h-6"></i>
            </button>
        </header>

        <!-- Main Scrollable Area -->
        <main class="flex-1 overflow-x-hidden overflow-y-auto p-4 md:p-8 lg:p-10 relative w-full">
            <!-- Background Decoration -->
            <div class="absolute top-0 left-0 w-full h-64 bg-gradient-to-b from-brand-light to-slate-50 -z-10"></div>

<script>
    // --- Logic for Collapsible Sidebar ---
    
    const sidebar = document.getElementById('mainSidebar');
    const texts = document.querySelectorAll('.sidebar-text');
    const toggleIcon = document.getElementById('toggleIcon');
    const tooltips = document.querySelectorAll('.sidebar-tooltip');
    
    // Load saved state
    const isCollapsed = localStorage.getItem('sidebarCollapsed') === 'true';
    if (isCollapsed) {
        applyCollapseState(true);
    }

    function toggleSidebarDesktop() {
        const collapsed = sidebar.classList.contains('w-20');
        applyCollapseState(!collapsed);
    }

    function applyCollapseState(collapsed) {
        if (collapsed) {
            sidebar.classList.remove('w-64');
            sidebar.classList.add('w-20');
            
            // Hide texts
            texts.forEach(t => {
                t.classList.add('opacity-0', 'w-0', 'hidden');
                t.classList.remove('opacity-100', 'ml-2');
            });
            
            // Show tooltips on hover (remove hidden class for md breakpoint)
            tooltips.forEach(t => t.classList.remove('md:hidden'));
            
            // Rotate icon
            if(toggleIcon) toggleIcon.setAttribute('data-lucide', 'chevron-right');
            
            localStorage.setItem('sidebarCollapsed', 'true');
        } else {
            sidebar.classList.remove('w-20');
            sidebar.classList.add('w-64');
            
            // Show texts
            texts.forEach(t => {
                t.classList.remove('opacity-0', 'w-0', 'hidden');
                t.classList.add('opacity-100', 'ml-2');
            });
            
            // Hide tooltips
            tooltips.forEach(t => t.classList.add('md:hidden'));
            
            // Rotate icon
            if(toggleIcon) toggleIcon.setAttribute('data-lucide', 'chevron-left');
            
            localStorage.setItem('sidebarCollapsed', 'false');
        }
        lucide.createIcons();
    }

    // --- Mobile Logic ---
    function toggleSidebarMobile() {
        const overlay = document.getElementById('mobileOverlay');
        const isClosed = sidebar.classList.contains('-translate-x-full');
        
        if (isClosed) {
            sidebar.classList.remove('-translate-x-full');
            overlay.classList.remove('hidden');
        } else {
            sidebar.classList.add('-translate-x-full');
            overlay.classList.add('hidden');
        }
    }
</script>
