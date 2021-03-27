import 'package:flutter/material.dart';
import 'package:quizapp/services/globals.dart';
import 'package:quizapp/shared/bottom_nav.dart';
import 'package:quizapp/shared/loader.dart';
import 'package:flutter/material.dart';
import '../services/services.dart';
import '../shared/shared.dart';
import '../screens/screens.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

/// we retrieve the database data only ONCE,
/// then we only pass it down the widgets.
///QuizList() gets called two times.

/*
  there are 3 collections in our database model.
  quizzes, topics, reports.
  In this file we are going to display the topic screen (the main screen)
  after the user has just logged in.
  Now, we get the list of Topic (class) from our firestore data.
  Each topic has id, img, title and list of quizzes.
  Each topic will have quizzes(firestore) related to it.
  When user taps on a Topic card shown in the main screen,
  he/she will be directed to the TopicScreen (where the hero animation)
  takes place.
  NOTE: TopicsScreen and TopicScreen are both DIFFERENT.
  The TopicScreen will show details gotten from the list of quiz from topics
  collection.
  Now, each quiz list is shown below the hero animated image
  and when tapped on it, the corresponding quizId is used to get the quiz from
  the quizzes collection of the firestore database model.
 */
class TopicsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
        return FutureBuilder(
          future: Global.topicsRef.getData(),
          builder: (BuildContext context, AsyncSnapshot snap){
            print("TOPICS SCREEN");
            if(snap.hasData){
                //if the snapshot has data, view the UI
                List<Topic> topics = snap.data;
                for(int x=0;x<topics[0].quizzes.length;x++){
                    print(topics[0].quizzes[x].title);
                }
                //FIRST IS ANGULAR

                return Scaffold(
               //   backgroundColor: Colors.black87,
                  appBar: AppBar(
                    backgroundColor: Colors.deepPurple,
                    title: Text("Topics"),
                    actions: [
                      IconButton(
                        icon: Icon(FontAwesomeIcons.userCircle,
                            color: Colors.yellow[200]),
                        onPressed: () => Navigator.pushNamed(context, '/profile'),
                      )
                    ],
                  ),
                  bottomNavigationBar: AppBottomNav(),
                  drawer: TopicDrawer(topics: snap.data),

                  body: GridView.count(
                        primary: false,
                        padding: const EdgeInsets.all(20.0),
                        crossAxisSpacing: 10.0,
                        crossAxisCount: 2,
                        children: topics.map((topic) => TopicItem(topic: topic)).toList(),
                    ),


                );
            } else {
              return LoadingScreen();
            }
          }
        );
  }
}

///the widget to which each of the topic list item is mapped to.
class TopicItem extends StatelessWidget {
  final Topic topic;
  const TopicItem({Key key, this.topic}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Hero(
        tag: topic.img,
        child: Card(
          clipBehavior: Clip.antiAlias,
          child: InkWell(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (BuildContext context) => TopicScreen(topic: topic),
                ),
              );
              print("widget has been tapped");
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image.asset(
                  'assets/covers/${topic.img}',
                  fit: BoxFit.fitWidth,
                ),
                Row(
                 // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.only(left: 10, right: 10),
                        child: Text(
                          topic.title,
                          style: TextStyle(
                              height: 1.5, fontWeight: FontWeight.bold),
                          overflow: TextOverflow.fade,
                          softWrap: false,
                        ),
                      ),
                    ),
                   //  Text(topic.description)
                  ],
                ),
                // )
                TopicProgress(topic: topic),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
class TopicScreen extends StatelessWidget {
  final Topic topic;

  TopicScreen({this.topic});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      body: ListView(children: [
        Hero(
          tag: topic.img,
          child: Image.asset('assets/covers/${topic.img}',
              width: MediaQuery.of(context).size.width),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: SizedBox(
            width: 50,
            child: Text(
              topic.title,
              style:
              TextStyle(height: 2, fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
        ),
        QuizList(topic: topic)
      ]),
    );
  }
}
class QuizList extends StatelessWidget {
  final Topic topic;
  QuizList({Key key, this.topic});

  @override
  Widget build(BuildContext context) {

    return Column(
        children: topic.quizzes.map((quiz) {
          return Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
            elevation: 8,
            margin: EdgeInsets.all(5),
            child: InkWell(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (BuildContext context) => QuizScreen(quizId: quiz.id),
                  ),
                );
              },
              child: Container(
                padding: EdgeInsets.all(8),
              //  color: Colors.grey,
                child: ListTile(
                  title: Text(
                    quiz.title,
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  subtitle: Text(
                    quiz.description,
                    overflow: TextOverflow.fade,
                    style: Theme.of(context).textTheme.subtitle1,
                  ),
                //  leading: QuizBadge(topic: topic, quizId: quiz.id),
                ),
              ),
            ),
          );
        }).toList());
  }
}
class TopicDrawer extends StatelessWidget {
  final List<Topic> topics;
  TopicDrawer({Key key, this.topics});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView.separated(

          shrinkWrap: true,
          itemCount: topics.length,
          itemBuilder: (BuildContext context, int idx) {
            Topic topic = topics[idx];
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 10, left: 10),
                  child: Text(
                    topic.title,
                    // textAlign: TextAlign.left,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white70,
                    ),
                  ),
                ),
                QuizList(topic: topic)
              ],
            );
          },
          separatorBuilder: (BuildContext context, int idx) => Divider()),
    );
  }
}