<?php
require_once __DIR__ . '/../clases/Reporte.php';

header('Content-Type: application/json; charset=utf-8');

$accion = $_GET['accion'] ?? $_POST['accion'] ?? '';
$reporte = new Reporte();

try {
    switch ($accion) {
        case 'productosMasVendidos':
            echo json_encode($reporte->productosMasVendidos());
            break;
        case 'servicioMasSolicitado':
            echo json_encode($reporte->servicioMasSolicitado());
            break;
        case 'estadisticasServicios':
            echo json_encode($reporte->estadisticasServicios());
            break;
        case 'estadisticasCitas':
            $fechaInicio = $_GET['fechaInicio'] ?? $_POST['fechaInicio'] ?? date('Y-m-01');
            $fechaFin = $_GET['fechaFin'] ?? $_POST['fechaFin'] ?? date('Y-m-d');
            echo json_encode($reporte->estadisticasCitas($fechaInicio, $fechaFin));
            break;
        default:
            echo json_encode(['error' => 'Acción no válida']);
    }
} catch (Exception $e) {
    echo json_encode(['error' => $e->getMessage()]);
}