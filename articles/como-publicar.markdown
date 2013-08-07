[Cómo publicar](/articulo/como-publicar)
========================================

1.  Seleccionar un título. Ejemplo: **Hola mundo**
2.  Convertir el título a slug: **hola-mundo**
3.  Crear un archivo JSON con el nombre del slug: **[hola-mundo.json](https://gist.github.com/paulomcnally/6163629)** y guardarlo en la carpeta **[articles](https://github.com/paulomcnally/content_desarrolladores/blob/master/articles)**
4.  Crear un archivo MARKDOWN con el nombre del slug: **[hola-mundo.markdown](https://gist.github.com/paulomcnally/6163909)** y guardarlo en la carpeta **[articles](https://github.com/paulomcnally/content_desarrolladores/blob/master/articles)**
5.  Si es su primer artículo, crear un archivo JSON con su nombre pero como slug reemplazando los espacios por guiones (**-**). Ejemplo: paulomcnally.json y guardarlo en la carpeta **[authors](https://github.com/paulomcnally/content_desarrolladores/blob/master/authors)**. Importante: El parámetro **author** en el archivo **hola-mundo.json** debera ser el nombre de este archivo sin la extensión (**.json**)


## hola-mundo.json
    {
        "v": 1,
        "title": "Hola mundo",
        "date": "2013-08-06 08:53:03",
        "update": "",
        "tags": ["markdown","json"],
        "author": "paulomcnally",
        "repository": "https://github.com/paulomcnally/hola-mundo.git",
        "demo": "http://demo.aws.af.cm/",
        "type": "manual"
    }


## hola-mundo.markdown
    Hola mundo (Requerido)
    ======================

    - Descripcion (opcional)

    Contenido (Opcional)

        Código fuente (Opcional)


## paulomcnally.json
    {
        "name": "Paulo McNally",
        "email": "paulomcnally@gmail.com",
        "web": "http://www.mcnallydevelopers.com",
        "connections": [
            {
                "name": "Github",
                "nick": "paulomcnally",
                "url": "http://github.com/paulomcnally"
            },
            {
                "name": "Twitter",
                "nick": "paulomcnally",
                "url": "http://twitter.com/paulomcnally"
            }
        ]
    }


Ahora es necesario subir/crear estos archivos en el repositorio [https://github.com/paulomcnally/content_desarrolladores](https://github.com/paulomcnally/content_desarrolladores).

Se puede hacer de dos formas:

Clonar el repositorio, agregar los archivos y subir los cambios.


    git clone https://github.com/paulomcnally/content_desarrolladores.git
    cd content_desarrolladores
    mv /path/to/hola-mundo.json articles/hola-mundo.json
    mv /path/to/hola-mundo.markdown articles/hola-mundo.markdown
    mv /path/to/paulomcnally.json authors/paulomcnally.json
    git add .
    git commit -m "Hola mundo - Article"
    git push origin master


Crear archivo desde github.com:

[hola-mundo.json](https://github.com/paulomcnally/content_desarrolladores/new/master?filename=articles/hola-mundo.json) (Reemplazar con el título del artículo en formato slug)

[hola-mundo.markdown](https://github.com/paulomcnally/content_desarrolladores/new/master?filename=articles/hola-mundo.markdown) (Reemplazar con el título del artículo en formato slug)

[paulomcnally.json](https://github.com/paulomcnally/content_desarrolladores/new/master?filename=authors/paulomcnally.json) (Reemplazar con su nombre en formato slug)


## Importante:

Para que tu publicación se muestre en el sitio el moderador debera aceptar tu "pull request".

Si tienes dudas por favor deja tu comentario.

Saludos