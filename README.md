# 🎭 Bear Login Animation with Rive

A simple Flutter app that showcases a playful login screen powered by a Rive State Machine. The character reacts to user focus, typing, and login results with smooth success and failure animations, like a cute bear interacting with the screen. 🚀

---

## ✨ Features
- 👀 Character looks at your typing (eye/face tracking via `numLook`).
- ⌨️ Hands up when focusing the password field (`isHandsUp`).
- 🔎 Checking/idle states while validating (`isChecking`).
- ✅ Success animation on valid credentials (`trigSuccess`).
- ❌ Failure animation on invalid credentials (`trigFail`).

---

## 🧩 What is Rive? What is a State Machine?
- Rive is a real-time, interactive animation tool for apps and games. It lets designers and developers create and ship lightweight, runtime animations that respond to user input.
- A Rive State Machine defines animation states (e.g., idle, checking, success, fail) and how to transition between them using inputs (booleans, numbers, triggers). In this app we use:
  - `isChecking` (Bool)
  - `isHandsUp` (Bool)
  - `numLook` (Number)
  - `trigSuccess` (Trigger)
  - `trigFail` (Trigger)

---

## 🛠️ Tech Stack
- Flutter
- Dart
- Rive (Flutter runtime)

---

## 📁 Project Structure (lib)
```
lib/
├─ main.dart
└─ screens/
   └─ login_screen.dart
```

- `main.dart`: App entry point.
- `login_screen.dart`: UI + Rive integration + State Machine wiring.

---

## 🧠 How it works (quick)
- Focus email → `isChecking = true`, character looks at text via `numLook`.
- Focus password → `isHandsUp = true` to cover eyes.
- Tap Login → simulate validation:
  - On success → fire `trigSuccess`.
  - On fail → fire `trigFail`.

Inputs must match exactly the names in your `.riv` file.

---

## 🎬 Demo
Add a GIF that shows the full flow (typing, focus changes, success and fail):

![Demo](assets/BearExample)

Tip: Place your GIF at `docs/demo.gif`. You can record with tools like ScreenToGif (Windows).

---

## 📚 Course
- Course: [Replace with course name]
- Instructor: [Replace with instructor name]

---

## 🙌 Credits
- Animation by: Ruksar Ahmed — [Link to the original animation](https://rive.app/marketplace/3645-7621-remix-of-login-machine/)
- Rive: https://rive.app/

---