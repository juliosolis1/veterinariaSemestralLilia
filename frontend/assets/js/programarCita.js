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
            const select = document.getElementById('idMascota');
            select.innerHTML = '';
            if (data.estado === 'ok' && data.mascotas && data.mascotas.length) {
                data.mascotas.forEach(m => {
                    select.innerHTML += `<option value="${m.id}">${m.nombre}</option>`;
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
            const select = document.getElementById('tipoServicio');
            select.innerHTML = '';
            if (data.estado === 'ok' && data.servicios) {
                data.servicios.forEach(s => {
                    select.innerHTML += `<option value="${s.id}">${s.nombre}</option>`;
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
        if (data.estado === 'ok') {
            alert('Cita registrada correctamente');
            form.reset();
        } else {
            alert('Error: ' + (data.mensaje || 'No se pudo registrar la cita'));
        }
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
                cont.innerHTML = `<table class='table'><thead><tr><th>Fecha</th><th>Hora</th><th>Mascota</th><th>Servicio</th><th>Estado</th></tr></thead><tbody>${data.citas.map(c => `<tr><td>${c.fecha}</td><td>${c.hora}</td><td>${c.id_mascota}</td><td>${c.tipo_servicio}</td><td>${c.estado}</td></tr>`).join('')}</tbody></table>`;
            } else {
                cont.innerHTML = '<div class="alert alert-info">No hay citas para este cliente</div>';
            }
        });
}

function mostrarCitasPendientes() {
    fetch(`${API_URL}?accion=listarCitasPendientes`)
        .then(r => r.json())
        .then(data => {
            const cont = document.getElementById('tablaPendientes');
            if (data.estado === 'ok' && data.citas.length) {
                cont.innerHTML = `<table class='table'><thead><tr><th>Fecha</th><th>Hora</th><th>Cliente</th><th>Mascota</th><th>Servicio</th></tr></thead><tbody>${data.citas.map(c => `<tr><td>${c.fecha}</td><td>${c.hora}</td><td>${c.cedula_cliente}</td><td>${c.id_mascota}</td><td>${c.tipo_servicio}</td></tr>`).join('')}</tbody></table>`;
            } else {
                cont.innerHTML = '<div class="alert alert-warning">No hay citas pendientes</div>';
            }
        });
}
