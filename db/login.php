<?php 

include 'koneksi.php';
$username = $_POST['username'];
$password = $_POST['password'];

$login = mysqli_query($koneksi,"select * from user where username='$username' and password='$password'");
// menghitung jumlah data yang ditemukan
$cek = mysqli_num_rows($login);

// cek apakah username dan password di temukan pada database
if($cek > 0){

	$data = mysqli_fetch_assoc($login);

	echo "Berhasil login!";
}else{
	 echo "Username & Password Anda Salah/Tidak Terdaftar!";
}
?>