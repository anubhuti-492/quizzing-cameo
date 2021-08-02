# quizapp

A new Flutter application.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://flutter.dev/docs/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://flutter.dev/docs/cookbook)

For help getting started with Flutter, view our
[online documentation](https://flutter.dev/docs), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

# quizzing-cameo

# About the Project
This is a complete Flutter application developed in order to allow users to take quizzes on various topics and track their progress.

The app implements user authentication (Sign in with Google or Sign in as guest), tracks quiz progress in Firestore, runs animations, and shares data between screens.

# Technolody used

1. Framework: Flutter
2. Backend: Firebase 
3. IDE: Android Studio
4. Language: Dart

# The backend service used in this project and relevant information

1. Uses Firestore database for the database model. This database model was imported in the database using a Node.js script.
2. The database has 3 main collections: Quizzes, Topics and Reports.

Quizzes and the Topics collection data should not be altered by the user.

# Security rules enforced in the database
![image](https://user-images.githubusercontent.com/79910258/112474759-72251180-8d89-11eb-9fda-06099ff9601b.png)

# The datamodel 
![image](https://user-images.githubusercontent.com/79910258/112771504-49c53d80-903d-11eb-808d-a13dc4418dde.png)

# Basic structure of the application

Each quiz has many topics, each topic has many questions and each question has many options.


![image](https://user-images.githubusercontent.com/79910258/112475069-d647d580-8d89-11eb-8ec6-4b534a32dc43.png)


