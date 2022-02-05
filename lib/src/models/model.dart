import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
class Model{
  Model(this.collectionName);
  String collectionName;

  //initialize firestore
  final FirebaseFirestore firestore=FirebaseFirestore.instance;
  String? id;
  static Future<void> initiateFireStore()async{
    try{
      await Firebase.initializeApp(
        name: 'budget',
        options: const FirebaseOptions(
          apiKey: 'AIzaSyDwn4T6UwLMqLLD5w7jARWVJabiS7DyAmY', 
          appId: '1:834602052606:web:0852fa8eedae2746682eaf', 
          messagingSenderId: '834602052606', 
          projectId: 'trucks-c05a8',
          databaseURL: "https://trucks-c05a8.firebaseio.com",
          storageBucket: "trucks-c05a8.appspot.com",
          measurementId: "G-6CQQ394FHP",
        )

      );
    // ignore: empty_catches
    }catch(e){}
  }
  //firebase save data 
  Future<DocumentReference<Map<String,dynamic>>> saveOnline(Map<String,dynamic> map)async{
    return await firestore.collection(collectionName).add(map);
  }
   //firebase save data with id
   Future<void>saveOnlineWithId(String _id,Map<String,dynamic> map)async{
     await firestore.collection(collectionName).doc(_id).set(map);
   }
   //update data 
   Future updateOnline(String _id,Map<String,dynamic>map)async{
     await firestore.collection(collectionName).doc(_id).update(map);
   }
   //delete data
   Future deleteOnline(String _id) async{
     await firestore.collection(collectionName).doc(_id).delete();
   }
   //fetch all data
   //return a list of data
   Future<List<QueryDocumentSnapshot<Map<String,dynamic>>>> fetchAll() async{
     return (await firestore.collection(collectionName).get()).docs;
   }
   //returns a stream of data
   Stream<QuerySnapshot>snapshotsOnline(){
     return firestore.collection(collectionName).snapshots();
   }
   //fetch data by id
   Future<DocumentSnapshot<Map<String,dynamic>>> fetchById(String _id) async{
     return (await firestore.collection(collectionName).doc(_id).get());

   }
  // fetch data where
  //return a list of data where 
  Future<List<QueryDocumentSnapshot<Map<String,dynamic>>>> fetchWhere(String field,{
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
  })async{
    return(await firestore.collection(collectionName).where(field,
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
    ).get()).docs;
  }
  //return a stream of data where
  Stream<QuerySnapshot>snapshotsWhere(String field,{
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
  }){
    return firestore.collection(collectionName).where(field,
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
    ).snapshots();

  }
}