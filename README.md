# Probabilidad de Error en PCM

Este repositorio contiene una simulación en MATLAB para evaluar la probabilidad de error alcanzada por PCM (Modulación por Codificación de Pulso). El código fue desarrollado como parte de un proyecto para la asignatura de Comunicaciones Digitales.

## Autores
- Flores Andres
- Gomez Franklin
- Otavalo David
- Zaruma Samantha

## Descripción

El código en MATLAB implementa los bloques necesarios para simular el proceso de transmisión y recepción de señales PCM. A continuación, se describen las principales etapas del proceso:

1. Se solicita al usuario ingresar el número de bits a generar y la amplitud de la señal.
2. Se generan los bits codificados aleatoriamente y se asigna la amplitud correspondiente a cada uno.
3. Se establece el tiempo de duración de cada bit y se calcula la tasa de transmisión.
4. Se genera un vector de tiempos para graficar las señales.
5. Se representan los bits y la señal codificada en el tiempo, utilizando la señalización P-NRZ.
6. Se realiza el muestreo de la señal codificada para obtener una versión discreta de la misma.
7. Se agrega ruido gaussiano a la señal muestreada, variando el nivel de SNR en cada iteración del bucle.
8. Se reconstruye la señal filtrando y comparando con un umbral establecido.
9. Se calcula la cantidad de errores de bits entre la señal original y la señal reconstruida.
10. Se calcula la probabilidad de error (BER) tanto de forma experimental como teórica para cada nivel de SNR.
11. Se grafican las diferentes etapas del proceso, incluyendo las señales originales, codificadas, con ruido, filtradas y reconstruidas.
12. Se grafica la BER en función del SNR, comparando los resultados experimentales y teóricos.

## Requisitos
- MATLAB (versión 2017 o superior) o un lenguaje de programación compatible.

## Instrucciones de uso
1. Clona este repositorio en tu máquina local.
2. Abre el archivo MATLAB y ejecuta el código.
3. Sigue las instrucciones en la ventana de comandos para ingresar el número de bits y la amplitud de la señal.
4. Observa los resultados y las gráficas generadas.

Esperamos que esta simulación sea útil para comprender y analizar la probabilidad de error en PCM. Si tienes alguna pregunta o sugerencia, no dudes en contactarnos.

**Nota:** Actaulmente el código solo funciona correctamente con un tiempo de bit de 1 segundo
