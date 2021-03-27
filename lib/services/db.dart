
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:async';
import 'package:rxdart/rxdart.dart';
import './globals.dart';

/*A generic type of services for taking maps (snapshots) from firestore and
* to return the respective model
* Deserializing the data returned from the firstore into a Dart file is very simple and follows the same logic every time.
* So, to get the models we have implemented a generic type of database service that will map things to appropriate models without
* having to re-implement the logic every single time.
* */

class Document<T> {
  final Firestore _db =  Firestore.instance;
  final String path;
  DocumentReference ref;

  Document({ this.path }) {
    ref = _db.document(path);
  }
  //returns a future at one time
  Future<T> getData() {
    return ref.get().then((v) => Global.models[T](v.data) as T);
  }
  //returns a stream of snapshot data and mapping it to the model
  Stream<T> streamData() {
    return ref.snapshots().map((v) => Global.models[T](v.data) as T);
  }

  Future<void> upsert(Map data) {
    return ref.setData(Map<String, dynamic>.from(data), merge: true);
  }

}
/// difference between Collection class and Document class.
/// The above returns a document but here it returns a COLLECTION OF
/// DOCUMENTS.
class Collection<T> {
  final Firestore _db = Firestore.instance;
  final String path;
  CollectionReference ref;

  Collection({ this.path }) {
    ref = _db.collection(path);
  }
  //returns a list of documents of that type since it is returing one collection
  Future<List<T>> getData() async {
    var snapshots = await ref.getDocuments();
    return snapshots.documents.map((doc) => Global.models[T](doc.data) as T ).toList();
  }
  //same as above
  Stream<List<T>> streamData() {
    return ref.snapshots().map((list) => list.documents.map((doc) => Global.models[T](doc.data) as T) );
  }


}

/// this class returns a document from collections based on the
/// authentication uid.
class UserData<T> {
  final Firestore _db = Firestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final String collection;

  UserData({ this.collection });

  // this is a stream
  Stream<T> get documentStream {
    // switches from ine stream to another. that is, our user id
    return (_auth.onAuthStateChanged).switchMap((user){
        if (user != null) {
          //if user is not null; if the user is currently logged in
        Document<T> doc = Document<T>(path: '$collection/${user.uid}');
        return doc.streamData();
      } else {
        return Stream.value(null);
      }
    }); //.shareReplay(maxSize: 1).doOnData((d) => print('777 $d'));// as Stream<T>;
  }

  // this is a FUTURE
  //unsubcribing when user logs out
  Future<T> getDocument() async {
    FirebaseUser user = await _auth.currentUser();

    if (user != null) {
      Document doc = Document<T>(path: '$collection/${user.uid}');
      return doc.getData();
    } else {
      return null;
    }

  }

  Future<void> upsert(Map data) async {
    FirebaseUser user = await _auth.currentUser();
    Document<T> ref = Document(path:  '$collection/${user.uid}');
    return ref.upsert(data);
  }

}