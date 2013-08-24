[Error: Cannot find module './entities/entities.json'](/articulo/error-cannot-find-module-entities-entities-json)
=================================================================================================================

Quizás el log de node.js te ha mostrado un error parecido a este:


    Error: Cannot find module './entities/entities.json'
        at Function.Module._resolveFilename (module.js:338:15)
        at Function.Module._load (module.js:280:25)
        at Module.require (module.js:364:17)
        at require (module.js:380:17)
        at Object.<anonymous> (/var/www/html/confidencial.com.ni/node/node_modules/confidencial-ni-node/node_modules/jsdom/node_modules/htmlparser2/lib/Tokenizer.js:3:17)
        at Module._compile (module.js:456:26)
        at Object.Module._extensions..js (module.js:474:10)
        at Module.load (module.js:356:32)
        at Function.Module._load (module.js:312:12)
        at Module.require (module.js:364:17)
        at require (module.js:380:17)
        at Object.<anonymous> (/var/www/html/confidencial.com.ni/node/node_modules/confidencial-ni-node/node_modules/jsdom/node_modules/htmlparser2/lib/Parser.js:1:79)


Este error es por que el module [htmlparser2](https://npmjs.org/package/htmlparser2) no logra encontrar los siguientes archivos:

    htmlparser2
        |   lib
            |   entities
                |   decode.json
                |   entities.json
                |   legacy.json
                |   xml.json

Sin embargo suele suceder que el error se muestra en el servidor de producción y no en la PC de desarrollo o servidor de desarrollo.

##La solución:

Recuerda agregar esa carpeta a tu repositorio en git para que el producción sean descargados o desde producción dentro del modulo [jsdom](https://npmjs.org/package/jsdom) instala los módulos con el siguiente comando:

    npm install

Recuerda que ese comando debes escribirlo desde consola estando dentro de la carpeta del modulo [jsdom](https://npmjs.org/package/jsdom) que este a su vez debera estar en la carpeta **node_modules** de tu proyecto.

![xmlparser2 preview](http://i.imgur.com/ldPcD3a.png)


                