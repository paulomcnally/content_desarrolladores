[Installar Riak en Linux desde paquete fuente](/articulo/instalar-riak-en-linux-desde-paquete-fuente)
====================================================================================================

## ¿Qué es [Riak](http://docs.basho.com/riak/latest/theory/why-riak/#What-is-Riak-)?
> Riak es una base de datos distribuida diseñada para una máxima disponibilidad


## Paso 1: Dependencias:
### Debian/Ubuntu
    sudo apt-get install build-essential libncurses5-dev openssl libssl-dev fop xsltproc unixodbc-dev

### RHEL/CentOS
    sudo yum install gcc glibc-devel make ncurses-devel openssl-devel autoconf

## Paso 2: Instalar Erlang (R15B01 Importante!)
    wget http://erlang.org/download/otp_src_R15B01.tar.gz
    tar zxvf otp_src_R15B01.tar.gz
    cd otp_src_R15B01
    ./configure && make && sudo make install



## Paso 3: Instalar Riak
### Desde paquete fuente
    curl -O http://s3.amazonaws.com/downloads.basho.com/riak/1.4/1.4.1/riak-1.4.1.tar.gz
    tar zxvf riak-1.4.1.tar.gz
    cd riak-1.4.1
    make rel

### Desde Github
    git clone git://github.com/basho/riak.git
    cd riak
    make rel

#### Fuente:
[http://docs.basho.com/riak/latest/downloads/](http://docs.basho.com/riak/latest/downloads/)