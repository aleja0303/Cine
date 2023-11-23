<?php
    require_once "../Libraries/Conexion.php";
    class Cine{
        private $conexion;
        public function __construct()
        {
            $this->conexion = new Conexion();
            $this->conexion = $this->conexion->connect();
        }
        public function NUEVO_USUARIO(string $nom, string $cor, int $ced, string $cont){
            $rs = $this->conexion->query("CALL NUEVO_USUARIO('{$nom}', '{$cor}', '{$ced}', '{$cont}')");
            $rs = $rs->fetch_object();
            return $rs;
        }
        public function INICIAR_SESION(string $cor, string $cont){
            $rs = $this->conexion->query("CALL INICIAR_SESION('{$cor}','{$cont}')");
            $rs = $rs->fetch_object();
            return $rs;
        }
        public function CREAR_TARJETA(int $ced){
            $rs = $this->conexion->query("CALL CREAR_TARJETA('{$ced}')");
            $rs = $rs->fetch_object();
            return $rs;
        }
        public function RECARGAR_TARJETA(int $idt){
            $rs = $this->conexion->query("CALL RECARGAR_TARJETA('{$idt}')");
            $rs = $rs->fetch_object();
            return $rs;
        }
        public function CREAR_RESERVA(int $ced, int $i1, int $i2, int $i3, int $i4, int $i5, int $i6, int $i7, int $i8,){
            $rs = $this->conexion->query("CALL CREAR_RESERVA('{$ced}', '{$i1}', '{$i2}', '{$i3}', '{$i4}', '{$i5}', '{$i6}','{$i7}','{$i8}')");
            $rs = $rs->fetch_object();
            return $rs;
        }
        public function BORRAR_RESERVA(int $idr){
            $rs = $this->conexion->query("CALL BORRAR_RESERVA('{$idr}')");
            $rs = $rs->fetch_object();
            return $rs;
        }
        public function OBTENER_SALA(int $idp){
            $rs = $this->conexion->query("CALL OBTENER_SALA('{$idp}')");
            $arr = null;
            while($obj = $rs->fetch_object()){
                $arr[] = $obj;
            }
            if($arr == null){
                return null;
            }
            else{
                return $arr;
            }
            return $rs;
        }
    }
?>