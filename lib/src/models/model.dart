import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

class Model {
  Model(this.collectionName, this.collection2);
  String collectionName;
  String? collection2;

  //initialize firestore
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  String? id;
  static Future<void> initiateFireStore() async {
    try {
      await Firebase.initializeApp(
          name: 'SecondaryApp',
          options: const FirebaseOptions(
            
            apiKey: 'AIzaSyC0fEnR82fUOJd80gAttQRMzU6kz31ql4s',
            authDomain: 'budgeting-62e58.firebaseapp.com',
            appId: '1:763713344331:web:86fdff2f5dd74eb1378ece',
            messagingSenderId: '763713344331',
            projectId: 'budgeting-62e58',
            databaseURL: "https://budgeting-62e58.firebaseio.com",
            storageBucket: "budgeting-62e58.appspot.com",
            measurementId: "G-R2GLZT2QKX",
          ));
      // ignore: empty_catches
    } catch (e) {
      e.toString();
    }
  }

  //firebase save data
  Future<DocumentReference<Map<String, dynamic>>> saveOnline(
      Map<String, dynamic> map) async {
    return await firestore.collection(collectionName).add(map);
  }

  //firebase save data with id
  Future<void> saveOnlineWithId(String _id, Map<String, dynamic> map) async {
    await firestore.collection(collectionName).doc(_id).set(map);
  }

  //update data
  Future updateOnline(String _id, Map<String, dynamic> map) async {
    await firestore.collection(collectionName).doc(_id).update(map);
  }

  //delete data
  Future deleteOnline(String _id) async {
    await firestore.collection(collectionName).doc(_id).delete();
  }

  //delete list
  Future deleteCollection(String _id, String id) async {
    await firestore
        .collection(collectionName)
        .doc(_id)
        .collection(collection2!)
        .doc(id)
        .delete();
  }

  //fetch all data
  //return a list of data
  Future<List<QueryDocumentSnapshot<Map<String, dynamic>>>> fetchAll() async {
    return (await firestore.collection(collectionName).get()).docs;
  }

  //returns a stream of data
  Stream<QuerySnapshot> snapshotsOnline() {
    return firestore.collection(collectionName).snapshots();
  }

  //fetch data by id
  Future<DocumentSnapshot<Map<String, dynamic>>> fetchById(String _id) async {
    return (await firestore.collection(collectionName).doc(_id).get());
  }

  // fetch data where
  //return a list of data where
  Future<List<QueryDocumentSnapshot<Map<String, dynamic>>>> fetchWhere(
    String field, {
    Object? isEqualTo,
    Object? isNotEqualTo,
    Object? isLessThan,
    Object? isLessThanOrEqualTo,
    Object? isGreaterThan,
    Object? isGreaterThanOrEqualTo,
    Object? arrayContains,
    List<Object?>? arrayContainsAny,
    List<Object?>? whereIn,
    List<Object?>? whereNotIn,
    bool? isNull,
  }) async {
    return (await firestore
            .collection(collectionName)
            .where(
              field,
              isEqualTo: isEqualTo,
              isNotEqualTo: isNotEqualTo,
              isLessThan: isLessThan,
              isLessThanOrEqualTo: isLessThanOrEqualTo,
              isGreaterThan: isGreaterThan,
              isGreaterThanOrEqualTo: isGreaterThanOrEqualTo,
              arrayContains: arrayContains,
              arrayContainsAny: arrayContainsAny,
              whereIn: whereIn,
              whereNotIn: whereNotIn,
              isNull: isNull,
            )
            .get())
        .docs;
  }

  //return a stream of data where
  Stream<QuerySnapshot> snapshotsWhere(
    String field, {
    Object? isEqualTo,
    Object? isNotEqualTo,
    Object? isLessThan,
    Object? isLessThanOrEqualTo,
    Object? isGreaterThan,
    Object? isGreaterThanOrEqualTo,
    Object? arrayContains,
    List<Object?>? arrayContainsAny,
    List<Object?>? whereIn,
    List<Object?>? whereNotIn,
    bool? isNull,
  }) {
    return firestore
        .collection(collectionName)
        .where(
          field,
          isEqualTo: isEqualTo,
          isNotEqualTo: isNotEqualTo,
          isLessThan: isLessThan,
          isLessThanOrEqualTo: isLessThanOrEqualTo,
          isGreaterThan: isGreaterThan,
          isGreaterThanOrEqualTo: isGreaterThanOrEqualTo,
          arrayContains: arrayContains,
          arrayContainsAny: arrayContainsAny,
          whereIn: whereIn,
          whereNotIn: whereNotIn,
          isNull: isNull,
        )
        .snapshots();
  }
}
