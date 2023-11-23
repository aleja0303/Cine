<?php
    require_once "../Models/Modelo.php";
    $cine = new Cine();
    if($_POST){
            $Cor = $_POST["COR"];
            $Cont = $_POST["CONT"];
            $cine = $cine->INICIAR_SESION($Cor, $Cont);
            echo json_encode($cine);
    }
    else{
        echo "No hay";
    }
?>