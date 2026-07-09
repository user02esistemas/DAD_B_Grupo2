<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Login | FisioEstética Zully</title>
        <!-- Outfit Font -->
        <link href="https://fonts.googleapis.com/css2?family=Outfit:wght@300;400;500;600;700&display=swap" rel="stylesheet">
        <script src="https://cdn.tailwindcss.com"></script>
        <script src="https://unpkg.com/lucide@latest"></script>

        <script>
            tailwind.config = {
                theme: {
                    extend: {
                        fontFamily: {sans: ['Outfit', 'sans-serif']},
                        colors: {brand: '#db2777'}
                    }
                }
            }
        </script>
    </head>
    <body class="h-screen w-full bg-gradient-to-br from-slate-900 via-slate-800 to-slate-900 flex items-center justify-center p-4 relative overflow-hidden">

        <!-- Background Blobs -->
        <div class="absolute top-0 left-0 w-96 h-96 bg-brand/20 rounded-full blur-3xl -translate-x-1/2 -translate-y-1/2"></div>
        <div class="absolute bottom-0 right-0 w-96 h-96 bg-blue-500/20 rounded-full blur-3xl translate-x-1/2 translate-y-1/2"></div>

        <div class="bg-white/10 backdrop-blur-xl border border-white/20 rounded-3xl shadow-2xl w-full max-w-4xl flex overflow-hidden relative z-10">

            <!-- Left Side: Form -->
            <div class="w-full md:w-1/2 p-8 md:p-12 bg-white relative">
                <div class="mb-10">
                    <div class="flex items-center gap-2 text-brand mb-2">
                        <img src="assets/logo-sidebar.png" alt="Logo" class="w-10 h-auto object-contain">
                        <span class="text-2xl font-bold tracking-tight">FisioEstética Zully</span>
                    </div>
                    <h2 class="text-3xl font-bold text-slate-800">Bienvenido de nuevo</h2>
                    <p class="text-slate-500 mt-2">Ingresa tus credenciales para acceder al panel.</p>
                </div>

                <div class="${empty requestScope.error ? 'hidden' : 'flex'} items-center gap-3 bg-red-50 border-l-4 border-red-500 text-red-700 p-4 rounded-r-lg mb-6 animate-pulse">
                    <i data-lucide="alert-circle" class="w-5 h-5"></i>
                    <p class="text-sm font-medium">${requestScope.error}</p>
                </div>

                <form action="${pageContext.request.contextPath}/AuthServlet" method="post" class="space-y-6">
                    <div>
                        <label class="block text-sm font-medium text-slate-700 mb-2" for="usuario">Usuario</label>
                        <div class="relative group">
                            <span class="absolute inset-y-0 left-0 flex items-center pl-3 text-slate-400 group-focus-within:text-brand transition-colors">
                                <i data-lucide="user" class="w-5 h-5"></i>
                            </span>
                            <input class="w-full pl-10 pr-4 py-3 bg-slate-50 border border-slate-200 rounded-xl focus:outline-none focus:border-brand focus:ring-2 focus:ring-brand/20 transition-all text-slate-700 font-medium placeholder-slate-400" 
                                   id="usuario" name="usuario" type="text" placeholder="ej. admin" required>
                        </div>
                    </div>

                    <div>
                        <label class="block text-sm font-medium text-slate-700 mb-2" for="contrasena">Contraseña</label>
                        <div class="relative group">
                            <span class="absolute inset-y-0 left-0 flex items-center pl-3 text-slate-400 group-focus-within:text-brand transition-colors">
                                <i data-lucide="lock" class="w-5 h-5"></i>
                            </span>
                            <input class="w-full pl-10 pr-4 py-3 bg-slate-50 border border-slate-200 rounded-xl focus:outline-none focus:border-brand focus:ring-2 focus:ring-brand/20 transition-all text-slate-700 font-medium placeholder-slate-400" 
                                   id="contrasena" name="contrasena" type="password" placeholder="••••••••" required>
                        </div>
                    </div>

                    <button class="w-full bg-gradient-to-r from-brand to-pink-600 text-white font-bold py-3.5 rounded-xl shadow-lg shadow-brand/30 hover:shadow-brand/50 hover:-translate-y-0.5 transition-all duration-200 flex items-center justify-center gap-2" type="submit">
                        <span>Ingresar al Sistema</span>
                        <i data-lucide="arrow-right" class="w-5 h-5"></i>
                    </button>
                </form>

                <p class="mt-8 text-center text-sm text-slate-400">
                    &copy; 2025 FisioEstética Zully. Todos los derechos reservados.
                </p>
            </div>

            <!-- Right Side: Image/Decor -->
            <div class="hidden md:flex w-1/2 bg-gradient-to-br from-brand-dark to-purple-900 relative items-center justify-center p-12 text-center text-white">
                <div class="absolute inset-0 bg-[url('https://images.unsplash.com/photo-1576091160399-112ba8d25d1d?ixlib=rb-1.2.1&auto=format&fit=crop&w=1350&q=80')] bg-cover bg-center opacity-20 mix-blend-overlay"></div>
                <div class="relative z-10">
                    <div class="bg-white/10 backdrop-blur-md p-4 rounded-2xl inline-block mb-6 shadow-glow">
                        <i data-lucide="sparkles" class="w-12 h-12 text-pink-300"></i>
                    </div>
                    <h3 class="text-3xl font-bold mb-4">Gestión Integral & Estética</h3>
                    <p class="text-pink-100 leading-relaxed">Administra pacientes, citas y tratamientos con la elegancia que tu clínica merece.</p>
                </div>
            </div>
        </div>

        <script>
            lucide.createIcons();
        </script>
    </body>
</html>
