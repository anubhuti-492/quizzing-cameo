import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:quizapp/services/auth.dart';
import 'package:quizapp/shared/loader.dart';
import '../services/services.dart';
import '../shared/shared.dart';
import 'package:provider/provider.dart';


class UserProfile extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    FirebaseUser user = Provider.of<FirebaseUser>(context);
    final AuthService auth = AuthService();
    Report report = Provider.of<Report>(context);
    print(report.total);
    String displayName = user.displayName;
    String email = user.email;
    String photo = user.photoUrl;
    return Scaffold(
      appBar: AppBar(
        title: Text(
            "Your Profile",
          style: TextStyle(
              fontStyle: FontStyle.italic,
            color: Colors.black,
          ),
        ),
        backgroundColor: const Color(0xFF20636F),
        ),
        body: Column(
            children: [
              SizedBox(height: 25,),
                  Row(
                     children: [
                       SizedBox(width: 15,),
                       Center(
                           child: Text("Hey there, quizzer!"),
                       ),
                     ],
                  ),
                  Row(
                      children: [
                          Container(
                            width: 150,
                            height: 100,
                            margin: EdgeInsets.only(top: 50),
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                      image: NetworkImage(
                                          user.photoUrl,
                                      )
                                  )

                              ),
                          ),
                      ],

                  ),
                SizedBox(height: 55,),
                Row(
                  children: [
                    SizedBox(width: 15,height: 15,),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                          "Name: $displayName",
                      ),
                    ),
                  ],
                ),
              SizedBox(height: 15,),
              Row(
                children: [
                  SizedBox(width: 15,height: 15,),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Email address: $email",
                    ),
                  ),
                ],
              ),
              SizedBox(height: 15,),
              Row(
                children: [
                  SizedBox(width: 15,height: 15,),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                        "Total Quizzes Completed: ${report.total}",
                    ),
                  ),
                ],
              ),
              // ignore: deprecated_member_use
              SizedBox(height: 45,),
              FlatButton(
                  child: Text('Log out'),
                  color: const Color(0xFF20636F),
                  onPressed: () async {
                    await auth.signOut();
                    Navigator.of(context).pushNamedAndRemoveUntil('/', (route) => false);
                  }),
            ],
        ),
    );
  }
}
