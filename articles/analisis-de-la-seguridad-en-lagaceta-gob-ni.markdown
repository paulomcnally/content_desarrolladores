[Análisis de la seguridad en lagaceta.gob.ni](/articulo/analisis-de-la-seguridad-en-lagaceta-gob-ni)
============================================================================================================

El primer paso para análizar la seguridad del sitio web http://lagaceta.gob.ni fué escanear puertos:

![Imgur](http://i.imgur.com/ajH7F0d.png)

Si se accede al url [ftp://lagaceta.gob.ni/](ftp://lagaceta.gob.ni/) se ve que no solicita autenticación. Si se usa [Filezilla](https://filezilla-project.org) cualquiera puede acceder y **hackear** el sitio web con solo reemplazar el archivo index.html

También se puede acceder al archivo de configuración del antiguo sitio donde se ven datos como la coneción a la base de datos. [ftp://lagaceta.gob.ni/old%20sites/configuration.php](ftp://lagaceta.gob.ni/old%20sites/configuration.php).

El o los hackers que hakearon hoy ese sitio usaron una Shell, esta esta subida 10/8/13 7:43:00 PM y se puede acceder este este url: [http://lagaceta.gob.ni/old%20sites/batak.php](http://lagaceta.gob.ni/old%20sites/batak.php).

Hay otros sitios en ese mismo servidor:

![Imgur](http://i.imgur.com/axqRl5Z.png)

Con administradores de servidores que dejan el acceso FTP cómo no los van a hackear?