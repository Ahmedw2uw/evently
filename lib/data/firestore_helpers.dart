import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:evently/models/event_dm.dart';
import 'package:evently/models/user_dm.dart';

Future<void> addUserToFirestore(UserDm user) async {
  var userColiction = FirebaseFirestore.instance.collection(
    UserDm.userColictionName,
  );
  var emptyDoc = userColiction.doc(user.id); // assign same ID from auth
  await emptyDoc.set(user.tojson());
}

Future<UserDm> getUserFromFirestore(String userId) async {
  CollectionReference userColiction = FirebaseFirestore.instance.collection(
    UserDm.userColictionName,
  );
  DocumentReference userDocument = userColiction.doc(userId);
  DocumentSnapshot snapShot = await userDocument.get();
  Map json = snapShot.data() as Map;

  UserDm userData = UserDm(
    id: json["id"],
    email: json["email"],
    name: json["name"],
    favorateEvents: List<String>.from(json["favorateEvents"] ?? []),
  );
  return userData;
}

Future<void> addEventToFirestore(EventDm event) async {
  var eventsColliction = FirebaseFirestore.instance.collection(
    EventDm.colictionName,
  );
  var emptyDocument = eventsColliction.doc(); // generate ID
  event.id = emptyDocument.id; // assign to model
  await emptyDocument.set(event.tojson());
}

Future<List<EventDm>> getAllEventFromFirestore() async {
  var eventsCollection = FirebaseFirestore.instance.collection(
    EventDm.colictionName,
  );
  QuerySnapshot snapshot = await eventsCollection.get();

  List<EventDm> events =
      snapshot.docs.map((doc) {
        Map<String, dynamic> json = doc.data() as Map<String, dynamic>;
        json["id"] = doc.id;
        return EventDm.fromJson(json);
      }).toList();

  return events;
}

Future<void> addEventToFavorates(String eventId) async {
  final userColiction = FirebaseFirestore.instance.collection(
    UserDm.userColictionName,
  );
  final curentUserDoc = userColiction.doc(UserDm.curentUser!.id);

  await curentUserDoc.update({
    "favorateEvents": FieldValue.arrayUnion([eventId]),
  });

  // تحديث البيانات المحلية بعد الإضافة
  UserDm.curentUser!.favorateEvents.add(eventId);
}

Future<void> removeEventFromFavorates(String eventId) async {
  final userColiction = FirebaseFirestore.instance.collection(
    UserDm.userColictionName,
  );
  final curentUserDoc = userColiction.doc(UserDm.curentUser!.id);

  await curentUserDoc.update({
    "favorateEvents": FieldValue.arrayRemove([eventId]),
  });

  // تحديث البيانات المحلية بعد الحذف
  UserDm.curentUser!.favorateEvents.remove(eventId);
}

Stream<List<EventDm>> getAllEventsFromFirestore() {
  var eventsColliction = FirebaseFirestore.instance.collection(
    EventDm.colictionName,
  );
  Stream<QuerySnapshot<Map<String, dynamic>>> stream =
      eventsColliction.snapshots(); //* the snapshot is returned in stream

  return stream.map((querySnapshot) {
    List<EventDm> events =
        querySnapshot.docs.map((docSnapshot) {
          var json = docSnapshot.data();
          return EventDm.fromJson(json);
        }).toList();
    return events;
    // yield events;//* yield => its reblace the reyurn becuse return end the function bu yield not close fu nction
  });
}

Future<List<EventDm>> getFavorateEventsFromFirestore() async {
  if (UserDm.curentUser == null) return [];

  List<String> favorateIds = UserDm.curentUser!.favorateEvents;
  if (favorateIds.isEmpty) return [];

  CollectionReference eventsCol = FirebaseFirestore.instance.collection(
    EventDm.colictionName,
  );

  QuerySnapshot snapshot =
      await eventsCol.where(FieldPath.documentId, whereIn: favorateIds).get();

  List<EventDm> favEvents =
      snapshot.docs.map((doc) {
        Map<String, dynamic> json = doc.data() as Map<String, dynamic>;
        json['id'] = doc.id;
        return EventDm.fromJson(json);
      }).toList();

  return favEvents;
}
