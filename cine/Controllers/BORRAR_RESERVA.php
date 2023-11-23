<?php
    require_once "../Models/Modelo.php";
    $cine = new Cine();
    if($_POST){
            $Idr = $_POST["IDR"];
            $cine = $cine->BORRAR_RESERVA($Idr);
            echo json_encode($cine);
    }
    else{
        echo "No hay";
    }
?>