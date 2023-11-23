<?php
    require_once "../Models/Modelo.php";
    $cine = new Cine();
    if($_POST){
            $Idt = $_POST["IDT"];
            $cine = $cine->RECARGAR_TARJETA($Idt);
            echo json_encode($cine);
    }
    else{
        echo "No hay";
    }
?>