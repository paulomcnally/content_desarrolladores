[Como instalar node.js en windows/linux/mac?](/articulo/como-instalar-nodejs-en-windows-linux-mac)
=================================

[nodejs.org](http://nodejs.org/) reconoce de forma automática nuestro sistema operativo y en el boton "Install" sirve como enlace para descargar la versión más reciente para tu sistema operativo.

![Instalar node.js](http://i.imgur.com/eqQBl4n.png)

## Windows
Instalar node.js en windows es muy fácil, solo se descarga el archivo .exe o .msi se da doble click sobre el archivo y se siguen los pasos de instalación. (siguiente, siguiente..., finalizar).

Este creará en el menú inicio el acceso a la consola para node.js que basicamente es una ventana de ms-dos donde podremos ejecutar los comandos para correr una aplicación o instalar módulos para nuestras aplicaciones.

El NPM se instala durante la instalación de node.js, asi que no es necesario instalar desde otro archivo de instalación.

## Linux
Descargar el archivo .tar.gz desde [nodejs.org](http://nodejs.org/) es la manera mas complicada, esto por cuestiones de dependencias ya que se compila y requiere de todas las dependencias instaladas en la distribución.

Para Linux la mejor opción es usar manejador de paquetes.
#### Debian, LMDE
    sudo apt-get install python g++ make checkinstall
    mkdir ~/src && cd $_
    wget -N http://nodejs.org/dist/node-latest.tar.gz
    tar xzvf node-latest.tar.gz && cd node-v*
    ./configure
    checkinstall #(remove the "v" in front of the version number in the dialog)
    sudo dpkg -i node_*


#### Ubuntu, Mint
    sudo apt-get update
    sudo apt-get install python-software-properties python g++ make
    sudo add-apt-repository ppa:chris-lea/node.js
    sudo apt-get update
    sudo apt-get install nodejs


#### openSUSE & SLE
    sudo zypper ar http://download.opensuse.org/repositories/devel:/languages:/nodejs/openSUSE_12.1/ NodeJSBuildService 
    sudo zypper in nodejs nodejs-devel


#### Fedora
    sudo yum install npm


#### RHEL/CentOS/Scientific Linux 6
    su -c 'yum install npm'


#### Arch Linux
    pacman -S nodejs


#### FreeBSD and OpenBSD
    /usr/ports/www/node


## MAC OSX
Usando [homebrew](https://github.com/mxcl/homebrew)

    brew install node

Usando [macports](http://www.macports.org/)

    port install nodejs


###### Enlaces externos:
- [node.js - wikipedia](http://es.wikipedia.org/wiki/Nodejs)
- [http://nodejs.org/](nodejs.org)
- [Installing Node.js via package manager](Installing-Node.js-via-package-manager)