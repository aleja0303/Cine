<?php
    require_once "../Models/Modelo.php";
    $cine = new Cine();
    if($_POST){
            $Ced = $_POST["CED"];
            $Id1 = $_POST["ID1"];
            $Id2 = $_POST["ID2"];
            $Id3 = $_POST["ID3"];
            $Id4 = $_POST["ID4"];
            $Id5 = $_POST["ID5"];
            $Id6 = $_POST["ID6"];
            $Id7 = $_POST["ID7"];
            $Id8 = $_POST["ID8"];
            $cine = $cine->CREAR_RESERVA($Ced, $Id1, $Id2, $Id3, $Id4, $Id5, $Id6, $Id7, $Id8);
            echo json_encode($cine);
    }
    else{
        echo "No hay";
    }
?>