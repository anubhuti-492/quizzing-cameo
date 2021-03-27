import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:provider/provider.dart';
import 'package:quizapp/services/auth.dart';
import 'screens/screens.dart';
import 'services/services.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
      return MultiProvider(
        /*
          This library is a google recommended solution for effectively
          managing state managament in Flutter apps.
          This will actively listen for streams. Whenever a user signs in,
          a firebase user will be returned. When a user signs out,
          a null value will be returned.
         */
        providers: [
          StreamProvider<Report>.value(value: Global.reportRef.documentStream),
          StreamProvider<FirebaseUser>.value(value: AuthService().user
          )
        ],
        child: MaterialApp(
          // Firebase Analytics

          navigatorObservers: [
            FirebaseAnalyticsObserver(analytics: FirebaseAnalytics()),
          ],

          // Named Routes
          routes: {
            '/': (context) => LoginScreen(),
            '/topics': (context) => TopicsScreen(),
            '/profile': (context) => ProfileScreen(),
            '/about': (context) => AboutScreen(),
          },
          // Theme
          theme: ThemeData(
            fontFamily: 'Nunito',
            bottomAppBarTheme: BottomAppBarTheme(
              color: Colors.black87,
            ),
            brightness: Brightness.dark,
            textTheme: TextTheme(
              bodyText2: TextStyle(fontSize: 18),
              bodyText1: TextStyle(fontSize: 16),
              button: TextStyle(letterSpacing: 1.5, fontWeight: FontWeight.bold),
              headline5: TextStyle(fontWeight: FontWeight.bold),
              subtitle1: TextStyle(color: Colors.grey),
            ),
            buttonTheme: ButtonThemeData(),
          ),

         // home: new Scaffold(
         //      appBar:AppBar(
         //
         //      ),
         // ),
        ),
      );
    //);
  }
}
