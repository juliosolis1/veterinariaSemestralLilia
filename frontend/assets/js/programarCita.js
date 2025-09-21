// programarCita.js - Lógica básica para el módulo de programar cita

const API_URL = '../../backend/controller/controller.php';

document.addEventListener('DOMContentLoaded', () => {
    // Eventos
    document.getElementById('cedulaCliente').addEventListener('change', cargarMascotasCliente);
    document.getElementById('formProgramarCita').addEventListener('submit', registrarCita);
    document.getElementById('btnBuscarCitas').addEventListener('click', mostrarCitasCliente);
    document.getElementById('btnCitasPendientes').addEventListener('click', mostrarCitasPendientes);

    cargarServicios();
    cargarHoras();
});

function cargarMascotasCliente() {
    const cedula = document.getElementById('cedulaCliente').value;
    if (!cedula) return;
    fetch(`${API_URL}?accion=consultarMascota&cedula=${cedula}`)
        .then(r => r.json())
        .then(data => {
            console.log('Respuesta mascotas:', data);
            const select = document.getElementById('idMascota');
            select.innerHTML = '';
            if (data && data.estado === 'ok' && Array.isArray(data.mascotas) && data.mascotas.length) {
                data.mascotas.forEach(m => {
                    const nombre = m.NombreMascota || m.Nombre;
                    select.innerHTML += `<option value="${m.IDMascota}">${nombre}</option>`;
                });
            } else {
                select.innerHTML = '<option value="">No hay mascotas</option>';
            }
        });
}

function cargarServicios() {
    fetch(`${API_URL}?accion=obtenerServicios`)
        .then(r => r.json())
        .then(data => {
            console.log('Respuesta servicios:', data);
            const select = document.getElementById('tipoServicio');
            select.innerHTML = '';
            if (data && data.estado === 'ok' && Array.isArray(data.servicios) && data.servicios.length) {
                data.servicios.forEach(s => {
                    const nombre = s.NombreProducto || s.NombreServicio || s.Nombre;
                    const id = s.IDITEM || s.IDServicio || s.id;
                    select.innerHTML += `<option value="${id}">${nombre}</option>`;
                });
            } else {
                select.innerHTML = '<option value="">No hay servicios</option>';
            }
        });
}

function cargarHoras() {
    const select = document.getElementById('horaCita');
    select.innerHTML = '<option value="09:00">09:00</option><option value="10:00">10:00</option><option value="11:00">11:00</option>';
}

function registrarCita(e) {
    e.preventDefault();
    const form = e.target;
    const datos = new FormData(form);
    datos.append('accion', 'registrarCita');
    fetch(API_URL, {
        method: 'POST',
        body: datos
    })
    .then(r => r.json())
    .then(data => {
        console.log('Respuesta registrar cita:', data);
        if (data && data.estado === 'ok') {
            alert('Cita registrada correctamente');
            form.reset();
        } else {
            alert('Error: ' + (data.mensaje || 'No se pudo registrar la cita'));
        }
    })
    .catch(err => {
        console.error('Error al registrar cita:', err);
        alert('Error de conexión o formato de respuesta');
    });
}

function mostrarCitasCliente() {
    const cedula = document.getElementById('buscarCedula').value;
    if (!cedula) return;
    fetch(`${API_URL}?accion=listarCitasPorCliente&cedulaCliente=${cedula}`)
        .then(r => r.json())
        .then(data => {
            const cont = document.getElementById('tablaCitas');
            if (data.estado === 'ok' && data.citas.length) {
                cont.innerHTML = `<table class='table'><thead><tr><th>Fecha</th><th>Hora</th><th>Mascota</th><th>Servicio</th><th>Estado</th><th>Acciones</th></tr></thead><tbody>${data.citas.map((c, idx) => {
                    return `<tr id='cita-row-${c.IDCita}'><td>${c.Fecha}</td><td>${c.Hora}</td><td>${c.NombreMascota}</td><td>${c.NombreProducto}</td><td>${c.Estado}</td><td><button class='btn btn-sm btn-warning' onclick='desplegarFormularioModificarCita(${JSON.stringify(c)}, ${idx})'>Modificar</button> <button class='btn btn-sm btn-danger' onclick='cancelarCita(${c.IDCita})'>Cancelar</button></td></tr>`;
                }).join('')}</tbody></table>`;
            } else {
                cont.innerHTML = '<div class="alert alert-warning">No hay citas para este cliente</div>';
            }
        });
}

// Eliminar cualquier formulario desplegado antes de mostrar uno nuevo
function limpiarFormulariosDesplegados() {
    document.querySelectorAll('.form-modificar-cita-row').forEach(el => el.remove());
}

// Función para desplegar el formulario de modificación debajo de la fila
window.desplegarFormularioModificarCita = async function(cita, idx) {
    limpiarFormulariosDesplegados();
    // Obtener opciones de mascota y servicio
    let mascotas = [];
    let servicios = [];
    try {
        const resMascotas = await fetch(`${API_URL}?accion=consultarMascota&cedula=${cita.CedulaCliente}`);
        const dataMascotas = await resMascotas.json();
        mascotas = (dataMascotas && dataMascotas.estado === 'ok') ? dataMascotas.mascotas : [];
    } catch {}
    try {
        const resServicios = await fetch(`${API_URL}?accion=obtenerServicios`);
        const dataServicios = await resServicios.json();
        servicios = (dataServicios && dataServicios.estado === 'ok') ? dataServicios.servicios : [];
    } catch {}

    // Crear el formulario
    const tr = document.getElementById(`cita-row-${cita.IDCita}`);
    const formRow = document.createElement('tr');
    formRow.className = 'form-modificar-cita-row';
    // Formatear fecha y hora para los inputs
    function formatDate(fecha) {
        if (!fecha) return '';
        // Si ya está en formato yyyy-mm-dd, regresa igual
        if (/^\d{4}-\d{2}-\d{2}$/.test(fecha)) return fecha;
        // Si está en formato dd/mm/yyyy, conviértelo
        const parts = fecha.split('/');
        if (parts.length === 3) return `${parts[2]}-${parts[1].padStart(2,'0')}-${parts[0].padStart(2,'0')}`;
        return fecha;
    }
    function formatTime(hora) {
        if (!hora) return '';
        // Si ya está en formato hh:mm, regresa igual
        if (/^\d{2}:\d{2}$/.test(hora)) return hora;
        // Si está en formato hh:mm:ss, toma solo hh:mm
        if (/^\d{2}:\d{2}:\d{2}$/.test(hora)) return hora.slice(0,5);
        return hora;
    }
    formRow.innerHTML = `<td colspan='6'>
        <form id='formModificarCita${cita.IDCita}' style='background:#f8f9fa;padding:1em;border-radius:8px;'>
            <div style='display:flex;gap:1em;flex-wrap:wrap;'>
                <label>Mascota:<br>
                    <select name='idMascota'>
                        ${mascotas.map(m => `<option value='${m.IDMascota}'${m.IDMascota==cita.IDMascota?' selected':''}>${m.NombreMascota||m.Nombre}</option>`).join('')}
                    </select>
                </label>
                <label>Servicio:<br>
                    <select name='idServicio'>
                        ${servicios.map(s => {
                            const nombre = s.NombreProducto || s.NombreServicio || s.Nombre;
                            const id = s.IDITEM || s.IDServicio || s.id;
                            return `<option value='${id}'${id==cita.IDITEM?' selected':''}>${nombre}</option>`;
                        }).join('')}
                    </select>
                </label>
                <label>Fecha:<br>
                    <input type='date' name='fecha' value='${formatDate(cita.Fecha)}' >
                </label>
                <label>Hora:<br>
                    <input type='time' name='hora' value='${formatTime(cita.Hora)}' >
                </label>
                <label>Observaciones:<br>
                    <input type='text' name='observaciones' value='${cita.Observaciones||''}' >
                </label>
            </div>
            <input type='hidden' name='idCita' value='${cita.IDCita}'>
            <div style='margin-top:1em;'>
                <button type='submit' class='btn btn-success btn-sm'>Guardar Cambios</button>
                <button type='button' class='btn btn-secondary btn-sm' onclick='limpiarFormulariosDesplegados()'>Cancelar</button>
            </div>
        </form>
    </td>`;
    tr.parentNode.insertBefore(formRow, tr.nextSibling);

    // Evento submit para guardar cambios
    document.getElementById(`formModificarCita${cita.IDCita}`).onsubmit = function(e) {
        e.preventDefault();
        const form = this;
        // Solo validar que los campos tengan algún valor (ya sea el actual o modificado)
        const idMascota = form.idMascota.value || cita.IDMascota;
        const idServicio = form.idServicio.value || cita.IDITEM;
        const fecha = form.fecha.value || formatDate(cita.Fecha);
        const hora = form.hora.value || formatTime(cita.Hora);
        // Validar solo si los campos están realmente vacíos
        if (!idMascota || !idServicio || !fecha || !hora) {
            alert('Faltan datos para modificar la cita');
            return;
        }
        const datos = new FormData(form);
        datos.append('accion', 'modificarCita');
        fetch(`${API_URL}`, {
            method: 'POST',
            body: datos
        })
        .then(r => r.json())
        .then(data => {
            alert(data.mensaje || 'Cita actualizada');
            limpiarFormulariosDesplegados();
            mostrarCitasCliente();
        })
        .catch(() => {
            alert('Error al actualizar cita');
        });
    };
}

    // Nueva función global para editar cita usando <dialog>

    window.editarCita = async function(cita) {
        await mostrarDialogoModificarCita({
            id: cita.IDCita,
            fecha: cita.Fecha || '',
            hora: cita.Hora || '',
            motivo: cita.Observaciones || '',
            cedulaCliente: cita.CedulaCliente || '',
            idMascota: cita.IDMascota || '',
            idServicio: cita.IDITEM || ''
        });
    };


    async function mostrarDialogoModificarCita(cita) {
        // Elimina cualquier dialogo existente
        const dialogExistente = document.getElementById('dialogo-modificar-cita');
        if (dialogExistente) {
            dialogExistente.remove();
        }

        // Obtener opciones de mascota y servicio
        let mascotas = [];
        let servicios = [];
        try {
            const resMascotas = await fetch(`${API_URL}?accion=consultarMascota&cedula=${cita.cedulaCliente}`);
            const dataMascotas = await resMascotas.json();
            mascotas = (dataMascotas && dataMascotas.estado === 'ok') ? dataMascotas.mascotas : [];
        } catch {}
        try {
            const resServicios = await fetch(`${API_URL}?accion=obtenerServicios`);
            const dataServicios = await resServicios.json();
            servicios = (dataServicios && dataServicios.estado === 'ok') ? dataServicios.servicios : [];
        } catch {}

        // Crear el elemento dialog
        const dialog = document.createElement('dialog');
        dialog.id = 'dialogo-modificar-cita';
        dialog.style.padding = '2em';
        dialog.innerHTML = `
            <h2>Modificar Cita</h2>
            <form id="formModificarCita">
                <input type="hidden" name="idCita" value="${cita.id}">
                <label>Mascota:<br>
                    <select name="idMascota" required>
                        ${mascotas.map(m => `<option value="${m.IDMascota}"${m.IDMascota==cita.idMascota?' selected':''}>${m.NombreMascota||m.Nombre}</option>`).join('')}
                    </select>
                </label><br><br>
                <label>Servicio:<br>
                    <select name="idServicio" required>
                        ${servicios.map(s => {
                            const nombre = s.NombreProducto || s.NombreServicio || s.Nombre;
                            const id = s.IDITEM || s.IDServicio || s.id;
                            return `<option value="${id}"${id==cita.idServicio?' selected':''}>${nombre}</option>`;
                        }).join('')}
                    </select>
                </label><br><br>
                <label>Fecha:<br>
                    <input type="date" name="fecha" value="${cita.fecha}" required>
                </label><br><br>
                <label>Hora:<br>
                    <input type="time" name="hora" value="${cita.hora}" required>
                </label><br><br>
                <label>Observaciones:<br>
                    <input type="text" name="observaciones" value="${cita.motivo}">
                </label><br><br>
                <button type="submit">Guardar Cambios</button>
                <button type="button" id="cerrarDialogoModificar">Cancelar</button>
            </form>
        `;
        document.body.appendChild(dialog);
        dialog.showModal();

        // Cerrar el dialogo
        document.getElementById('cerrarDialogoModificar').onclick = () => {
            dialog.close();
            dialog.remove();
        };

        // Manejar el submit
        document.getElementById('formModificarCita').onsubmit = function(e) {
            e.preventDefault();
            const datos = new FormData(this);
            datos.append('accion', 'modificarCita');
            fetch(`${API_URL}`, {
                method: 'POST',
                body: datos
            })
            .then(r => r.json())
            .then(data => {
                alert(data.mensaje || 'Cita actualizada');
                dialog.close();
                dialog.remove();
                mostrarCitasCliente();
            })
            .catch(() => {
                alert('Error al actualizar cita');
            });
        };
    }

// Función para abrir el modal y cargar datos de la cita a editar
window.editarCita = function(cita) {
    document.getElementById('editIdCita').value = cita.IDCita;
    // Mascotas
    fetch(`${API_URL}?accion=consultarMascota&cedula=${cita.CedulaCliente}`)
        .then(r => r.json())
        .then(data => {
            const selectMascota = document.getElementById('editIdMascota');
            selectMascota.innerHTML = '';
            if (data && data.estado === 'ok' && Array.isArray(data.mascotas)) {
                data.mascotas.forEach(m => {
                    selectMascota.innerHTML += `<option value="${m.IDMascota}"${m.IDMascota==cita.IDMascota?' selected':''}>${m.NombreMascota||m.Nombre}</option>`;
                });
            } else {
                selectMascota.innerHTML = '<option value="">No hay mascotas</option>';
            }
        })
        .catch(err => {
            document.getElementById('editIdMascota').innerHTML = '<option value="">Error cargando mascotas</option>';
            console.error('Error cargando mascotas:', err);
        });
    // Servicios
    fetch(`${API_URL}?accion=obtenerServicios`)
        .then(r => r.json())
        .then(data => {
            const selectServicio = document.getElementById('editIdItem');
            selectServicio.innerHTML = '';
            if (data && data.estado === 'ok' && Array.isArray(data.servicios)) {
                data.servicios.forEach(s => {
                    const nombre = s.NombreProducto || s.NombreServicio || s.Nombre;
                    const id = s.IDITEM || s.IDServicio || s.id;
                    selectServicio.innerHTML += `<option value="${id}"${id==cita.IDITEM?' selected':''}>${nombre}</option>`;
                });
            } else {
                selectServicio.innerHTML = '<option value="">No hay servicios</option>';
            }
        })
        .catch(err => {
            document.getElementById('editIdItem').innerHTML = '<option value="">Error cargando servicios</option>';
            console.error('Error cargando servicios:', err);
        });
    // Fecha
    document.getElementById('editFecha').value = cita.Fecha;
    // Horas
    const selectHora = document.getElementById('editHora');
    selectHora.innerHTML = '<option value="09:00">09:00</option><option value="10:00">10:00</option><option value="11:00">11:00</option>';
    selectHora.value = cita.Hora;
    // Observaciones
    document.getElementById('editObservaciones').value = cita.Observaciones || '';
    var modal = new bootstrap.Modal(document.getElementById('modalEditarCita'));
    modal.show();
}

// Función para cancelar cita
window.cancelarCita = function(idCita) {
    if (!confirm('¿Seguro que deseas cancelar esta cita?')) return;
    fetch(`${API_URL}`, {
        method: 'POST',
        body: new URLSearchParams({accion: 'cancelarCita', idCita})
    })
    .then(r => r.json())
    .then(data => {
        alert(data.mensaje);
        mostrarCitasCliente();
    });
}

// Evento para guardar cambios de cita
document.addEventListener('DOMContentLoaded', function() {
    const formEditar = document.getElementById('formEditarCita');
    if (formEditar) {
        formEditar.addEventListener('submit', function(e) {
            e.preventDefault();
            const datos = new FormData(e.target);
            datos.append('accion', 'modificarCita');
            fetch(`${API_URL}`, {
                method: 'POST',
                body: datos
            })
            .then(r => r.json())
            .then(data => {
                alert(data.mensaje);
                var modal = bootstrap.Modal.getInstance(document.getElementById('modalEditarCita'));
                modal.hide();
                mostrarCitasCliente();
            });
        });
    }
});

function mostrarCitasPendientes() {
    fetch(`${API_URL}?accion=listarCitasPendientes`)
        .then(r => r.json())
        .then(data => {
            const cont = document.getElementById('tablaPendientes');
            if (data.estado === 'ok' && data.citas.length) {
                cont.innerHTML = `<table class='table'><thead><tr><th>Fecha</th><th>Hora</th><th>Cliente</th><th>Mascota</th><th>Servicio</th></tr></thead><tbody>${data.citas.map(c => `<tr><td>${c.Fecha}</td><td>${c.Hora}</td><td>${c.CedulaCliente}</td><td>${c.NombreMascota}</td><td>${c.NombreProducto}</td></tr>`).join('')}</tbody></table>`;
            } else {
                cont.innerHTML = '<div class="alert alert-warning">No hay citas pendientes</div>';
            }
        });
}
