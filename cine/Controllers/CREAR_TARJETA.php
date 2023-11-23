<?php
    require_once "../Models/Modelo.php";
    $cine = new Cine();
    if($_POST){
            $Ced = $_POST["CED"];
            $cine = $cine->CREAR_TARJETA($Ced);
            echo json_encode($cine);
    }
    else{
        echo "No hay";
    }
?>