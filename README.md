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


# Basic structure of the application

Each quiz has many topics, each topic has many questions and each question has many options.


![image](https://user-images.githubusercontent.com/79910258/112475069-d647d580-8d89-11eb-8ec6-4b534a32dc43.png)
![image](https://user-images.githubusercontent.com/79910258/112475105-e069d400-8d89-11eb-9563-41bd6aa6954a.png)
![image](https://user-images.githubusercontent.com/79910258/112475156-efe91d00-8d89-11eb-8443-4b0355d8b3a3.png)
![image](https://user-images.githubusercontent.com/79910258/112475187-f8d9ee80-8d89-11eb-8e2e-26ca9391cdfe.png)
![image](https://user-images.githubusercontent.com/79910258/112475222-01cac000-8d8a-11eb-8e9f-8b0e56608dcd.png)
![image](https://user-images.githubusercontent.com/79910258/112475259-0b542800-8d8a-11eb-964b-2bb22d8a4b3b.png)
![image](https://user-images.githubusercontent.com/79910258/112475282-1313cc80-8d8a-11eb-8774-76a8cf62de14.png)
![image](https://user-images.githubusercontent.com/79910258/112475354-2aeb5080-8d8a-11eb-8d87-24d57b0d4b54.png)
![image](https://user-images.githubusercontent.com/79910258/112475410-3b033000-8d8a-11eb-818d-149d5a6c65d6.png)
![image](https://user-images.githubusercontent.com/79910258/112475528-566e3b00-8d8a-11eb-9820-8cfbde32b89e.png)
![Screenshot_1616879658](https://user-images.githubusercontent.com/79910258/112735047-039bab80-8f63-11eb-9efb-372339668605.png)
![Screenshot_1616879681](https://user-images.githubusercontent.com/79910258/112735050-05fe0580-8f63-11eb-93c4-9dc2e795e09f.png)










