# Activar la sincronización de Kangaroo con Supabase

Esta carpeta deja la integración preparada. Supabase debe crearse desde tu propia cuenta: no es posible crear un proyecto remoto sin acceso a esa cuenta.

## 1. Crear el proyecto

1. Crea una cuenta y un proyecto gratuito en [Supabase](https://supabase.com/dashboard).
2. Abre **SQL Editor** y ejecuta completo el archivo `supabase/migrations/20260824_create_kangaroo_sync.sql`.
3. En **Authentication > URL Configuration**, agrega las direcciones desde las que abrirás Kangaroo:
   - Desarrollo local: `http://localhost:5500/kangaroo_v6.1.html` (ajústala al puerto que uses).
   - GitHub Pages: `https://TU_USUARIO.github.io/TU_REPOSITORIO/kangaroo_v6.1.html`.
4. En **Project Settings > API**, copia **Project URL** y la clave **anon public**. No uses `service_role`.

## 2. Configurar el proyecto para GitHub

Edita `supabase-config.js` y reemplaza sus dos marcadores por los valores públicos copiados. La `anon key` puede estar publicada: las reglas RLS del SQL evitan que una persona autenticada lea datos de otra.

Después sube la carpeta completa a GitHub. Si prefieres no guardar la URL y la anon key en el repositorio, conserva el archivo local; entonces debes subirlo manualmente también al hosting. Nunca publiques una `service_role key`.

## 3. Conectar los dispositivos

1. Abre Kangaroo desde un servidor web o GitHub Pages; no uses doble clic al HTML (`file://`).
2. Ve a **Configuración > Sincronización en la nube > Conectar**.
3. Introduce tu correo y abre el enlace que llegará a ese correo.
4. En cada equipo usa el mismo correo. Los cambios futuros en productos, proveedores, movimientos, despachos y ajustes se sincronizan automáticamente.

La primera conexión crea una copia de los datos que ya tienes. Si otro equipo tiene datos propios y la nube ya contiene otros, Kangaroo preguntará cuál de las dos copias usar; esto evita sobrescribir información sin tu decisión.

## Notas importantes

- `localStorage` sigue siendo la caché local y permite trabajar temporalmente sin internet. La sincronización se reanuda en el siguiente cambio conectado.
- La contraseña local y las preguntas de recuperación no se suben deliberadamente. El acceso a la información en la nube queda protegido por el correo de Supabase.
- Esta primera integración guarda cada colección completa como JSON para conservar compatibilidad con la estructura existente de Kangaroo. Dos personas editando la misma colección a la vez pueden hacer que el último guardado prevalezca. Conserva los backups periódicos de Kangaroo.
