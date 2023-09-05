


import 'package:cloud_firestore/cloud_firestore.dart';



abstract class BdInterface{

  FirebaseFirestore db = FirebaseFirestore.instance;

  late String table;
   String? id=null;




  Map<String, dynamic> toMap();
  String getCollection();
  void setId(String id);


  create() async {
    // print(toMap());
    return db.collection(getCollection()).add(
      toMap()
    ).then((value) {
      print(value.id);
    });
  }
  Future<void> update() async {
    // return db.collection(getCollection()).get({})
  }

  Future<void> delete() async {
    // db.collection(getCollection()).get()
  }

  get() async {
    var a =await db.collection(getCollection()).doc('erick').snapshots();
    print(a);
  }

  Future<List<Map<String, Object?>>?> getAll() async {

  }

}