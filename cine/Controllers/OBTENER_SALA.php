<?php
    require_once "../Models/Modelo.php";
    $cine = new Cine();
    if($_POST){
            $Idp = $_POST["IDP"];
            $cine = $cine->OBTENER_SALA($Idp);
            echo json_encode($cine);
    }
    else{
        echo "No hay";
    }
?>