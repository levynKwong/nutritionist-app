import 'package:cloud_firestore/cloud_firestore.dart';

int countPatients() {
  int count = 0;

  FirebaseFirestore.instance.collection('Patient').get().then((querySnapshot) {
    List<QueryDocumentSnapshot<Object?>> documents = querySnapshot.docs;

    Set<String> uniqueIds = Set<String>();
    for (QueryDocumentSnapshot<Object?> document in documents) {
      Map<String, dynamic> data = document.data() as Map<String, dynamic>;
      String uid = data['uid'] as String;
      uniqueIds.add(uid);
    }

    count = uniqueIds.length;
  });

  return count;
}
