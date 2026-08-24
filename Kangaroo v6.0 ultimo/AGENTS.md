# KANGAROO — CONTEXTO MAESTRO DEL PROYECTO

## 1. IDENTIDAD DEL PROYECTO

Kangaroo es una aplicación web de gestión de inventario y control de operaciones.

El proyecto actualmente está construido principalmente como una aplicación monolítica en HTML, con CSS y JavaScript integrados dentro del mismo archivo.

Archivo principal actual:

`kangaroo_v6.1.html`

El ZIP recibido se identifica como:

`Kangaroo v6.0 ultimo`

IMPORTANTE:

El nombre del archivo, el nombre de la aplicación y las versiones internas no siempre coinciden. NO asumir que el número de versión del archivo representa la versión real del sistema.

Dentro del HTML existen referencias antiguas a versiones anteriores. No cambiar esas referencias simplemente para "hacerlas coincidir" sin que el usuario lo solicite.

---

# 2. REGLA PRINCIPAL

Kangaroo YA ES UNA APLICACIÓN FUNCIONAL.

No tratar el proyecto como si fuera un proyecto nuevo.

Antes de modificar cualquier cosa:

1. Inspeccionar el código existente.
2. Entender cómo funciona actualmente.
3. Identificar qué funciones dependen del código que se quiere modificar.
4. Identificar qué datos utiliza.
5. Identificar si la modificación puede afectar otras secciones.
6. Realizar el cambio mínimo necesario.
7. Verificar que las funcionalidades existentes continúan funcionando.

NO reescribir Kangaroo desde cero para implementar una característica pequeña.

NO reemplazar grandes bloques de código sin necesidad.

NO eliminar funciones existentes porque parezcan innecesarias.

NO cambiar la arquitectura sin autorización explícita del usuario.

---

# 3. OBJETIVO DE CODEX

Codex debe comportarse como un desarrollador que está manteniendo una aplicación existente.

Su prioridad debe ser:

1. Mantener la funcionalidad existente.
2. Evitar pérdida de datos.
3. Evitar regresiones.
4. Mantener la interfaz visual.
5. Mantener compatibilidad con los datos existentes.
6. Hacer cambios pequeños, claros y controlados.
7. Mejorar la aplicación solamente cuando el usuario lo solicite.

Cuando exista una duda sobre cómo funciona una parte del sistema, investigar primero el código relacionado antes de modificarlo.

---

# 4. ARQUITECTURA ACTUAL

La aplicación utiliza principalmente:

* HTML
* CSS
* JavaScript
* localStorage
* sessionStorage
* Chart.js
* SheetJS / XLSX
* jsPDF
* jsPDF AutoTable
* Google Fonts

Dependencias externas actualmente utilizadas:

* XLSX 0.18.5
* jsPDF 2.5.1
* jsPDF AutoTable 3.5.31
* Chart.js 4.4.1
* Google Fonts

NO eliminar estas dependencias si alguna funcionalidad existente depende de ellas.

---

# 5. ESTRUCTURA ACTUAL

Actualmente el proyecto contiene:

* `kangaroo_v6.1.html`
* `kangaroo_backup_2026-06-05.json`
* `logo.png`
* `logologin.png`

El HTML contiene tanto la interfaz como gran parte de la lógica de la aplicación.

Por lo tanto, cualquier modificación al HTML puede afectar simultáneamente:

* estructura
* estilos
* JavaScript
* navegación
* modales
* almacenamiento
* formularios
* generación de documentos

Tratar el archivo principal como un sistema interdependiente.

---

# 6. MÓDULOS PRINCIPALES

Kangaroo actualmente tiene las siguientes páginas/secciones:

## Dashboard

Página principal con información resumida de la actividad del sistema.

## Inventario

Gestiona productos y existencias.

Permite trabajar con información como:

* nombre
* cantidad
* unidad
* precio de adquisición
* precio de venta
* ubicación
* imagen
* deuda
* fecha de deuda
* proveedores asociados
* precios por proveedor
* código del producto

También permite:

* crear productos
* editar productos
* eliminar productos
* visualizar imágenes
* modificar cantidades
* registrar movimientos de inventario

---

## Proveedores

Gestiona proveedores.

Actualmente cada proveedor puede tener:

* nombre
* contacto
* teléfono
* correo electrónico

También existe relación entre proveedores y productos.

Un producto puede tener varios proveedores y diferentes precios de adquisición según el proveedor.

NO romper esta relación al modificar inventario o proveedores.

---

## Despacho

Es el módulo encargado de las salidas de inventario.

Utiliza un carrito temporal:

`dispatchCart`

Permite:

* seleccionar productos
* agregar productos al carrito
* modificar cantidades
* modificar precios
* eliminar productos del carrito
* registrar responsable
* registrar observaciones
* generar una factura
* guardar el despacho
* actualizar el inventario
* registrar movimientos
* generar PDF

Los despachos se almacenan permanentemente.

---

## Devoluciones

El sistema también permite devolver productos al inventario.

Una devolución:

1. Busca el producto.
2. Aumenta su cantidad.
3. Registra el evento.
4. Guarda un despacho de tipo `devolucion`.
5. Registra un movimiento de entrada.

NO cambiar esta lógica sin verificar primero todas las relaciones.

---

## Movimientos

Registra la trazabilidad de las operaciones del inventario.

Los movimientos pueden representar entradas y salidas.

La función principal para crear movimientos es:

`addMov(data)`

Actualmente los movimientos se almacenan en la colección:

`movements`

---

## Calendario

Muestra actividad relacionada con los movimientos y ventas.

Tiene navegación por:

* mes anterior
* mes siguiente
* mes actual

También genera información gráfica de actividad.

Funciones importantes:

* `renderCalendario`
* `calNav`
* `buildCalGrid`
* `showDayStats`
* `buildBarChart`
* `filterCalChart`

---

## Exportación

El sistema tiene funciones para exportar información.

Actualmente existen funciones relacionadas con:

* backup
* restauración
* Excel
* movimientos a Excel
* PDF

Funciones importantes:

* `exportBackup`
* `importBackup`
* `executeRestore`
* `expExcel`
* `expMovExcel`
* `expPDF`

NO modificar los formatos de backup sin considerar compatibilidad con backups anteriores.

---

## Configuración

Permite modificar aspectos de la aplicación.

Actualmente incluye:

* tema
* contraseña
* usuario
* nombre de empresa
* eslogan
* color de PDF
* logo
* preguntas de seguridad
* limpieza de datos

Funciones importantes:

* `renderConfiguracion`
* `toggleTheme`
* `changePassword`
* `saveUsername`
* `saveBranding`
* `savePdfColor`
* `handleLogoUpload`
* `removeLogo`
* `openSecurityQuestionsModal`
* `saveSecurityQuestions`
* `confirmClearData`
* `executeClearData`

---

# 7. SISTEMA DE DATOS

Kangaroo utiliza `localStorage`.

El sistema central de almacenamiento es:

`DB`

Actualmente utiliza el prefijo:

`kng3_`

Las principales colecciones son:

* `products`
* `providers`
* `movements`
* `dispatches`
* `settings`

El sistema utiliza funciones como:

* `DB.get()`
* `DB.set()`
* `DB.products()`
* `DB.providers()`
* `DB.movements()`
* `DB.dispatches()`
* `DB.settings()`
* `DB.sp()`
* `DB.sv()`
* `DB.sm()`
* `DB.sd()`
* `DB.ss()`

NO cambiar el prefijo `kng3_` sin autorización explícita.

NO cambiar los nombres de las colecciones sin implementar primero una estrategia de migración.

NO borrar datos existentes.

---

# 8. ESTRUCTURA DE PRODUCTOS

Los productos actualmente utilizan información similar a:

```javascript
{
  id,
  name,
  qty,
  unit,
  price,
  sellPrice,
  location,
  image,
  debtAmount,
  debtDate,
  providerIds,
  providerPrices,
  date
}
```

Al modificar productos, mantener compatibilidad con propiedades existentes.

No asumir que todos los registros antiguos contienen todas las propiedades.

Utilizar valores predeterminados cuando sea necesario.

---

# 9. ESTRUCTURA DE PROVEEDORES

Los proveedores utilizan información similar a:

```javascript
{
  id,
  name,
  contact,
  phone,
  email
}
```

Los productos pueden almacenar:

`providerIds`

y:

`providerPrices`

`providerPrices` relaciona el proveedor con su precio de adquisición.

No romper esta relación.

---

# 10. ESTRUCTURA DE MOVIMIENTOS

Los movimientos utilizan información como:

```javascript
{
  id,
  type,
  product,
  qty,
  unit,
  responsible,
  date,
  time,
  amount,
  desc
}
```

Los tipos principales incluyen:

* `entrada`
* `salida`

Las devoluciones generan movimientos de entrada.

No modificar los nombres de estos tipos sin actualizar todas las funciones que dependen de ellos.

---

# 11. ESTRUCTURA DE DESPACHOS

Los despachos utilizan información como:

```javascript
{
  id,
  invoiceId,
  product,
  code,
  qty,
  responsible,
  date,
  time,
  amount,
  obs,
  type
}
```

Los tipos pueden incluir:

* `salida`
* `devolucion`

Varios productos pueden compartir un mismo:

`invoiceId`

Esto permite agrupar productos pertenecientes a una misma factura.

NO eliminar `invoiceId`.

---

# 12. IDENTIFICADORES

La aplicación utiliza actualmente una función:

`uid()`

para generar identificadores.

NO reemplazarla innecesariamente.

Los IDs son importantes para las relaciones entre:

* productos
* proveedores
* despachos
* movimientos

---

# 13. AUTENTICACIÓN

La aplicación utiliza:

`sessionStorage`

para el estado de autenticación.

La clave actual es:

`kng_auth`

El sistema incluye:

* login
* logout
* cambio de contraseña
* recuperación de contraseña
* preguntas de seguridad

Funciones importantes:

* `isLoggedIn`
* `doLogin`
* `doLogout`
* `openForgotPassword`
* `renderForgotQuestionStep`
* `checkForgotAnswer`
* `executeForgotReset`

NO eliminar el sistema de autenticación.

---

# 14. CONFIGURACIÓN POR DEFECTO

La configuración utiliza valores similares a:

```javascript
{
  lang: "es",
  theme: "dark",
  password: "",
  username: "Admin",
  companyName: "",
  companySlogan: "",
  pdfColor: "#e18025",
  companyLogo: "",
  securityQuestions: []
}
```

Mantener compatibilidad con configuraciones existentes.

Si se agregan nuevas propiedades, proporcionar valores predeterminados para instalaciones antiguas.

---

# 15. DISEÑO VISUAL

El diseño visual actual es parte importante del proyecto.

NO cambiar:

* colores
* tipografías
* distribución
* tamaños
* estilo de botones
* sidebar
* tarjetas
* modales
* tablas
* iconografía
* animaciones

salvo que el usuario lo solicite explícitamente.

La aplicación utiliza una estética oscura y tecnológica.

El diseño debe considerarse una funcionalidad existente.

---

# 16. REGLA DE NO REGRESIÓN

Antes de modificar una función, buscar dónde se utiliza.

Por ejemplo:

Si se modifica:

`saveProduct`

revisar primero:

* `renderInvTable`
* movimientos
* proveedores
* deudas
* dashboard
* calendario
* exportaciones

Si se modifica:

`saveProv`

revisar:

* productos
* precios por proveedor
* formularios
* tablas

Si se modifica:

`confirmDispatchFromPreview`

revisar:

* inventario
* movimientos
* facturas
* PDF
* historial de despachos

Si se modifica el almacenamiento:

revisar TODAS las funciones que lean o escriban esos datos.

---

# 17. REGLA PARA NUEVAS FUNCIONES

Cuando el usuario solicite una nueva función:

1. Buscar primero si existe algo parecido.
2. Reutilizar funciones existentes cuando sea posible.
3. No crear una segunda implementación de una función que ya existe.
4. Mantener el mismo sistema de datos.
5. Mantener el mismo diseño.
6. Mantener compatibilidad con datos anteriores.
7. Evitar duplicar lógica.

---

# 18. REGLA PARA MODIFICAR DATOS

Nunca ejecutar una migración destructiva automáticamente.

Si una nueva versión necesita modificar la estructura de los datos:

1. Detectar la versión/estructura anterior.
2. Convertir los datos de forma segura.
3. Conservar los campos anteriores cuando sea posible.
4. Crear backup antes de cambios potencialmente destructivos.
5. No eliminar información del usuario.

---

# 19. REGLA PARA ERRORES

Cuando el usuario reporte un bug:

NO asumir inmediatamente cuál es el problema.

Primero:

1. Localizar la función relacionada.
2. Seguir el flujo de datos.
3. Identificar la causa.
4. Determinar si el error viene del frontend, almacenamiento o lógica.
5. Aplicar el cambio mínimo.
6. Revisar efectos secundarios.

No solucionar un bug introduciendo otro.

---

# 20. DEBUGGING

Cuando exista un error:

Buscar primero:

* consola JavaScript
* errores de referencias
* IDs inexistentes
* funciones inexistentes
* variables no definidas
* errores de JSON
* datos faltantes
* inconsistencias entre registros
* errores de localStorage
* problemas con dependencias externas

Si el problema está relacionado con datos, inspeccionar también la estructura almacenada.

---

# 21. ARCHIVO DE BACKUP

Existe:

`kangaroo_backup_2026-06-05.json`

Este archivo representa datos reales de una versión anterior de Kangaroo.

El backup contiene:

* `_meta`
* `products`
* `providers`
* `movements`
* `dispatches`
* `settings`

El backup actual tiene metadata de versión:

`5.2.1`

NO asumir que la aplicación actual y el backup utilizan exactamente la misma estructura.

Si se modifica el sistema de datos, comprobar compatibilidad con backups anteriores.

---

# 22. EXPORTACIÓN Y RESTAURACIÓN

La aplicación tiene un sistema de backup/restauración.

Una modificación al esquema de datos debe considerar:

* exportación
* importación
* restauración
* datos existentes
* nuevas propiedades

Nunca eliminar la posibilidad de recuperar información existente.

---

# 23. FACTURACIÓN PDF

Kangaroo genera documentos PDF utilizando:

* jsPDF
* AutoTable

El PDF utiliza información de configuración como:

* nombre de empresa
* eslogan
* logo
* color personalizado

Funciones relacionadas incluyen:

* `previewDispatchInvoice`
* `downloadInvoicePDFFromPreview`
* `viewSavedInvoice`

Si se modifica la estructura de los despachos, comprobar que la generación de PDF continúe funcionando.

---

# 24. EXCEL

La aplicación utiliza SheetJS/XLSX para exportación.

No eliminar la dependencia:

`xlsx.full.min.js`

si alguna función de exportación continúa utilizándola.

---

# 25. GRÁFICOS

La aplicación utiliza Chart.js.

No reemplazar Chart.js ni modificar innecesariamente su inicialización.

Funciones relacionadas incluyen:

* `buildBarChart`
* `filterCalChart`

---

# 26. IMÁGENES

El proyecto contiene:

* `logo.png`
* `logologin.png`

La aplicación también permite subir un logo desde configuración.

El logo puede almacenarse como datos dentro de la configuración.

No eliminar soporte para logos existentes.

---

# 27. CÓMO DEBE TRABAJAR CODEX

Antes de implementar una tarea compleja, hacer internamente este análisis:

### PASO 1 — ENTENDER

¿Qué quiere conseguir el usuario?

### PASO 2 — LOCALIZAR

¿Qué archivos y funciones están involucrados?

### PASO 3 — DEPENDENCIAS

¿Qué otras funciones dependen de ellos?

### PASO 4 — DATOS

¿Qué información se lee o modifica?

### PASO 5 — RIESGO

¿Puede afectar datos existentes?

¿Puede afectar otra sección?

¿Puede afectar el diseño?

### PASO 6 — IMPLEMENTAR

Realizar el cambio mínimo necesario.

### PASO 7 — VERIFICAR

Comprobar:

* sintaxis
* referencias
* flujo lógico
* almacenamiento
* UI
* funcionalidades relacionadas

### PASO 8 — EXPLICAR

Informar brevemente:

* qué se cambió
* qué archivos fueron modificados
* qué se verificó
* si existe alguna consideración pendiente

---

# 28. NO HACER

NO:

* reescribir toda la aplicación sin autorización
* cambiar el diseño por iniciativa propia
* eliminar funciones antiguas
* cambiar claves de localStorage arbitrariamente
* cambiar estructuras de datos sin migración
* eliminar datos
* reemplazar dependencias sin necesidad
* crear funciones duplicadas
* modificar archivos no relacionados
* "mejorar" partes que el usuario no pidió
* asumir que un archivo antiguo está obsoleto sin comprobarlo
* cambiar nombres de campos usados por otras funciones
* cambiar IDs HTML sin revisar JavaScript
* cambiar clases CSS utilizadas por JavaScript sin revisar dependencias

---

# 29. SI EL USUARIO PIDE UNA REESTRUCTURACIÓN

Si el usuario explícitamente solicita separar el proyecto en múltiples archivos:

Primero analizar todas las dependencias.

Una posible estructura futura podría ser:

```text
kangaroo/
├── index.html
├── css/
├── js/
├── assets/
├── data/
└── AGENTS.md
```

Pero NO realizar esta migración automáticamente.

Una reestructuración debe hacerse de forma controlada y progresiva.

---

# 30. FILOSOFÍA DE DESARROLLO

Kangaroo debe evolucionar, no ser destruido y reconstruido cada vez.

Cada nueva característica debe integrarse con:

* inventario
* proveedores
* movimientos
* despachos
* calendario
* dashboard
* configuración
* exportaciones

cuando corresponda.

Pensar siempre en el sistema completo y no únicamente en el archivo o función que se está editando.

---

# 31. PRIORIDADES

Cuando existan conflictos entre objetivos, utilizar este orden:

1. Integridad de datos
2. Funcionamiento existente
3. Seguridad
4. Compatibilidad
5. Corrección del nuevo requerimiento
6. Diseño existente
7. Optimización
8. Refactorización

No sacrificar datos o funcionalidades existentes por una mejora estética o una optimización.

---

# 32. CONTEXTO PARA FUTURAS CONVERSACIONES

Cuando el usuario diga cosas como:

* "arregla Kangaroo"
* "añade esto a Kangaroo"
* "modifica el inventario"
* "cambia el despacho"
* "arregla la factura"
* "mejorar el dashboard"
* "agrega una función"

interpretar la solicitud dentro de la arquitectura descrita en este documento.

No comenzar desde cero.

Primero inspeccionar el estado actual de los archivos.

---

# 33. REGLA FINAL

Antes de modificar Kangaroo, piensa:

"¿Qué podría romper este cambio?"

Después piensa:

"¿Cuál es el cambio más pequeño que resuelve correctamente el problema?"

La estabilidad de Kangaroo es más importante que hacer cambios grandes rápidamente.

Kangaroo debe evolucionar de forma segura, incremental y mantenible.
