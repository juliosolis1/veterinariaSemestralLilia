document.addEventListener('DOMContentLoaded', () => {
    cargarReportes();

    async function cargarReportes() {
        const cont = document.getElementById('reportesContainer');
        cont.innerHTML = '<p>Cargando reportes...</p>';

        const [productos, servicio, estadisticas, citas] = await Promise.all([
            fetch('../../backend/controller/reportesController.php?accion=productosMasVendidos').then(r => r.json()),
            fetch('../../backend/controller/reportesController.php?accion=servicioMasSolicitado').then(r => r.json()),
            fetch('../../backend/controller/reportesController.php?accion=estadisticasServicios').then(r => r.json()),
            fetch('../../backend/controller/reportesController.php?accion=estadisticasCitas').then(r => r.json())
        ]);

        cont.innerHTML = `
            <h4>Top Productos Más Vendidos</h4>
            <ul>${productos.map(p => `<li>${p.NombreProducto}: ${p.TotalVendido}</li>`).join('')}</ul>
            <h4>Servicio Más Solicitado</h4>
            <p>${servicio.NombreServicio} (${servicio.TotalSolicitado} veces)</p>
            <h4>Estadísticas de Servicios</h4>
            <ul>
                <li>Total de servicios: ${estadisticas.TotalServicios}</li>
                <li>Precio promedio: $${Number(estadisticas.PrecioPromedio).toFixed(2)}</li>
                <li>Precio mínimo: $${Number(estadisticas.PrecioMinimo).toFixed(2)}</li>
                <li>Precio máximo: $${Number(estadisticas.PrecioMaximo).toFixed(2)}</li>
            </ul>
            <h4>Estadísticas de Citas (mes actual)</h4>
            <ul>
                <li>Total de citas: ${citas.TotalCitas}</li>
                <li>Citas confirmadas: ${citas.CitasConfirmadas}</li>
                <li>Citas completadas: ${citas.CitasCompletadas}</li>
                <li>Citas canceladas: ${citas.CitasCanceladas}</li>
                <li>No Show: ${citas.NoShow}</li>
                <li>Citas pendientes: ${citas.CitasPendientes}</li>
            </ul>
        `;
    }
});