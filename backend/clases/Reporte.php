<?php
require_once __DIR__ . '/../includes/conexion.php';
require_once __DIR__ . '/../includes/sanitizar.php';

class Reporte {
    private $conexion;

    public function __construct() {
        $this->conexion = new Conexion();
    }

    public function productosMasVendidos() {
        $sql = "EXEC ObtenerProductosMasVendidos";
        $stmt = $this->conexion->getPDO()->prepare($sql);
        $stmt->execute();
        return $stmt->fetchAll(PDO::FETCH_ASSOC);
    }

    public function servicioMasSolicitado() {
        $sql = "EXEC ObtenerServicioMasSolicitado";
        $stmt = $this->conexion->getPDO()->prepare($sql);
        $stmt->execute();
        return $stmt->fetch(PDO::FETCH_ASSOC);
    }

    public function estadisticasServicios() {
        $sql = "EXEC ObtenerEstadisticasServicios";
        $stmt = $this->conexion->getPDO()->prepare($sql);
        $stmt->execute();
        return $stmt->fetch(PDO::FETCH_ASSOC);
    }

    public function estadisticasCitas($fechaInicio, $fechaFin) {
        $sql = "EXEC ObtenerEstadisticasCitas ?, ?";
        $stmt = $this->conexion->getPDO()->prepare($sql);
        $stmt->execute([$fechaInicio, $fechaFin]);
        return $stmt->fetch(PDO::FETCH_ASSOC);
    }
}