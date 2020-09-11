import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:daily_baithak/models/choices.dart';
import 'package:daily_baithak/models/user.dart';

class DatabaseService {
  //inside here we're gonna have all the methods and properties that we're gonna use to interact with cloud firestore databse

  final String uid;

  DatabaseService({this.uid});

  //collection reference-reference to particular collection in firestore database
  final CollectionReference choicesCollection =
      Firestore.instance.collection('choices');

  // we use it 2 times: first when the user creates a new account, second when he updates the data
  Future updateUserData(String name, String preference, String food, int qtyFood) async {
    // this returns a new/updated doc when a user registers or updates data
    // setData accepts map
    return await choicesCollection.document(uid).setData({
      'name': name,
      'preference': preference,
      'food': food,
      'qty_food': qtyFood,
    });
  }

  //choice list from snapshot
  // this func cycles through the docs and return list of data rather than instances
  List<Choices> _choiceListFromSnapShot(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc) {
      return Choices(
        name: doc.data['name'] ?? '',
        preference: doc.data['preference'] ?? "chai",
        food: doc.data['food'] ?? "parantha",
        qtyFood: doc.data['qty_food'] ?? 1,
      );
    }).toList();
  }

  //this is the stream setup
  //every bit of data we get using streams is gonna be a snapshot
  Stream<List<Choices>> get choice {
    // .snapshots is a method of cloud firestore
    return choicesCollection.snapshots().map(
        _choiceListFromSnapShot); //remember changing return type in home.dart too
  }

  //user data from snapshots
  UserData _userDataFromSnapshots(DocumentSnapshot doc) {
    return UserData(
      uid: uid,
      name: doc.data['name'],
      preference: doc.data['preference'],
      food: doc.data['food'],
      qtyFood: doc.data['qty_food'],
    );
  }

  //get user specific document stream
  Stream<UserData> get userData {
    return choicesCollection
        .document(uid)
        .snapshots()
        .map(_userDataFromSnapshots);
  }
}
