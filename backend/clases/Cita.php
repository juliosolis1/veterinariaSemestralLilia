<?php
// backend/clases/Cita.php
require_once __DIR__ . '/../includes/conexion.php';

class Cita {
    private $conexion;
    public function __construct() {
        $this->conexion = new Conexion();
    }

    // Listar citas de un cliente
    public function listarCitasPorCliente($cedulaCliente) {
        $sql = "SELECT * FROM citas WHERE cedula_cliente = ? ORDER BY fecha DESC, hora DESC";
        $stmt = $this->conexion->getConexion()->prepare($sql);
        $stmt->execute([$cedulaCliente]);
        return $stmt->fetchAll(PDO::FETCH_ASSOC);
    }

    // Listar citas pendientes
    public function listarCitasPendientes() {
        $sql = "SELECT * FROM citas WHERE estado = 'pendiente' ORDER BY fecha, hora";
        $stmt = $this->conexion->getConexion()->prepare($sql);
        $stmt->execute();
        return $stmt->fetchAll(PDO::FETCH_ASSOC);
    }

    // Registrar nueva cita
    public function registrarCita($datos) {
        $sql = "INSERT INTO citas (cedula_cliente, id_mascota, tipo_servicio, fecha, hora, observaciones, estado) VALUES (?, ?, ?, ?, ?, ?, 'pendiente')";
        $stmt = $this->conexion->getConexion()->prepare($sql);
        $stmt->execute([
            $datos['cedulaCliente'],
            $datos['idMascota'],
            $datos['tipoServicio'],
            $datos['fechaCita'],
            $datos['horaCita'],
            $datos['observaciones']
        ]);
        return $this->conexion->getConexion()->lastInsertId();
    }
}
