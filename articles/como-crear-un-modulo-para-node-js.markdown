[Cómo crear un módulo para node.js?](/articulo/como-crear-un-modulo-para-node-js)
=================================================================================

El módulo que desarrollaremos consiste en hacer Web scraping de [http://www.confidencial.com.ni/](http://www.confidencial.com.ni/) para obtener los artículo de cada categoría.

En primer lugar debemos crear un repositorio público, en mi caso seleccione GitHub [https://github.com/paulomcnally/confidencial-ni-node](https://github.com/paulomcnally/confidencial-ni-node) con el objetivo de que cualquier usuario de internet pueda usar el código fuente para crear su versión o para agregar funcionalidades.

Ahora procedemos a clonar el repositorio, esto lo hacemos desde la consola (require [git](http://git-scm.com/downloads))

    git clone https://github.com/paulomcnally/confidencial-ni-node.git

Accedemos al directorio que se acaba de crear:

    cd confidencial-ni-node

El primer archivo que creamos es **index.js**, este archivo tiene la carga de la libreria o archivo con las funciones, básicamente es para poder usar un require('nombre') ya que hace referencia a la carga de la carpeta fuente:

    module.exports = process.env.CONFIDENCIAL_COV ? require('./lib-cov/confidencial') : require('./lib/confidencial');

Ahora crearemos la carpeta **lib** y accedemos a ella:

    mkdir lib
    cd lib


Dentro de la carpeta lib creamos un archivo javascript con el nombre de nuestro modulo, en mi caso **confidencial.js**, las funciones que estan en este archivo son las que podemos usar de manera global, este archivo lo que hace es leer un url y obtiene los datos como título, contenido, imagenes, categoría, autor, id, también lee el sitio web basado en la lista de url de las categoríaa para obtener los enlaces a los artículos en cada categoría:

    // Load modules
    var jsdom = require('jsdom');
    var fs = require('fs');
    var S = require('string');
    var request = require('request');
    var cheerio = require('cheerio');
    var async = require('async');
    var jquery = fs.readFileSync(require('path').resolve(__dirname, 'jquery.min.js')).toString();

    // confidencial categories
    var categories = new Array();
    categories.push('http://www.confidencial.com.ni/politica/1');
    categories.push('http://www.confidencial.com.ni/blogs/40');
    categories.push('http://www.confidencial.com.ni/economia/2');
    categories.push('http://www.confidencial.com.ni/economia/2/20');
    categories.push('http://www.confidencial.com.ni/nacion/4/3');
    categories.push('http://www.confidencial.com.ni/mundo/4');
    categories.push('http://www.confidencial.com.ni/centroamerica/4/1');
    categories.push('http://www.confidencial.com.ni/vida-y-ocio/30');
    categories.push('http://www.confidencial.com.ni/turismo/30/35');
    categories.push('http://www.confidencial.com.ni/tecnologia/30/32');
    categories.push('http://www.confidencial.com.ni/gastronomia/30/34');
    categories.push('http://www.confidencial.com.ni/espectaculo/30/33');
    categories.push('http://www.confidencial.com.ni/deportes/30/36');
    categories.push('http://www.confidencial.com.ni/cultura/30/71');
    categories.push('http://www.confidencial.com.ni/reporte-ciudadano/60');
    categories.push('http://www.confidencial.com.ni/denuncias/60/62');
    categories.push('http://www.confidencial.com.ni/yo-opino/60/61');


    // article scraping data
    var parseArticleOptions = {
        domain: "http://www.confidencial.com.ni/",
        elements: [
            {
                name: 'title',
                sel: function ($) {
                    var result = $('#articleheader h2').text().trim();
                    return ( !S(result).isEmpty() ) ? result : '';
                }
            },
            {
                name: 'title_sub',
                sel: function($) {
                    var result = $('#articleheader h3').text().trim();
                    return ( !S(result).isEmpty() ) ? result : '';
                }
            },
            {
                name: 'title_paragraph',
                sel: function($) {
                    var result = $('#articleheader p.bold').text().trim();
                    return ( !S(result).isEmpty() ) ? result : '';
                }
            },
            {
                name: 'author',
                sel: function($) {
                    var result = $('#articleheader p.authorname').text().trim().split("|")[0].trim();
                    return ( !S(result).isEmpty() ) ? result : '';
                }
            },
            {
                name: 'date',
                sel: function($) {
                    var result = $('#articleheader p.authorname').text().trim().split("|")[1].trim();
                    return ( !S(result).isEmpty() ) ? S(result).left(9).s : '';
                }
            },
            {
                name: 'images',
                sel: function($) {
                    var result = [];
                    var array = $("article img").map(function() {
                        return $(this).attr("src");
                    }).get();
                    array.forEach(function(item){
                        result.push( parseArticleOptions.domain + item );
                    });
                    return ( !S(result).isEmpty() ) ? result : [];
                }
            },
            {
                name: 'category',
                sel: function($) {
                    var result = $("#quicknav").text();
                    if( !S(result).isEmpty() ){
                        result = S(result).trim().s;
                        result = S(result).replaceAll('Confidencial', '').s;
                        result = S(result).replaceAll('Leer artículo', '').s;
                        result = S(result).replaceAll('»', '').s;
                        result = S(result).trim().s;

                    }
                    return ( !S(result).isEmpty() ) ? S(result).trim().s : '';
                }
            },
            {
                name: 'content',
                sel: function($) {
                    var new_result = "";
                    var result = $("article div.content_article div.text_article").html().trim();
                    if( !S(result).isEmpty() ){
                        new_result = S( result ).stripTags('p,br,strong').s;

                        new_result = S( new_result ).collapseWhitespace().s;
                        new_result = S( new_result ).replaceAll('<br />', '\n').s;
                        new_result = S( new_result ).replaceAll('<p>', '').s;
                        new_result = S( new_result ).replaceAll('</p>', '\n').s;
                        new_result = S( new_result ).replaceAll('&nbsp;', '').s;

                        new_result = S( new_result.replace(/<a.*href="(.*?)".*>(.*?)<\/a>/gi, "$2 $1") ).trim().s;

                        new_result = new_result.replace(/<(?:.|\n)*?>/gm, '');

                        if( S( new_result).endsWith('\n') ){

                        }
                    }
                    return ( !S(result).isEmpty() ) ? S(new_result).trim().s : '';
                }
            }
        ]
    };


    // simple function to compare if exist item in array
    function inArray(needle, haystack) {
        var length = haystack.length;
        for(var i = 0; i < length; i++) {
            if(haystack[i] == needle) return true;
        }
        return false;
    }


    // function to parse data
    function parse(site, callback) {
        jsdom.env({
            url: site,
            src: [jquery],
            done: function (err, window) {
                callback(window.$, err);
            }
        });
    };


    // Global function to get all links from all categories
    module.exports.getAllLinks = function(callback){
        function out(){
            var result = [];

            var fetch = function(url,cb){
                request(url, function(err,response,body){
                    if ( err ){
                        cb( err );
                    } else {
                        cb( null, body ); // First param indicates error, null=> no error
                    }
                });
            }

            async.map(categories, fetch, function(err, results){
                if ( err){
                    console.log(err);
                    // either file1, file2 or file3 has raised an error, so you should not use results and handle the error
                } else {
                    results.forEach(function(category){
                        $ = cheerio.load(category);
                        var links = $('.article h3 a,article h2 a'); //use your CSS selector here
                        $(links).each(function(i, link){

                            var article_url = 'http://confidencial.com.ni/' + $(link).attr('href');

                            if( !inArray( article_url, result ) ){

                                result.push( article_url );
                            }
                        });

                    });

                    callback(result);
                }
            });
        }

        out();
    }


    // global function to get data from article url
    module.exports.getArticle = function(site, cb){

        function getId(url){
            var id = url.split('/');
            return id[4];
        }

        function out(url) {
            parse(url, function ($, err) {
                var result = {};
                result.id = getId(url);
                result.url = url;
                parseArticleOptions.elements.forEach(function (elem) {
                    result[elem.name] = elem.sel($);
                });

                cb(result, err);
            });
        }

        out(site);

    }


También crearemos un archivo **jquery.min.js**, este es útil para el modulo [jsdom](https://npmjs.org/package/jsdom), este es usado para leer el DOM de la página y obtener los datos del artículo. El contenido de este archivo es [jQuery v1.10.1](http://code.jquery.com/jquery-1.10.1.min.js)

    wget http://code.jquery.com/jquery-1.10.1.min.js -O jquery.min.js

Ahora saldremos de la carpeta **lib**, crearemos la carpeta **test** y accedemos a ella:

    cd ..
    mkdir test
    cd test


Dentro de esta carpeta crearemos el archivo **test.js**:

    var confidencial = require('../lib/confidencial');

    confidencial.getArticle('http://www.confidencial.com.ni/articulo/13169/turismo-al-pie-del-mombacho', function(resultData) {
        console.log(resultData);
    });

    confidencial.getAllLinks(function(data){
        console.log(data);
    });


Al correr/ejecutar el archivo test obtendremos dos resultados en el log.

getArticle:

    {
        id:"13169",
        url:"http://www.confidencial.com.ni/articulo/13169/turismo-al-pie-del-mombacho",
        title:"Turismo al pie del Mombacho",
        title_sub:"Emoción con aroma a café en las faldas del centinela de Granada",
        title_paragraph:"Si los fines de semana en Managua le parecen monótonos, a una hora de la capital encuentra una alternativa turística que reúne naturaleza, cultura y adrenalina",
        author:"Cinthia Membreño",
        date:"11/8/2013",
        images:
            [
                "http://www.confidencial.com.ni/img/p/b15020.jpg",
                "http://www.confidencial.com.ni/media/13169_1.jpg?rand=588",
                "http://www.confidencial.com.ni/media/13169_2.jpg?rand=819"
            ],
        category:"Arte y Ocio",
        content:"Apenas una hora de viaje en vehículo separa el bullicio de Managua de la tranquilidad y frescura que caracterizan las verdosas faldas del Volcán Mombacho, el centinela sin cono que resguarda la ciudad colonial de Granada, al Sur de la capital. En la zona agrícola de esta imponente elevación geográfica, el día comienza con el sonido de las palas surcando los plantíos de maíz y con el correteo de los niños que estudian en las escuelas comunitarias de Miravalle.\n Un prolongado camino de tierra, que separa centros educativos de parcelas, conduce a decenas de turistas hasta la Hacienda El Progreso, una propiedad que data de finales del siglo XIX y en donde se produce el “Café Las Flores https://cafelasflores.com/”, certificado por Rainforest Alliance. Esta finca es también parte de una reserva natural que porta el mismo nombre del volcán, hogar de más de 700 especies de plantas (entre ellas 150 tipos de Orquídeas), cuatro senderos de distinta dificultad, un canopy y un ecoalbergue.\n En las entrañas de este santuario natural labora Luis Altamirano, un joven moreno de veintidós años originario de la ciudad de Diriomo (Granada), quien tras estudiar idiomas en la Universidad Nacional Autónoma de Nicaragua (UNAN-Managua) y de enseñar español en una escuela localizada al Sur de Francia, decidió convertirse en un guía turístico. Su vocación nació más por un inconveniente que por una convicción adquirida desde niño.\n “Estando allá, una de mis compañeras de trabajo me preguntó qué lugares conocía de mi país y yo no supe qué contestarle en ese momento. Pensé que al regresar debía aprender a destacar los destinos que vale la pena visitar en Nicaragua, así que aproveché la estadía en Francia para tomar unos cursos sobre turismo, enfocados en Centroamérica y Sudamérica”, confiesa el muchacho.\n De vuelta en su país, Altamirano cumplió su promesa. Desde hace seis meses labora como guía de Mombotour http://www.canatur-nicaragua.org/profile/205-mombotours-cafe-las-flores, una touroperadora nacional que desde el 2000 atrae miles de visitantes anualmente, entre los que predominan estadounidenses y nicaragüenses residentes en el exterior. Esta empresa es, a su vez, uno de los pilares fundamentales de la finca cafetalera en la que, convenientemente, también se encuentra una sucursal de Café Las Flores.\n De la semilla a la taza\n \n\n Esta mañana, Luis Altamirano inicia su jornada liderando el Origin Tour https://shop.cafelasflores.com/gp/4/ (US$23.10 p/p), un paseo que dura aproximadamente una hora y que adentra al turista por los veintiocho lotes que conforman la hacienda. El recorrido parte de una enorme pila de cemento que almacena agua proveniente de uno de los manantiales del Mombacho y que posteriormente utilizan para lavar los granos de café.\n Durante el tour, el joven explica que allí se produce un tipo de grano híbrido de alta calidad que además es resistente a enfermedades como la Roya o la Broca. Su nombre es Catuaí, una combinación de las especies Arábica y Robusta, dos de las más cultivadas en el país. Granos amarillos, rojos y verdes se procesan por separado para que no pierdan su calidad, indica Altamirano, pues su estado de madurez no es el mismo.\n En esta finca, la época de corte se extiende desde Noviembre hasta Enero. En esas fechas, un centenar de trabajadores de comunidades aledañas se trasladan hasta las faldas del volcán y, cuando son buenos recolectores, recogen en promedio entre cien y doscientas libras de café en un solo día. Como los campesinos no llegan solos, sino acompañados de sus familias, algunos pueden recolectar hasta 250 o 300 libras de este grano en los diez surcos asignados a cada núcleo.\n El beneficio de la Hacienda El Progreso, cuya extensión es de 130 hectáreas, es la siguiente parada del recorrido. Por ser ésta una mañana de Julio, mes en el que no hay recolecta, el local está completamente vacío. Apenas se puede percibir el olor del grano que alguna vez fue “despulpado” (desprendido de su primera piel), fermentado y lavado para su posterior proceso de secado, el cual se realiza en unas gigantes planchas de cemento que se encuentran al aire libre.\n En este mismo edificio hay una sala en la que las mujeres están al mando. Sus manos reciben el café trillado (remover la segunda capa del grano), separado según su calidad y “cepillado” por una máquina que retira el mesocarpio (tercera piel del grano). Ellas realizan un proceso que aún no se ha mecanizado, que es la última selección del café de primera y segunda calidad, separando aquel que resulta defectuoso. La rapidez que caracteriza a estas trabajadoras ha hecho que predominen en esta sección.\n “De aquí salen unas 150 libras procesadas por mujer al día, de una jornada que va desde las siete de la mañana hasta las cuatro de la tarde. El café defectuoso se vende a las empresas nacionales, porque los productores prefieren tostar y exportar los granos de alta calidad al extranjero, ya que se generan más ganancias”, alega el joven guía.\n Al finalizar el recorrido, Altamirano dirige a los turistas a una casa antigua en donde la familia Palazio, propietaria del lugar, pasaba sus vacaciones. En su terraza se puede degustar una taza de café saborizado con vainilla y disfrutar de la vista panorámica del departamento de Masaya, mientras decenas de visitantes arriban a bordo de camiones de diseño militar ruso. El silbido producido por las fuertes corrientes de aire fresco que provienen del Lago Cocibolca, le dan el toque fantasmagórico al sitio.\n Como monos por los árboles\n \n\n La veo lempa (pálida) –le dice Luis Altamirano, con sonrisa burlona, a una joven turista\n ¿Cómo no estarlo? – le responde ella, mientras las piernas le tiemblan sin control\n Bajo la plataforma en la que ambos se encuentran, sus pies saludan a las plantaciones de café que a diario observan a decenas de visitantes deslizarse de un gigantesco árbol a otro, suspendidos por cables de acero. Unos lo llaman “canopy https://shop.cafelasflores.com/gp/3/”. Otros, una prueba más para superar el miedo a las alturas.\n Erick Bonilla, Gerente de Turismo de Mombotour, afirma que esta es la actividad preferida de los turistas (US$20.75 p/p) que arriban a la reserva. Durante el recorrido de aproximadamente dos horas, los visitantes hacen paradas en quince plataformas enlazadas por seis tirolesas que incluyen juegos como el boomerang, la doble cruz, el swing del Tarzán y un descenso vertical de rappel.\n Luis Altamirano, quien también lidera los paseos por los senderos que rodean la cima del Mombacho, afirma que el primer tramo del canopy constituye la peor parte para quien le teme a las alturas. “Después de recorrer la primera línea, la gente va ganando confianza y termina deslizándose sola. Es una cuestión mental, de superar ese miedo”, asegura quien fue entrenado durante tres meses para ser guía de la finca.\n Esta mañana, el joven probó su punto. La turista que en un principio le rogó para que no la dejara deslizarse sola continuó haciéndolo independientemente, incluso en los tramos de mayor extensión, que llegan a superar los 150 metros de largo y desde donde se tienen impresionantes vistas de una parte de la Reserva Natural Volcán Mombacho.\n Los guías afirman que, al menos en este sitio, no han ocurrido aparatosos accidentes. Con mucha paciencia, todos deben explicar al turista qué necesita hacer para mantenerse seguro. Mientras los humanos se deslizan con valentía o llenos de miedo, los monos que habitan la reserva observan desde lo alto a quienes, sólo durante ratos, pueden hacer lo mismo que ellos: balancearse por los árboles.\n ---\n Para mayor información visite el siguiente enlace https://cafelasflores.com/."
    }


getAllLinks:

    ["http://confidencial.com.ni/articulo/13223/hknd-039-no-sabemos-039-wang-es-039-visionario-039","http://confidencial.com.ni/articulo/13231/ortega-dio-luz-verde-a-exploracion-petrolera-en-el-caribe","http://confidencial.com.ni/articulo/13219/portazo-parlamentario-a-jarquin","http://confidencial.com.ni/articulo/13206/ya-son-22-recursos-contra-la-concesion-canalera","http://confidencial.com.ni/articulo/13204/asamblea-se-equivoca-y-039-rectifica-039-destitucion-de-jarquin","http://confidencial.com.ni/articulo/13234/una-manera-de-evaluar-la-sexualidad","http://confidencial.com.ni/articulo/13230/trabajo-domestico-iquest-finalmente-remuneradon","http://confidencial.com.ni/articulo/13191/iquest-realmente-es-imposible-ahorrarn","http://confidencial.com.ni/articulo/13154/la-cama-termometro-de-la-relacion","http://confidencial.com.ni/articulo/13140/iquest-como-se-cura-la-teta-asustadan","http://confidencial.com.ni/articulo/13122/productividad-el-gran-reto-de-la-economia","http://confidencial.com.ni/articulo/13109/fmi-nicaragua-no-necesita-un-nuevo-acuerdo","http://confidencial.com.ni/articulo/13104/quot-esta-es-una-economia-muy-vulnerable-quot","http://confidencial.com.ni/articulo/13080/agricorp-admite-atraso-en-sus-pagos","http://confidencial.com.ni/articulo/13005/la-paradoja-del-crecimiento-nica","http://confidencial.com.ni/articulo/13220/la-bolsa-de-valores-039-sonrie-039","http://confidencial.com.ni/articulo/13174/nimac-espera-auge-agricola-y-constructivo","http://confidencial.com.ni/articulo/12891/cargill-invertira-us-6-millones-en-2013","http://confidencial.com.ni/articulo/12848/construccion-celebra-crecimiento","http://confidencial.com.ni/articulo/12809/la-bolsa-de-valores-se-lsquo-engorda-039","http://confidencial.com.ni/articulo/13180/rezos-promesas-y-ritos-paganos","http://confidencial.com.ni/articulo/13217/consulado-tico-cambiara-sus-oficinas","http://confidencial.com.ni/articulo/13179/ejercito-busca-patrullas-navales-en-rusia","http://confidencial.com.ni/articulo/13156/16-recursos-contra-ley-ortega-wang","http://confidencial.com.ni/articulo/13145/negociaran-reformal-al-inss-en-septiembre","http://confidencial.com.ni/articulo/13207/quot-correa-no-puede-sustituir-a-chavez-quot","http://confidencial.com.ni/articulo/13116/supremo-venezolano-rechaza-impugnacion-de-elecciones","http://confidencial.com.ni/articulo/13096/asalto-a-oficina-de-relator-de-la-onu-en-guatemala","http://confidencial.com.ni/articulo/13083/los-graham-se-deshacen-del-039-washington-post-039","http://confidencial.com.ni/articulo/13082/maduro-compara-a-chavez-con-cristo","http://confidencial.com.ni/articulo/13126/falta-voluntad-politica-para-combatir-al-quot-narco-quot-en-honduras","http://confidencial.com.ni/articulo/13108/masacre-039-narco-039-en-honduras","http://confidencial.com.ni/articulo/13033/en-vigor-el-acuerdo-comercial-con-europa","http://confidencial.com.ni/articulo/12750/salvan-en-costa-rica-a-nicas-victima-de-trata-de-personas","http://confidencial.com.ni/articulo/12730/asesinatos-de-alto-perfil-conmueven-a-honduras","http://confidencial.com.ni/articulo/13224/un-rap-contra-fidel","http://confidencial.com.ni/articulo/13169/turismo-al-pie-del-mombacho","http://confidencial.com.ni/articulo/13218/el-humor-critico-de-pedro-x-molina-en-confidencial","http://confidencial.com.ni/articulo/13208/nicaragua-uno-de-los-mejores-destinos-naturales","http://confidencial.com.ni/articulo/13181/crevettes-by-la-casserole-bon-appetit","http://confidencial.com.ni/articulo/12526/granada-nominada-a-mejor-destino","http://confidencial.com.ni/articulo/11475/039-boom-039-de-pequenos-hoteles-en-managua","http://confidencial.com.ni/articulo/11440/la-nueva-cara-del-xolotlan","http://confidencial.com.ni/articulo/12102/el-039-smartphone-039-te-desvela","http://confidencial.com.ni/articulo/11890/yahoo-se-rejuvenece","http://confidencial.com.ni/articulo/11870/gmail-la-nueva-billetera-electronica","http://confidencial.com.ni/articulo/11804/reprograman-celulas-de-piel-humana-para-que-sean-celulas-madre","http://confidencial.com.ni/articulo/11789/tres-colosales-erupciones-solares","http://confidencial.com.ni/articulo/12856/mandarin-asia-en-managua","http://confidencial.com.ni/articulo/12653/the-temple-bar-un-lugar-estupendo","http://confidencial.com.ni/articulo/12399/sushi-al-alcance-de-todos-los-bolsillos","http://confidencial.com.ni/articulo/12216/kikiriko-bueno-bonito-barato","http://confidencial.com.ni/articulo/13146/quot-el-dinero-limita-al-musico-en-nicaragua-quot","http://confidencial.com.ni/articulo/13036/las-nuevas-039-rolas-039-de-molotov","http://confidencial.com.ni/articulo/12879/muevase-con-el-joropo","http://confidencial.com.ni/articulo/12769/el-existencialismo-de-eleonore","http://confidencial.com.ni/articulo/12708/luis-enrique-debutara-en-broadway","http://confidencial.com.ni/articulo/13175/la-costa-pego-primero","http://confidencial.com.ni/articulo/13188/la-costa-arrincona-al-boer","http://confidencial.com.ni/articulo/13129/039-el-tren-del-norte-039-se-descarrila-otra-vez","http://confidencial.com.ni/articulo/13070/cabrera-suspendido","http://confidencial.com.ni/articulo/13018/039-habra-nuevo-estadio-de-beisbol-039","http://confidencial.com.ni/articulo/13178/una-cita-con-sergio-ramirez","http://confidencial.com.ni/articulo/13128/si-otra-managua-es-posible","http://confidencial.com.ni/articulo/13090/un-premio-en-homenaje-a-ernesto-cardenal","http://confidencial.com.ni/articulo/13061/las-propuestas-de-icaro-2013","http://confidencial.com.ni/articulo/13238/iquest-cuales-son-los-miedos-de-mario-vallen","http://confidencial.com.ni/articulo/13193/abuso-animal","http://confidencial.com.ni/articulo/13133/le-cancelan-contrato-por-criticar-a-diputados-sandinistas","http://confidencial.com.ni/articulo/13132/policia-no-responde-por-vehiculos-robados","http://confidencial.com.ni/articulo/13131/los-muros-que-nos-imaginamos-y-en-los-que-creemos","http://confidencial.com.ni/articulo/13115/policia-oculta-quot-informe-quot-sobre-robo-de-vehiculos","http://confidencial.com.ni/articulo/12555/iquest-que-esta-sucediendo-en-nicaraguan","http://confidencial.com.ni/articulo/12553/victoria-contundente-de-los-adultos-mayores-y-ocupainss","http://confidencial.com.ni/articulo/12552/testimonio-de-un-atropello-a-la-dignidad","http://confidencial.com.ni/articulo/12396/despertar-de-un-pueblo"]


Ahora vamos a crear el archivo **package.json**, este contiene toda la información del módulo:

    {
        "name": "confidencial-ni-node"
        , "description": "Web scraping http://www.confidencial.com.ni/"
        , "version": "0.0.1"
        , "author": "Paulo McNally <paulomcnally@gmail.com>"
        , "keywords": ["nicaragua", "diario", "news"]
        , "dependencies": {
            "string": "1.5.0",
            "jsdom": "0.8.3",
            "request": "2.26.0",
            "cheerio": "0.12.1",
            "async": "0.2.9"
        }
        , "directories": { "lib": "./lib/confidencial" }
        , "main": "./index.js"
        , "bugs": {
            "url":"https://github.com/paulomcnally/confidencial-ni-node/issues/new",
            "email": "paulomcnally@gmail.com"
        }
        , "repository": {
        "type": "git"
            , "url": "git://github.com/paulomcnally/confidencial-ni-node.git"
        }
    }


Dependencias de este módulo:

- [string](https://npmjs.org/package/string) contiene muchas funciones relacionadas a cadenas de texto.
- [jsdom](https://npmjs.org/package/jsdom) se usa para la manipulación del DOM.
- [request](https://npmjs.org/package/request) se usa para hacer peticiones http por get/post para obtener eo cuerpo de la página.
- [cheerio](https://npmjs.org/package/cheerio) igual que jsdom sirve para manipular el dom.
- [async](https://npmjs.org/package/async) sirve para hacer llamados a funciones de forma asyncrona, en el caso de request no es asyncrono y con este modulo logramos obtener todas las url de una forma asyncrona.


Ya con nuestro modulo finalizado ahora nos regresamos dos carpetas para quedar fuera de la carpeta del repositorio.

    cd ../../

Ahora podemos publicar nuestro modulo en npmjs.org

    npm publish confidencial-ni-node

Veremos un log asi:

    npm http PUT https://registry.npmjs.org/confidencial-ni-node
    npm http 201 https://registry.npmjs.org/confidencial-ni-node
    npm http GET https://registry.npmjs.org/confidencial-ni-node
    npm http 200 https://registry.npmjs.org/confidencial-ni-node
    npm http PUT https://registry.npmjs.org/confidencial-ni-node/-/confidencial-ni-node-0.0.1.tgz/-rev/1-cd876248860c00eca00e03efc5536ba6
    npm http 201 https://registry.npmjs.org/confidencial-ni-node/-/confidencial-ni-node-0.0.1.tgz/-rev/1-cd876248860c00eca00e03efc5536ba6
    npm http PUT https://registry.npmjs.org/confidencial-ni-node/0.0.1/-tag/latest
    npm http 201 https://registry.npmjs.org/confidencial-ni-node/0.0.1/-tag/latest
    + confidencial-ni-node@0.0.1

Ahora tenemos que esperar que nuestro modulo este disponible en el url: [https://npmjs.org/package/confidencial-ni-node](https://npmjs.org/package/confidencial-ni-node)

## Uso:

Instalar:

    npm install confidencial-ni-node

Ejemplo:

    var confidencial = require('confidencial-ni-node');
    confidencial.getArticle('http://www.confidencial.com.ni/articulo/13169/turismo-al-pie-del-mombacho', function(resultData) {
        console.log(resultData);
    });

#### Referencia:

- [Web scraping - Wikipedia - Ingles](http://en.wikipedia.org/wiki/Web_scraping)]