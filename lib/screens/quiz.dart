import 'package:flutter/animation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quizapp/screens/video.dart';
import '../shared/shared.dart';
import '../services/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';

/// ChangeNotifier is a native class from Flutter. We’ll use it to notify
/// our View when one or more variables change in its ViewModel. It prevents
/// to use the ugly SetState()
/// function directly in our Views which would result in unmaintainable code.
class QuizState with ChangeNotifier{
    double _progress = 0;
    Option _selected;
    //allows us to get setters and getters. this will listen to changes so we
    // do not have to call setState manually.
    final PageController controller = PageController();
    get progress{
      return _progress;
    }
    get selected{
      return _selected;
    }
    //simply redefining our state
    set progress(double newValue){
      _progress = newValue;
      notifyListeners(); //rerenders state AUTOMATICALLY
    }
    set selected(Option newSelected){
        _selected = newSelected;
    }
    void nextPage() async {
      await controller.nextPage(
        duration: Duration(milliseconds: 500),
        curve: Curves.easeOut,
      );
    }
}
/// ChangeNotifierProvider Listens to a ChangeNotifier, expose it to its descendants and rebuilds
/// dependents whenever ChangeNotifier.notifyListeners is called.
///

class QuizScreen extends StatelessWidget {
  Set<String> complete=new Set();
  QuizScreen({this.quizId});

  final String quizId;
  @override
  Widget build(BuildContext context) {
    print(quizId);
    /// ChangeNotifierProvider Listens to a ChangeNotifier, expose it to its descendants and rebuilds
    /// dependents whenever ChangeNotifier.notifyListeners is called.
    return ChangeNotifierProvider(
           create: (_) => QuizState(),

           child: FutureBuilder(
              future: Document<Quiz>(path: 'quizzes/$quizId').getData(),

               builder: (BuildContext context, AsyncSnapshot snap) {
                  print("will try going into the builder");
                  print(snap);
                  print("done");
                /// var state declared as provider of context so that we
                 /// can use the value of the context at any time.

                 var state = Provider.of<QuizState>(context); // k
             //    state.progress;
                 if(!snap.hasData || snap.hasError){
                   return LoadingScreen();
                 } else  {
              Quiz quiz = snap.data;
              print(quiz.questions);
              bool status = false;
              if((complete.isNotEmpty)&&complete.contains(quizId)){
                  return Scaffold(
                      appBar: AppBar(
                          backgroundColor: Colors.pink,
                      ),
                      body: Container(
                          child: Text("You have already attempted this quiz"),
                      )
                  );
              } else return Scaffold(
                appBar: AppBar(
                  title: AnimatedProgressbar(
                    value: state.progress,
                  ),
                  leading: IconButton(
                    icon: Icon(FontAwesomeIcons.times),
                    onPressed: () {
                      return showDialog(
                        context: context,
                        builder: (ctx) => AlertDialog(
                          title: Text("Quiz Not Yet Completed",
                          style: TextStyle(color: Colors.black,),),
                          content: Text("Your progress will be lost since the quiz"
                              " is not yet complete. Are you sure you want to"
                              " continue?"),
                          actions: <Widget>[
                            // ignore: deprecated_member_use
                            FlatButton(
                              color: Colors.black,
                              splashColor: Colors.deepPurple,
                              hoverColor: Colors.green,
                              onPressed: () {
                                  Navigator.pushNamedAndRemoveUntil(context, '/topics', (route) => false);
                              },
                              child: Text("Yes, exit"),
                            ),
                            // ignore: deprecated_member_use
                            FlatButton(
                              color: Colors.black,
                              splashColor: Colors.deepPurple,
                              disabledTextColor: Colors.green,
                              onPressed: () {
                                Navigator.of(ctx).pop();
                              },
                              child: Text("Cancel"),
                            ),
                          ],
                        ),
                      );
                      Navigator.pop(context);
                    },
                  ),
                ),
                body: PageView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  controller: state.controller,
                  //  onPageChanged: (int idx) =>
                  // state.progress = (idx / (quiz.questions.length + 1)),
                  onPageChanged: (int idx) =>
                  state.progress = (idx / (quiz.questions.length + 1)),
                  itemBuilder: (BuildContext context, int idx) {
                    if (idx == 0) {
                      // first question. we need to return the first page
                      return StartPage(quiz: quiz);

                    } else if (idx == quiz.questions.length + 1) {
                    //we have reached the end pf questions.
                    // so, display the congrats page
                    //  return CongratsPage(quiz: quiz);
                      return CongratsPage(quiz: quiz, quizId: quizId
                        ,complete: complete
                      );
                    } else {
                    // go to the next question page
                      // return QuestionPage(question:quiz.questions[idx-1]);
                      return QuestionPage(question: quiz.questions[idx - 1]);
                    }
                  },
                ),
              );
            }
          }
          ),
    );
  }
}
class StartPage extends StatelessWidget {
  final Quiz quiz;
  final PageController controller;

  StartPage({this.quiz, this.controller});

  @override
  Widget build(BuildContext context) {
    var state = Provider.of<QuizState>(context);
    return Container(
      padding: EdgeInsets.all(20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(quiz.title,
              style: TextStyle(
                  color: Colors.purpleAccent,
                fontSize: 30,
                fontStyle: FontStyle.italic,
              )
          ),
          Divider(),
          Expanded(child: Text(quiz.description)),
          Row(

            children: [
              ButtonBar(
                alignment: MainAxisAlignment.center,
                children: <Widget>[
                  // ignore: deprecated_member_use
                  FlatButton.icon(
                    onPressed: (){
                        print("vutton has been pressed for web");
                        VideoScreen();
                    },
                    label: Text('Watch Video'),
                    icon: Icon(Icons.poll),
                    color: Colors.black,
                  )
                ],
              ),
              ButtonBar(
                alignment: MainAxisAlignment.center,
                children: <Widget>[
                  // ignore: deprecated_member_use
                  FlatButton.icon(
                    onPressed: state.nextPage,
                    label: Text('Start Quiz!'),
                    icon: Icon(Icons.poll),
                    color: Colors.black,
                  )
                ],
              ),
            ],
          )
        ],
      ),
    );
  }
}
class QuestionPage extends StatelessWidget {
  final Question question;
  QuestionPage({this.question});

  @override
  Widget build(BuildContext context) {
    var state = Provider.of<QuizState>(context);

    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Expanded(
          child: Container(
            padding: EdgeInsets.all(16),
            alignment: Alignment.center,
            child: Text(question.text),
          ),
        ),
        Container(
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: question.options.map((opt) {
              return Container(
                height: 90,
                margin: EdgeInsets.only(bottom: 10),
                color: Colors.black26,
                child: InkWell(
                  onTap: () {
                    state.selected = opt;
                    _bottomSheet(context, opt, state);
                  },
                  child: Container(
                    padding: EdgeInsets.all(16),
                    child: Row(
                      children: [
                        Icon(
                            state.selected == opt
                                ? FontAwesomeIcons.checkCircle
                                : FontAwesomeIcons.circle,
                            size: 30),
                        Expanded(
                          child: Container(
                            margin: EdgeInsets.only(left: 16),
                            child: Text(
                              opt.value,
                              style: Theme.of(context).textTheme.body2,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        )
      ],
    );
  } }
_bottomSheet(BuildContext context, Option opt, QuizState state) {
  bool correct = opt.correct;

  showModalBottomSheet(
    context: context,
    builder: (BuildContext context) {
      return Container(
        height: 250,
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(correct ? 'Good Job!' : 'Wrong'),
            Text(
              opt.detail,
              style: TextStyle(fontSize: 18, color: Colors.white54),
            ),
            // ignore: deprecated_member_use
            FlatButton(
              color: correct ? Colors.green : Colors.red,
              child: Text(
                correct ? 'Onward!' : 'Try Again',
                style: TextStyle(
                  color: Colors.white,
                  letterSpacing: 1.5,
                  fontWeight: FontWeight.bold,
                ),
              ),
              onPressed: () {
                if (correct) {
                  state.nextPage();
                }
                Navigator.pop(context);
              },
            ),
          ],
        ),
      );
    },
  );
}

// ignore: must_be_immutable
class CongratsPage extends StatelessWidget {
  final Quiz quiz;
  final String quizId;
  Set<String> complete;
  CongratsPage({this.quiz, this.quizId
    ,this.complete
  });
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Congrats! You completed the ${quiz.title} quiz',
            textAlign: TextAlign.center,
          ),
          Divider(),
          Image.asset('assets/congrats.gif'),
          Divider(),
          // ignore: deprecated_member_use
          FlatButton.icon(
            color: Colors.green,
            icon: Icon(FontAwesomeIcons.check),
            label: Text(' Mark Complete!'),
            onPressed: () {
              String completedThisTopicQuiz = quizId;
              complete.add(completedThisTopicQuiz);
              print("length is "+(complete.length.toString()));
              _updateUserReport(quiz);
              Navigator.pushNamedAndRemoveUntil(
                context,
                '/topics',
                    (route) => false,
              );
            },
          )
        ],
      ),
    );
  }

  /// Database write to update report doc when complete
  Future<void> _updateUserReport(Quiz quiz) {
    return Global.reportRef.upsert(
      ({
        'total': FieldValue.increment(1),
        'topics': {
          '${quiz.topic}': FieldValue.arrayUnion([quiz.id])
        }
      }),
    );
  }
}



