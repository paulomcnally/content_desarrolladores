[com.todo1.lafise.mobileapp](/articulo/com-todo1-lafise-mobileapp)
==================================================================

**Actualización:** Septiembre 4, 2013. Versión: 1.0.2 Se solucionó el problema del CordovaLog.

En este artículo analizaremos la aplicación móvil para Android de [Banco Lafise](https://www.lafise.com/default.aspx).

A simple vista es una Web Application, esto quiere decir que esta aplicación usa WebView para cargar páginas web locales o externas.

La pantalla principal carga una página web local:
![Error Lafice Application Android](http://i.imgur.com/asLk2PP.jpg)

Para las validaciones del inicio de sesión usan un Web Service, y la autenticación la hacen hacia el siguiente url:
    
    https://lafisemovil.com/cb/mbanking/services/authenticate

Al menos es un url seguro (https significa que usan un certificado de seguridad SSL).

El url anterior fue obtenido al escribir en la consola/terminal el siguiente comando:
    
    adb shell logcat | grep -E "lafise"

La pantalla de **Ubícanos** se comunica con el Web Service hacia la siguiente dirección:
    
    https://lafisemovil.com/cb/mbanking/services/CorpLocation

El Web Service responde lo siguiente:
    
    D/CordovaLog(10366): <soapenv:Envelope xmlns:ns1="http://services.mbanking.sybase.com/schema" xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/"><soapenv:Header/><soapenv:Body><getLocationsResponse><ns1:return><ns1:locId>116</ns1:locId><ns1:name>PETRONIC (Tipitapa)</ns1:name><ns1:addr>Km 32 Carretera Norte Tipitapa</ns1:addr><ns1:zipcode/><ns1:miles>0.30639773771031735</ns1:miles><ns1:lat>12.1944722222222</ns1:lat><ns1:lon>-86.1040555555555</ns1:lon><ns1:phone/><ns1:fax/><ns1:schedule>24 horas</ns1:schedule><ns1:service>ATM</ns1:service><ns1:extraMap size="0"/></ns1:return><ns1:return><ns1:locId>144</ns1:locId><ns1:name>Indenicsa (Tipitapa)</ns1:name><ns1:addr>KM. 22 Carretera Managua Tipitapa</ns1:addr><ns1:zipcode/><ns1:miles>0.87491661288485041</ns1:miles><ns1:lat>12.1931638888889</ns1:lat><ns1:lon>-86.0951527777778</ns1:lon><ns1:phone/><ns1:fax/><ns1:schedule>24 horas</ns1:schedule><ns1:service>ATM</ns1:service><ns1:extraMap size="0"/></ns1:return><ns1:return><ns1:locId>100</ns1:locId><ns1:name>SAE-A TECNOTEX, S.A. (Tipitapa)</ns1:name><ns1:addr>Km 47.5 Carretera Tipitapa Masaya</ns1:addr><ns1:zipcode/><ns1:miles>3.5286152675166127</ns1:miles><ns1:lat>12.1660361111111</ns1:lat><ns1:lon>-86.0938944444444</ns1:lon><ns1:phone/><ns1:fax/><ns1:schedule>24 horas</ns1:schedule><ns1:service>ATM</ns1:service><ns1:extraMap size="0"/></ns1:return><ns1:return><ns1:locId>2</ns1:locId><ns1:name>Astro</ns1:name><ns1:addr>Km 47 Carretera Tipitapa Masaya</ns1:addr><ns1:zipcode/><ns1:miles>3.6994900755445346</ns1:miles><ns1:lat>12.1648611111111</ns1:lat><ns1:lon>-86.0923888888889</ns1:lon><ns1:phone>22955074</ns1:phone><ns1:fax>22955078</ns1:fax><ns1:schedule>L-V 8am - 4:30pm / S&#225;bado 8am - 12:00</ns1:schedule><ns1:service>Sucursal / ATM</ns1:service><ns1:extraMap size="0"/></ns1:return><ns1:return><ns1:locId>21</ns1:locId><ns1:name>Ventanilla DINANT</ns1:name><ns1:addr>Km. 13 Carretera a Masaya, 100 metros al Sur-Oeste.</ns1:addr><ns1:zipcode/><ns1:miles>3.8063424215140995</ns1:miles><ns1:lat>12.1638333333333</ns1:lat><ns1:lon>-86.0924722222222</ns1:lon><ns1:phone>22798966 Ext. 5921</ns1:phone><ns1:fax>22798717</ns1:fax><ns1:schedule>L-V 8am - 4:30pm / S&#225;bado 8am - 12:00</ns1:schedule><ns1:service>Ventanilla</ns1:service><ns1:extraMap size="0"/></ns1:return><ns1:return><ns1:locId>22</ns1:locId><ns1:name>Ventanilla BIG COLA</ns1:name><ns1:addr>Parque industrial Portezuelo</ns1:addr><ns1:zipcode/><ns1:miles>3.809305654775024</ns1:miles><ns1:lat>12.1638055555556</ns1:lat><ns1:lon>-86.0924722222222</ns1:lon><ns1:phone>22513973</ns1:phone><ns1:fax/><ns1:schedule>L-V 8am - 4:30pm / S&#225;bado 8am - 12:00</ns1:schedule><ns1:service>Ventanilla</ns1:service><ns1:extraMap size="0"/></ns1:return><ns1:return><ns1:locId>30</ns1:locId><ns1:name>Zona Franca</ns1:name><ns1:addr>Km. 12.5 Carretera Norte</ns1:addr><ns1:zipcode/><ns1:miles>7.987793538782334</ns1:miles><ns1:lat>12.1486305555556</ns1:lat><ns1:lon>-86.1569944444445</ns1:lon><ns1:phone>22631490</ns1:phone><ns1:fax>22631503</ns1:fax><ns1:schedule>L-V 8am - 4:30pm / S&#225;bado 8am - 12:00</ns1:schedule><ns1:service>Sucursal / ATM</ns1:service><ns1:extraMap size="0"/></ns1:return><ns1:return><ns1:locId>141</ns1:locId><ns1:name>Aeropuerto</ns1:name><ns1:addr>Km 10. Carretera Norte</ns1:addr><ns1:zipcode/><ns1:miles>9.508588964282003</ns1:miles><ns1:lat>12.1439722222222</ns1:lat><ns1:lon>-86.17125</ns1:lon><ns1:phone/><ns1:fax/><ns1:schedule>24 horas</ns1:schedule><ns1:service>ATM</ns1:service><ns1:extraMap size="0"/></ns1:return><ns1:return><ns1:locId>103</ns1:locId><ns1:name>UNOPETROL Las Mercedes</ns1:name><ns1:addr>Km 9.5 Carretera Norte</ns1:addr><ns1:zipcode/><ns1:miles>9.605279231471341</ns1:miles><ns1:lat>12.1460027777778</ns1:lat><ns1:lon>-86.1739277777778</ns1:lon><ns1:phone/><ns1:fax/><ns1:schedule>24 horas</ns1:schedule><ns1:service>ATM</ns1:service><ns1:extraMap size="0"/></ns1:return><ns1:return><ns1:locId>118</ns1:locId><ns1:name>PUMA Las Mercedes</ns1:name><ns1:addr>Km 8.5 Carretera
	D/CordovaLog(10366): tagName getLocationsResponse

Esta parte de la aplicación me ha demostrado que cargar Google Maps en un WebView es bastante eficiente, me gusto que el orden de las sucursales es basado en geolocalización. Esta no usa el GPS, usa la ubicación basada en la última ubicación del router o dispositivo del que se conectó vía Wifi nuestro dispositivo android.

Una critica es que en la opción "Ver Direcciones" nos lanza al mapa pero en un punto donde carga Centro America y no en las coordenadas de la ubicación de la sucursal.

Una critica más para el evento **back**, como todos sabran android nos da un botón **atras** en cada dispositivo, esta aplicación maneja los eventos de ir a una pantalla anterior usando el botón en la pantalla el cual funciona a la perfección, pero al usar el botón físico que trae nuestro dispositivo móvil cierra la aplicación, esto pasa por haber cargado una Activity (pantalla) y dentro de ella todo carga como si en un sitio web cargaramos un iframe y dentro de este iframe una web, así que deben tener cuidado de no usar el botón físico si desean ir una pantalla atras en esta aplicación.

La pantalla de **Contáctenos** y **Ayuda** son locales y no requieren de comunicación con el Web Service.

Otro archivo que intenta cargar de forma local es strings.js pero según la consola el archivo no es encontrado:
    
    E/generateWebResourceResponse(10366): java.io.FileNotFoundException: www/language/strings.js

Basádo en los métodos del log el desarrollo de esta aplicación fue con [Apache Cordoba](http://cordova.apache.org/), esto claro está que se ha identificado en el log:
    
    D/CordovaWebView(10366): >>> loadUrl(file:///android_asset/www/index.html)
    D/DroidGap(10366): onMessage(onPageStarted,file:///android_asset/www/index.html)
    D/Cordova (10366): onPageFinished(file:///android_asset/www/index.html)
    D/DroidGap(10366): onMessage(onPageFinished,file:///android_asset/www/index.html)
    
## Error grave de seguridad:
    
    D/CordovaLog(14348): current id=login
    D/CordovaLog(14348): {"Input":{"appId": "LAFISE_MB","nickName": "","userId": "paulomcnally","mechanism": "AUTH_PASS","channel": "MB","bankId": "LAFISE","params":[{"name": "COUNTRY","value": "NI"},{"name": "CHANNEL","value": "MB"},{"name":"DATETIME","value": "2013-09-01T22:42:33"},{"name":"PASSWORD","value": "123456789"},{"name":"DEVICETYPE","value": "Mozilla/5.0 (Linux; U; Android 4.0.4; en-us; GT-P7300 Build/IMM76D) AppleWebKit/534.30 (KHTML, like Gecko) Version/4.0 Safari/534.30"},{"name":"DEVICEOS","value": "Linux armv7l"}]}}
    D/CordovaLog(14348): Webservice URL: https://lafisemovil.com/cb/mbanking/services/authenticate

![Error Password App Lafise](http://i.imgur.com/VcOwdZ9.png)

Se esta enviando en texto plano nuestra contraseña, como podran ver en el **value** del **name** **PASSWORD** se puede leer claramente la contraseña que yo estoy enviando en el formulario que es **123456789**. Esto es claramente un error **GRAVE** que no puede ser aceptado en una aplicación de un banco, se esta exponiendo nuestros datos.

Esto es muy fácil de obtener desde una consola escribiendo el comando:
    
    adb shell logcat | grep -E "CordovaLog"

Lo recomendado es que el password fuera encriptado y enviado, en el Web Service desencriptado y validado.

## Pero cómo podría ser explotada esa vulnerabilidad?
Se puede desarrollar un app espía que sea tentativa para los usuarios como por ejemplo "Entradas al cine gratis", que la aplicación tuviera una maquina donde el usuario intenta ganar entradas al cine, pero realmente esta leería el log de la aplicación de Lafise para obtener usuario y contraseña y así poder enviarlos a un servidor remoto para luego poder usar las credenciales y hacer delítos electrónicos o bien se desarrolla una segunda aplicación que este transfiriendo fondos de forma automática, para eso se podrían crear varias cuentas en Banco Lafise con personas ingenuas y usarlas para sacar el dinero y en caso de que la policía de con esta persona ya haber desaparecido. Quizás lo vean como película pero en estados unidos y mexico son comunes.

Lamentablemente no tengo una cuenta en Lafise para saber que datos retorna la autenticación válida y donde almacena estos datos, pero seguire analizando la aplicación.

**Nota:** Para crear un app espía que lea el log no se requiere root en el dispositivo Android.

Ver video en youtube: [http://www.youtube.com/watch?v=veE4ZvMqc-Y](http://www.youtube.com/watch?v=veE4ZvMqc-Y)

Dejen sus comentarios si tienen preguntas :)

Saludos
