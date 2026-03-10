# Student Records Management System

<div align="center">
  <img src="https://img.shields.io/badge/Flutter-02569B?style=for-the-badge&logo=flutter&logoColor=white" />
  <img src="https://img.shields.io/badge/Dart-0175C2?style=for-the-badge&logo=dart&logoColor=white" />
  <img src="https://img.shields.io/badge/Firebase-FFCA28?style=for-the-badge&logo=firebase&logoColor=white" />
</div>

<br>

**Developed By:** Sharangi Gallage  

A functional, modern, and cross-platform mobile application that allows administrators to seamlessly manage student records. Powered by a real-time **Firebase Cloud Firestore** backend, ensuring that any changes made within the application are instantly synchronized and reflected in the database.

---

## 📱 Features & Core Functional Requirements (CRUD)

This application successfully implements the four foundational CRUD operations:

* **CREATE**: A beautifully designed `CreateScreen` form allowing the addition of new students. Collects details such as Full Name, Student ID, and Degree Program. Once submitted, it saves the data into Firestore and presents an animated success pop-up.
* **READ**: A `ReadScreen` dashboard featuring a dynamic, real-time `StreamBuilder`. This lists all student records fetched from the Firebase database in modern styled cards. Since it uses streams, the UI updates instantly without requiring a refresh.
* **UPDATE**: Users can seamlessly modify existing student details via the `UpdateScreen`. Selecting a student populates a form with their current details, allowing real-time edits to the database.
* **DELETE**: A dedicated `DeleteScreen` providing a mechanism to permanently remove a student record from the Firestore database using their unique Student ID.


---

## 🎨 UI/UX Enhancements

This project goes beyond functional requirements by implementing a highly attractive, premium user interface!

* **Dynamic Theming:** Each administrative screen is color-coordinated (Create = Blue, Read = Teal, Update = Orange, Delete = Red) featuring smooth linear gradients.
* **Modern Material 3 Elements:** Utilizes deep shadows, rounded corners, beautiful icons, and distinct card-based layouts for rendering student data.
* **Interactive Feedback:** 
  * Animated **Custom SnackBars** displaying Success and Error popups.
  * **Loading Spinners** that activate during communication with Firebase, preventing multiple simultaneous submissions.

---

## 🛠️ Technology Stack & Architecture

* **Framework**: Flutter (SDK: >=3.0.0 <4.0.0)
* **Backend**: Firebase / Cloud Firestore
* **Key Dependencies**:
  * `firebase_core` (^2.24.2)
  * `cloud_firestore` (^4.13.6)

### Project Structure Breakdown

```text
lib/
├── models/
│   └── student.dart             # Defines the Student data model & Map conversion
├── screens/
│   ├── home_screen.dart         # Scaffold with BottomNavigationBar orchestration
│   ├── create_screen.dart       # Form UI to ADD records
│   ├── read_screen.dart         # ListView UI to FETCH & DISPLAY records
│   ├── update_screen.dart       # Form UI to EDIT records
│   └── delete_screen.dart       # Form UI to REMOVE records
├── services/
│   └── firestore_service.dart   # Abstracts all direct database logic
├── utils/
│   └── custom_snackbar.dart     # Custom Success & Error UI notifications
├── firebase_options.dart        # Auto-generated Firebase cross-platform configuration
└── main.dart                    # Application Entry Point & Firebase Initialization
```

---

## 🚀 How to Run Locally

### Requirements
* Flutter SDK (Version 3.41.0+)
* An active Firebase Project with Cloud Firestore enabled (Test Mode)

### Instructions
1. Clone the repository and navigate to the project directory.
2. Ensure you have the Flutter SDK configured. Run `flutter doctor` to verify.
3. Install the required Dart packages:
   ```bash
   flutter pub get
   ```
4. Build and run the project (Android, iOS, or Chrome):
   ```bash
   flutter run
   ```

*(Note: Web configurations are actively defined in `firebase_options.dart`. Update the Web App ID if changing Firebase projects)*
