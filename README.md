# AppEmotions

> Tu compañero emocional en el bolsillo. Aprende, vive y gestiona tus emociones de forma consciente.

<p align="center">
  <img src="AppEmotions/Assets.xcassets/AppIcon.appiconset/LogoApp.png" width="120" alt="AppEmotions Logo">
</p>

## 📱 Descripción

**AppEmotions** es una aplicación de salud mental diseñada para ayudarte a comprender, experimentar y gestionar tus emociones de manera saludable. A través de actividades guiada y auto-reflexión, podrás desarrollar mayor inteligencia emocional.

## ✨ Características

### 🌈 Catálogo de Emociones

Explora las 5 emociones básicas:

* **Alegría** - La emoción del bienestar y la satisfacción

* **Tristeza** - La emoción de la pérdida y la conexión

* **Miedo** - La emoción de la protección y la alerta

* **Ira** - La emoción de la energía y los límites

* **Asco** - La emoción del rechazo y la protección

### 📊 Dashboard Personal

* Seguimiento de progreso diario con objetivos claros

* Gráfica de accesos durante los últimos 14 días

* Mensajes motivacionales personalizados según tu avance

### 🧠 Actividades de cada Emoción

Cada emoción incluye 3 pestañas de trabajo:

1. **Entiendela** - Aprende qué es la emoción, cómo se manifiesta y su propósito
2. **Vívela** - Dos actividades prácticas:

   * **Analiza** - Reflexiona sobre tus pensamientos cuando experimentas la emoción

   * **Medita** - Audio de meditación para conectar con la emoción

   * **Respira** - Contador para respiraciones guiadas
3. **Gestiónala** - Registra y comprende cómo manejas cada emoción

### 📝 Registro de Malestar

Herramienta de auto-observación que te permite documentar:

* Situación y contexto

* Pensamientos asociados

* Emociones experimentadas

* Conducta resultante

* Nivel de malestar (1-10)

### ⚖️ Pros y Contras

Herramienta de análisis cognitivo para evaluar situaciones:

* Registra la situación que te preocupa

* Analiza pros y contras de forma guiada

* Visualiza el historial por emoción

### 🌬️ Respiración Guiada

Técnicas de respiración para calmar la ansiedad:

* 4-2-6 (Inhalar 4s, Mantener 2s, Exhalar 6s)

* 4-2-6-2 (Inhalar 4s, Mantener 2s, Exhalar 6s, Mantener 2s)

* Círculo animado que guía visualmente

* Vibración al cambiar de fase

* Contador de repeticiones

### 🎮 Gamificación

Sistema de progreso diario con:

* Avatar evolutivo que cambia según tu actividad

* 4 objetivos diarios: explorar, analizar, meditar y acceder al dashboard

* Animaciones de celebración al completar tareas

* Mensajes motivacionales personalizados

## 🛠️ Tecnología

* **SwiftUI** - Interfaz de usuario moderna y declarativa

* **Firebase** - Backend como servicio

  * **Firestore** - Base de datos en la nube

  * **Authentication** - Sistema de login/registro

* **AVFoundation** - Reproducción de audio para meditaciones

* **Swift Charts** - Visualización de datos de progreso

## 📁 Estructura del Proyecto

```
AppEmotions/
├── AppEmotionsApp.swift           # Punto de entrada
├── ContentView.swift              # Vista raíz (auth/main)
├── Assets.xcassets/               # Imágenes y recursos
├── Components/                    # Componentes reutilizables
│   ├── AvatarFlotante.swift      # Avatar gamificado
│   ├── AvatarPickerView.swift     # Selector de avatar
│   └── EmocionGestionala.swift    # Gestión emocional
├── Models/                        # Modelos de datos
│   ├── Emocion.swift
│   ├── Registro.swift
│   ├── Respuesta.swift
│   └── ProsContras.swift          # Análisis pros/contras
├── ViewModels/                    # Lógica de negocio
│   ├── DailyStatsViewModel.swift
│   ├── EmocionesViewModel.swift
│   ├── LoginViewModel.swift
│   └── ProsContrasViewModel.swift
├── Views/                         # Vistas principales
│   ├── VistaDashboard.swift
│   ├── VistaEmotionSingle.swift
│   ├── VistaMain.swift
│   └── VistaListaProsContras.swift
└── ViewSheets/                    # Hojas modales
    ├── VistaAnaliza.swift
    ├── VistaMedita.swift
    ├── VistaRespira.swift         # Respiración guiada
    ├── VistaProContra.swift
    └── VistaRegistroMalestar.swift
```

## 🚀 Instalación

1. **Clonar el repositorio:**

   ```bash
   git clone https://github.com/hamil17/AppEmotions.git
   ```

2. **Configurar Firebase:**

   * Crear un proyecto en [Firebase Console](https://console.firebase.google.com)

   * Añadir una app iOS con el bundle ID de tu proyecto

   * Descargar `GoogleService-Info.plist` y añadirlo al proyecto

   * Habilitar **Authentication** (Email/Password)

   * Crear colección **Emociones** con los 5 documentos base

3. **Estructura de la colección Emociones:**

   ```json
   {
     "nombre": "Alegría",
     "descripcion": "Descripción de la emoción...",
     "color": "#colorhex",
     "image": "Alegria",
     "sonido": "https://url-audio.com/audio.mp3"
   }
   ```

4. **Abrir en Xcode:**

   ```bash
   open AppEmotions.xcodeproj
   ```

5. **Ejecutar** en el simulador o dispositivo real

## 🎯 Objetivos de Aprendizaje

La app está diseñada para ayudarte a:

* ✅ **Reconocer** emociones en tiempo real

* ✅ **Comprender** qué provoca cada emoción

* ✅ **Identificar** patrones en tus respuestas emocionales

* ✅ **Desarrollar** estrategias saludables de gestión

* ✅ **Practicar** técnicas de meditación y mindfulness

* ✅ **Reflexionar** sobre tu vida emocional

* ✅ **Regular** tu respiración para calmar la ansiedad

* ✅ **Analizar** situaciones desde múltiples perspectivas

## 🔒 Privacidad

* Todos los datos se almacenan de forma segura en Firebase Firestore

* Cada usuario solo puede acceder a sus propios registros

* No se comparte información personal con terceros

## 👥 Equipo

Desarrollado con ❤️ por **HamDsgn**
<img src="AppEmotions/Assets.xcassets/hamdsgn.imageset/hamdsgn.png" width="60" alt="HamDsgn">

## 📄 Licencia

Este proyecto es para uso educativo y de demostración.

***

*Tu bienestar emocional merece atención. Cada día es una oportunidad para conocerte mejor.* 🌱
