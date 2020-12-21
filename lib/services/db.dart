import 'package:cloud_firestore/cloud_firestore.dart';
import 'models.dart';
import 'global_models.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:rxdart/rxdart.dart';





class Document<T>{


  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final String path;
  DocumentReference ref;

  Document({this.path}) {
    ref = _db.doc(path);

  }

  Future<T> getData(){

    print("at get data");

    print(ref.get().then((snap) => print(snap.data())));
    return ref.get().then((snap) => Global.models[T](snap.data()) as T);
  }

  Stream<T> streamData(){



    return ref.snapshots().map((snap) => Global.models[T](snap.data()) as T);

  }

  Future<void> upsert(Map data) {
    return ref.update(Map<String, dynamic>.from(data));
  }

}

class Collection<T> {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final String path;
  CollectionReference ref;

  Collection({ this.path }) {
    ref = _db.collection(path);
  }

  Future<List<T>> getData() async {
    var snapshots = await ref.get();
    return snapshots.docs.map((doc) => Global.models[T](doc.data()) as T ).toList();
  }

  Future<List<T>> getMyData(String field,String value) async {

    var snapshots = await ref.where(field,isEqualTo: value).get();

    return snapshots.docs.map((doc) => Global.models[T](doc.data()) as T ).toList();
  }




  Stream<List<T>> streamData() {
    return ref.snapshots().map((list) => list.docs.map((doc) => Global.models[T](doc.data) as T) );
  }


  Future<void> add(Map data) async {
    return ref.add(data);
  }


}


class   UserData<T> {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final String collection;

  UserData({ this.collection });


  Stream<T> get documentStream {
    return Observable(_auth.userChanges()).switchMap((user) {
      if (user != null) {
        Document<T> doc = Document<T>(path: '$collection/${user.uid}');


        return doc.streamData();
      } else {
        return Observable<T>.just(null);
      }
    });
  }

  Future<T> getDocument() async {
    User user =  _auth.currentUser;

    if (user != null) {
      Document doc = Document<T>(path:'$collection/${user.uid}');
      return doc.getData();
    } else {
      return null;
    }

  }

  Future<void> upsert(Map data) async {
    User user =  _auth.currentUser;
    Document<T> ref = Document(path:  '$collection/${user.uid}');
    return ref.upsert(data);
  }

}
