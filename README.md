# 🚀 Flutter Firebase Auth App

A secure Flutter authentication system integrated with Firebase Authentication and Cloud Firestore. The app focuses on user registration, login validation, and profile management with proper field validation and clean UI architecture.

---

## 🎯 Project Overview

This Flutter Firebase Auth App allows users to create an account using their full name, email, and password. The credentials are securely stored using Firebase Authentication, while additional user details are saved in Cloud Firestore.

During login, user credentials are validated against Firebase Authentication. If the credentials are correct, the user is navigated to the Profile Screen; otherwise, appropriate error messages are displayed.

The Profile Screen dynamically fetches and displays the authenticated user's full name and email.

The app also includes proper form validations for all input fields, ensuring clean and secure data handling.

---

## 🚀 Features

- User Signup with full name, email, and password
- Firebase Authentication integration
- Store user details in Cloud Firestore
- Secure login with credential verification
- Error handling for invalid login attempts
- Form validation for:
  - Email format validation
  - Password strength validation
  - Full name validation
- Profile screen displaying user information
- Clean navigation flow (Signup → Login → Profile)
- Responsive and user-friendly UI
- Centralized app color management

---

## 📸 Screenshots

### 📝 Signup Page

<img src="screenshots/Signup Page.jpg" width="250"/>

> User registration screen where users enter full name, email, and password to create a new account.

---

### ⚠️ Signup Page Validator

<img src="screenshots/Signup Page Validator.jpg" width="250"/>

> Displays validation errors when required fields are left empty or not properly filled.

---

### 📧 Signup Page Format Validation

<img src="screenshots/Signup Page Format Validation.jpg" width="250"/>

> Ensures proper input format validation for email and password before allowing user registration.

---

### 💾 Saving to Firestore

<img src="screenshots/Saving to Firestore.jpg" width="250"/>

> Shows successful storage of user data in Firebase Cloud Firestore after registration.

---

### 🔐 Login Page

<img src="screenshots/Login Page.jpg" width="250"/>

> Login screen where users enter their registered email and password to access the app.

---

### ⚠️ Login Page Validator

<img src="screenshots/Login Page Validator.jpg" width="250"/>

> Displays validation errors when login fields are empty or incorrectly filled.

---

### ❌ Incorrect Credentials

<img src="screenshots/Incorrect Credentials.jpg" width="250"/>

> Shows error message when user enters invalid email or password that does not match Firebase records.

---

### 👤 Profile Page

<img src="screenshots/Profile Page.jpg" width="250"/>

> Displays authenticated user information including full name and email fetched from Firestore.

## 🛠️ Tech Stack

- Flutter  
- Dart  
- Firebase Authentication  
- Cloud Firestore  
- Material Design  

---

## ⚙️ Functional Flow

1. User opens the app (`main.dart` initializes Firebase)
2. User navigates to Signup Screen
3. User enters:
   - Full Name  
   - Email  
   - Password  
4. Input fields are validated locally
5. Firebase Authentication creates user account
6. User data is stored in Cloud Firestore
7. User navigates to Login Screen
8. Login credentials are verified via Firebase Auth
9. On success → Navigate to Profile Screen
10. On failure → Error message is shown
11. Profile screen fetches user data from Firestore and displays it

---

## 🧠 Key Concepts Used

- Firebase Authentication (Email/Password)
- Cloud Firestore CRUD operations
- Form validation using Flutter Forms
- Error handling for authentication failures
- Navigation between multiple screens
- Separation of UI and logic
- Centralized theme management via app colors
- Async programming with Firebase APIs

---

## 🏗️ Architecture Overview

### Authentication Flow Design

- Firebase Auth handles secure login/signup
- Firestore stores additional user metadata (full name, email)
- UI layer remains decoupled from authentication logic

### Before
- Local-only validation and no persistence

### After
- Firebase-based authentication system
- Persistent cloud storage with Firestore
- Real-time user data retrieval

---

## 📂 Project Structure

```text
lib/
├── main.dart
├── firebase_options.dart
├── screens/
│ ├── signup_screen.dart
│ ├── login_screen.dart
│ └── profile_screen.dart
└── utils/
    └── app_colors.dart
```

---

## 📱 How to Run

Clone the repository:

```bash
git clone https://github.com/umarjawad123/Flutter_firebase_auth_app.git
```

Navigate to project:

```bash
cd Flutter_firebase_auth_app
```

Install dependencies:

```bash
flutter pub get
```

Run the app:

```bash
flutter run
```

---

## 🎯 Future Improvements

- Add Google Sign-In authentication
- Add password reset functionality
- Implement email verification
- Add Firebase Security Rules
- Improve UI with animations
- Add Remember Me / Session persistence
- Introduce Riverpod for state management 

---

## 👨‍💻 Author

**Umar Jawad**

Flutter Developer | BSCS Student
