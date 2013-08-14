[Failed to install .apk on device '': timeout](/articulo/failed-to-install-apk-on-device-timeout)
=================================================================================================

![Failed to install .apk on device '': timeout](http://i.imgur.com/QS2fS1f.png)

Este molesto error se muestra cuando no se logra reconocer el dispositivo en 5 segundos (valor por defecto de [Android Developer Tools](http://developer.android.com/sdk/index.html)).

Esto me pasa por que no estoy usando el cable USB original de mi dispositivo.

La solución  es cuestión de agregar mas tiempo para mostrar el mensaje de timeout, asi habra tiempo suficiente para que el adb reconozca el dispositivo.

    Window -> Preferences -> Android -> DDMS -> ADB Connection Timeout (ms)

El valor podria ser reemplazado por 30000
![ADT Settings](http://i.imgur.com/ZHu0G7O.png)


Con esto se soluciona el problema de timeout. :)