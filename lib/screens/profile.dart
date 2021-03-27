import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:quizapp/screens/anon.dart';
import 'package:quizapp/screens/known_user.dart';
import 'package:quizapp/services/auth.dart';
import 'package:quizapp/shared/loader.dart';
import '../services/services.dart';
import '../shared/shared.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatelessWidget {
  final AuthService auth = AuthService();
  @override
  Widget build(BuildContext context) {
    FirebaseUser user = Provider.of<FirebaseUser>(context);
      if(user!=null){
          if(user.isAnonymous){
              return AnonProfile();
          } else return UserProfile();
      } else {
        return Scaffold(
          appBar: AppBar(
            title: Text("NULL PAGE")
            ,),
        );
      }
  }
}

// class ProfileScreen extends StatelessWidget {
//   final AuthService auth = AuthService();
//
//   @override
//   Widget build(BuildContext context) {
//    // Report report = Provider.of<Report>(context);
//     FirebaseUser user = Provider.of<FirebaseUser>(context);
//
//     if (user != null) {
//       if(user.isAnonymous) print("anon");
//       print(user.uid+" "+user.displayName);
//       return Scaffold(
//         backgroundColor: const Color(0xFF20636F),
//         appBar: AppBar(
//           backgroundColor: Colors.black,
//           title: Text(user.displayName ?? 'Guest'),
//         ),
//         body: Center(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               if (user.photoUrl != null)
//                 Container(
//                   width: 100,
//                   height: 100,
//                   margin: EdgeInsets.only(top: 50),
//                   decoration: BoxDecoration(
//                     shape: BoxShape.circle,
//                     image: DecorationImage(
//                       image: NetworkImage(user.photoUrl),
//                     ),
//                   ),
//                 ),
//               SizedBox(height: 20,),
//               Text(user.email ?? '', style: Theme.of(context).textTheme.headline5),
//               Spacer(),
//               // if (report != null)
//               //   Text('${report.total ?? 0}',
//               //       style: Theme.of(context).textTheme.display3),
//               // Text('Quizzes Completed',
//               //     style: Theme.of(context).textTheme.subhead),
//               Spacer(),
//               // ignore: deprecated_member_use
//               FlatButton(
//                   child: Text('Log out'),
//                   color: const Color(0xFF20636F),
//                   onPressed: () async {
//                     await auth.signOut();
//                     Navigator.of(context).pushNamedAndRemoveUntil('/', (route) => false);
//                   }),
//               Spacer()
//             ],
//           ),
//         ),
//       );
//     } else {
//       return LoadingScreen();
//     }
//   }
//
// }