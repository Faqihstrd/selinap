<?php 
    mysqli_report(MYSQLI_REPORT_ERROR | MYSQLI_REPORT_STRICT);
    include 'conn.php';

    $id = $_POST['id_pelanggaran'];

    $sql = "DELETE FROM tb_pelanggaran WHERE id_pelanggaran = $id";
    
    mysqli_query($db, $sql);
?> 