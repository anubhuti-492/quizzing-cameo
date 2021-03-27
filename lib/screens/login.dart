import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:quizapp/services/auth.dart';
import '../services/services.dart';
import 'package:apple_sign_in/apple_sign_in.dart';

class LoginScreen extends StatefulWidget {
  createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {
  AuthService auth = AuthService();

  @override
  void initState() {
    super.initState();
    auth.getUser.then(
          (user) {
        if (user != null) {
          Navigator.pushReplacementNamed(context, '/topics');
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(30),
      //  decoration: BoxDecoration(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            FlutterLogo(
              size: 150,
            ),
           //SizedBox(height: 15),
            Text(
              'Login to Start',
              style: Theme.of(context).textTheme.headline5,
              textAlign: TextAlign.center,
            ),
            Text('Your Tagline'),
            LoginButton(
              text: 'LOGIN WITH GOOGLE',
              icon: FontAwesomeIcons.google,
              color: Colors.black45,
              loginMethod: auth.googleSignIn,
            ),
            LoginButton(text: 'Continue as Guest', loginMethod: auth.anonLogin)
          ],
        ),
      ),
    );
  }
}

class LoginButton extends StatelessWidget {
  final Color color;
  final IconData icon;
  final String text;
  final Function loginMethod;

  const LoginButton(
      {Key key, this.text, this.icon, this.color, this.loginMethod})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // ignore: deprecated_member_use
      child: FlatButton.icon(
        padding: EdgeInsets.all(30),
        icon: Icon(icon, color: Colors.white),
        color: color,
        onPressed: () async {
          var user = await loginMethod();
          if (user != null) {
            Navigator.pushReplacementNamed(context, '/topics');
          }
        },
        label: Expanded(
          child: Text('$text', textAlign: TextAlign.center),
        ),
      ),
    );
  }
}
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:quizapp/services/auth.dart';
// import 'package:quizapp/shared/bottom_nav.dart';
//
// class LoginScreen extends StatefulWidget {
//   @override
//   _LoginScreenState createState() => _LoginScreenState();
// }
//
// class _LoginScreenState extends State<LoginScreen> {
//  // AuthService authService
//   AuthService _authService = new AuthService();
//
//   @override
//   void initState() {
//     super.initState();
//     _authService.getUser.then(
//           (user) {
//         if (user != null) {
//           print("A user has logged in "+ user.displayName);
//           Navigator.pushReplacementNamed(context, '/topics');
//         }
//       },
//     );
//   }
//   @override
//   Widget build(BuildContext context) {
//     return new Scaffold(
//    //   bottomNavigationBar: AppBottomNav(),
//       body: Padding(
//
//         padding: const EdgeInsets.all(80.0),
//         child: Column(
//             children: <Widget>[
//               SizedBox(height: 250,),
//               Center(
//                 child: LoginButton(
//                   text: "sign in with a google account",
//                   loginMethod: _authService.googleSignIn,
//                 ),
//               ),
//               LoginButton(
//                 text: "Continue as a guest",
//                 loginMethod: _authService.anonLogin,
//               ),
//             ]
//         ),
//       ),
//     );
//   }
//
// }
//
// class LoginButton extends StatelessWidget {
//    final String text;
//    final Function loginMethod;
//    const LoginButton(
//        {Key key, this.text, this.loginMethod})
//        : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return ElevatedButton(
//         child: Text(
//             text,
//         ),
//         onPressed: () async {
//           print("button has been pressed");
//           var user = await loginMethod();
//           if(user!=null){
//             print("a user has been logged in. text = $text");
//             Navigator.pushReplacementNamed(context, '/topics');
//           }
//         }
//     );
//   }
// }
//
//
