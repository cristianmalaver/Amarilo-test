<?php
$para      = 'c.malaver@rentingautomayor.com';
$titulo    = 'El título';
$mensaje   = 'Hola';
$cabeceras = 'From: developer@rentingautomayor.com.co' . "\r\n" .
    'Reply-To: d.casallas@rentingautomayor.com' . "\r\n" .
    'X-Mailer: PHP/' . phpversion();

if (mail($para, $titulo, $mensaje, $cabeceras)){
        echo("se envio correo");
        print_r(error_get_last());
}
else{
        echo("NO se envio correo");
        print_r(error_get_last());
}
