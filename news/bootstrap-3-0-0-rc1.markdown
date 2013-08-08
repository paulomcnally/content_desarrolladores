[Bootstrap 3.0.0 rc1](bootstrap-3-0-0-rc1)
=========================================

Ya puedes descargar [Bootstrap 3](http://getbootstrap.com/) en su version [release candidate](http://en.wikipedia.org/wiki/Software_release_life_cycle) 1.

Bootstrap es un completo framework web y móvil ([responsive](http://es.wikipedia.org/wiki/Dise%C3%B1o_web_adaptativo)) JavaScript y CSS.

En esta versión se notan cambios importantes como los botones que ya no tienen el efecto gradient y ahora tienen colores solidos.

## Usar con CDN

    <!-- Compilado y minimizado CSS -->
    <link rel="stylesheet" href="//netdna.bootstrapcdn.com/bootstrap/3.0.0-rc1/css/bootstrap.min.css">

    <!-- Compilado y minimizado JavaScript -->
    <script src="//netdna.bootstrapcdn.com/bootstrap/3.0.0-rc1/js/bootstrap.min.js"></script>

## ¿Qué incluye?

    bootstrap/
    ├── css/
    │   ├── bootstrap.css
    │   ├── bootstrap.min.css
    ├── js/
    │   ├── bootstrap.js
    │   ├── bootstrap.min.js


A diferencia de la versión anterior se removió la carpeta **img**.

## Plantilla basica

    <!DOCTYPE html>
    <html>
        <head>
            <title>Bootstrap 101 Template</title>
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <!-- Bootstrap -->
            <link href="css/bootstrap.min.css" rel="stylesheet" media="screen">
        </head>
        <body>
            <h1>Hello, world!</h1>

            <!-- JavaScript plugins (requires jQuery) -->
            <script src="http://code.jquery.com/jquery.js"></script>
            <!-- Include all compiled plugins (below), or include individual files as needed -->
            <script src="js/bootstrap.min.js"></script>

            <!-- Enable responsive features in IE8 with Respond.js (https://github.com/scottjehl/Respond) -->
            <script src="js/respond.js"></script>
        </body>
    </html>

## Exploradores soportados
- Chrome (Mac, Windows, iOS, and Android)
- Safari (Mac and iOS only, as Windows has more or less been discontinued)
- Firefox (Mac, Windows)
- Internet Explorer
- Opera (Mac, Windows)

## Modo de compatibilidad IE
    <meta http-equiv="X-UA-Compatible" content="IE=edge">

## Descargar
[3.0.0](https://github.com/twbs/bootstrap/archive/3.0.0-wip.zip)

Instalar con [Bower](http://bower.io/)

    bower install bootstrap