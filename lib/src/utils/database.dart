import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

final FirebaseFirestore _firestore = FirebaseFirestore.instance;
final CollectionReference _mainCollection = _firestore.collection('notes');

User? user = FirebaseAuth.instance.currentUser;

class Database {
  static String? userUid = user?.uid;

  static Future<void> addItem({
    required String name,
    required String recipe,
    // required bool checked,
    required String date,
    required String photoUrl,
  }) async {
    DocumentReference documentReferencer =
        _mainCollection.doc(userUid).collection('items').doc();

    Map<String, dynamic> data = <String, dynamic>{
      "name": name,
      "recipe": recipe,
      // "checked": checked,
      "date": date,
      "photoUrl": photoUrl
    };

    await documentReferencer
        .set(data)
        .whenComplete(() => print("Note item added to the database"))
        .catchError((e) => print(e));
  }

  static Future<void> updateItem(
      {required String name,
      required String recipe,
      required String docId,
      required String date,
      required String photoUrl}) async {
    DocumentReference documentReferencer =
        _mainCollection.doc(userUid).collection('items').doc(docId);

    Map<String, dynamic> data = <String, dynamic>{
      "name": name,
      "recipe": recipe,
      "date": date,
      "photoUrl": photoUrl
    };

    await documentReferencer
        .update(data)
        .whenComplete(() => print("Note item updated in the database"))
        .catchError((e) => print(e));
  }

  static Stream<QuerySnapshot> readItems() {
    CollectionReference noteItemCollection =
        _mainCollection.doc(userUid).collection('items');

    return noteItemCollection.snapshots();
  }

  static Future<void> deleteItem({
    required String docId,
  }) async {
    DocumentReference documentReferencer =
        _mainCollection.doc(userUid).collection('items').doc(docId);

    await documentReferencer
        .delete()
        .whenComplete(() => print("Note item deleted from the database"))
        .catchError((e) => print(e));
  }
}
