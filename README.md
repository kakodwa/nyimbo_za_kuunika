# Nyimbo za Kuunika

A dedicated offline hymn book Flutter application for the **Zambezi Evangelical Church (Mitsidi Synod)**. This app provides easy access to all 122 hymns, choruses (*Makorasi Olemekeza* & *Makorasi Opembedza*), dark mode support, quick search functionality, and audio recording/playback features for personal devotions and church services.

---

## 🌟 Features

* **Complete Hymnal**: Full hymn texts (1–122) and both sections of choruses (*Olemekeza* & *Opembedza*).
* **Offline Access**: Complete functionality without requiring an active internet connection.
* **Search & Filter**: Search hymns instantly by hymn number or song title.
* **Favorites**: Save favorite hymns for quick access during service or choir practice.
* **Dark Mode Support**: Seamless toggle between light and dark themes using `provider`.
* **Audio Recording & Playback**: Record tune practice or singing sessions locally on your device using `record` and `audioplayers`.
* **Screen Keep-Awake**: Prevents the screen from dimming while reading or singing using `wakelock_plus`.

---

## 📱 Tech Stack & Dependencies

* **Framework**: [Flutter](https://flutter.dev/) (SDK ^3.11.5)
* **State Management**: `provider` (^6.0.5)
* **Local Storage**: `shared_preferences` (^2.2.2)
* **Audio Handling**: `record` (^5.2.0) & `audioplayers` (^5.2.1)
* **File Management**: `path_provider` (^2.1.0)
* **Utility**: `wakelock_plus` (^1.1.4)
* **App Launcher Icons**: `flutter_launcher_icons` (^0.13.1)

---

## 🚀 Getting Started

### Prerequisites

Ensure you have the Flutter SDK installed on your machine.
```bash
flutter --version