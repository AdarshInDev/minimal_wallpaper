import 'package:cloud_firestore/cloud_firestore.dart';

class DataBaseMethods {
  Future addWall(
      Map<String, dynamic> wallInfoMap, String id, String category) async {
    return await FirebaseFirestore.instance
        .collection(category)
        .doc(id)
        .set(wallInfoMap);
  }

  Future<Stream<QuerySnapshot>> getwallStream(String nameofCategory) async {
    return FirebaseFirestore.instance.collection(nameofCategory).snapshots();
  }
}
