<?php 
    mysqli_report(MYSQLI_REPORT_ERROR | MYSQLI_REPORT_STRICT);
    include 'conn.php';
    $nama_pelanggaran = $_POST['nama_pelanggaran'];
    $deskripsi_pelanggaran = $_POST['deskripsi_pelanggaran'];
    $poin_pelanggaran = $_POST['poin_pelanggaran'];

    $sql = "INSERT INTO tb_pelanggaran VALUES('', '$nama_pelanggaran', '$deskripsi_pelanggaran', '$poin_pelanggaran')";

     mysqli_query($db, $sql);
?>