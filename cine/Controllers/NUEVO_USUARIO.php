<?php
    require_once "../Models/Modelo.php";
    $cine = new Cine();
    if($_POST){
            $Nom = $_POST["NOM"];
            $Cor = $_POST["COR"];
            $Ced = $_POST["CED"];
            $Cont = $_POST["CONT"];
            $cine = $cine->NUEVO_USUARIO($Nom, $Cor, $Ced, $Cont);
            echo json_encode($cine);
    }
    else{
        echo "No hay";
    }
?>