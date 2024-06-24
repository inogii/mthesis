# Breve introducción teórica de conceptos

## Modelos de difusión

Tenemos un conjunto de datos reales (imágenes, audios...) con una distribución de probabilidad desconocida. Nuestro objetivo es crear nuevas muestras que se asemejen a las existentes en nuestro conjunto de datos. Para ello, aprendemos un proceso de difusión que genera una distribución de probabilidad de una forma conocida (por ejemplo una gaussiana). Una vez tenemos esa distribución, podemos muestrear de ella muestras de ruido, y mediante el proceso de denoising aprendido, generamos nuevas muestras que se asemejan a las de nuestro conjunto de datos inicial (imágenes, audios...). 

Visto de forma simple, funciona en 3 pasos fundamentales: 

1. **Difusión hacia el ruido**: Comienzas con datos reales (por ejemplo, imágenes) que tienen una distribución de probabilidad desconocida. El modelo de difusión realiza un proceso en el cual estos datos se van corrompiendo gradualmente hasta que se convierten en puro ruido, siguiendo una trayectoria conocida y controlada (usualmente ruido gaussiano). Esto se hace añadiendo ruido a los datos originales en una serie de pasos.
    
2. **Aprendizaje del modelo**: Durante el entrenamiento, el modelo aprende cómo revertir este proceso de ruido. Es decir, el modelo aprende a recuperar los datos originales a partir de los datos ruidosos. Este proceso se denomina "denoising".
    
3. **Generación de nuevas muestras**: Una vez entrenado, el modelo puede iniciar con una muestra de ruido (tomada de la distribución de ruido conocida, como la gaussiana) y aplicar el proceso inverso (denoising) para generar una nueva muestra. Durante este proceso, el modelo elimina gradualmente el ruido de la muestra en múltiples pasos, guiado por las reglas aprendidas durante el entrenamiento, hasta generar una nueva muestra que se asemeja a las originales del conjunto de datos.

Ahora, esto no es útil por si solo, ya que normalmente queremos generar muestras más específicas. Por ejemplo, dado un conjunto de imágenes de todo tipo, incluyendo animales, podríamos querer generar nuevas imágenes de un ratón eléctrico amarillo con un sombrero de fiesta en estilo de caricatura japonesa.

### Modelos de difusión condicional

En un modelo de difusión estándar, las muestras se generan sin ninguna especificación sobre cómo deberían ser más allá de parecerse a las que están en el conjunto de datos. En cambio, en un modelo de difusión condicional, el proceso de generación se condiciona a información adicional. Esto permite guiar el modelo para que produzca resultados que no solo son realistas, sino también alineados con requisitos o preferencias específicas.

#### Implementación Técnica

La condición puede ser implementada de varias formas:

1. **Incorporación Directa en la Red**: Puedes incorporar la condición directamente en la arquitectura de la red neuronal del modelo. Por ejemplo, si el modelo está generando imágenes y la condición es un texto que describe la imagen deseada (como en un modelo de texto a imagen), el texto puede ser codificado y fusionado con las capas del modelo que están aprendiendo a revertir el proceso de difusión.
    
2. **Modificación del Proceso de Difusión**: Otra opción es modificar las etapas del proceso de difusión en sí para que dependan de la condición. Esto puede implicar ajustar cómo se añade el ruido o cómo se realiza el proceso de denoising basándose en la información de la condición.
    
3. **Uso de la Condición en Cada Paso del Denoising**: Durante el proceso inverso de denoising, la condición puede ser aplicada repetidamente en cada paso, asegurando que la muestra generada se ajuste cada vez más a lo especificado por la condición.

### Modelos de difusión latente

### Modelos de difusión latente

Los modelos de difusión latente representan una variante avanzada de los modelos de difusión, donde en lugar de trabajar directamente con los datos de alta dimensión (como imágenes o audios completos), el proceso de difusión se aplica a una representación latente de los datos. Esta representación latente es una forma comprimida de los datos originales, capturando las características esenciales mientras reduce la complejidad computacional del modelo. Este enfoque ofrece varias ventajas, incluyendo mayor eficiencia y flexibilidad en la generación de muestras.

#### Características Principales

1. **Reducción de Dimensionalidad**: Al trabajar con representaciones latentes, el modelo maneja una cantidad menor de información en cada paso, lo que puede llevar a un entrenamiento más rápido y a una menor demanda de recursos computacionales.
    
2. **Aprendizaje de Características Esenciales**: Las representaciones latentes suelen aprenderse a través de modelos autoencoder, que se entrenan para capturar las características más importantes de los datos. Esto permite que el proceso de difusión se centre en aspectos cruciales de los datos, potencialmente mejorando la calidad de las muestras generadas.

3. **Integración con Otras Técnicas de Aprendizaje Profundo**: Los modelos de difusión latente pueden combinarse fácilmente con otras técnicas de aprendizaje profundo, como las redes generativas adversarias (GAN) o los modelos de atención, para mejorar aún más la calidad y la relevancia de las muestras generadas.

#### Implementación Técnica

1. **Pre-entrenamiento de Autoencoders**: Antes de aplicar el modelo de difusión, se entrena un autoencoder para obtener la representación latente de los datos. Este modelo es crítico, ya que define cómo se representarán y manipularán los datos durante el proceso de difusión.

2. **Aplicación del Proceso de Difusión a las Latentes**: Una vez obtenida la representación latente, se aplica el proceso de difusión a esta en lugar de a los datos originales. Esto puede incluir la adición controlada de ruido y el posterior aprendizaje de un proceso de denoising específico para estas representaciones.

3. **Regeneración de Datos Complejos a Partir de Latentes**: Después de revertir la difusión en el espacio latente, los datos latentes "limpios" se pasan a través del decodificador del autoencoder para reconstruir los datos originales o generar nuevas variantes basadas en estas representaciones limpias.


