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
  Future updateUserData(String name, String preference, String cig, int no_cig,
      String food, int qty_food) async {
    // this returns a new/updated doc when a user registers or updates data
    // setData accepts map
    return await choicesCollection.document(uid).setData({
      'name': name,
      'preference': preference,
      'cig': cig,
      'no_cig': no_cig,
      'food': food,
      'qty_food': qty_food,
    });
  }

  //choice list from snapshot
  // this func cycles through the docs and return list of data rather than instances
  List<Choices> _choiceListFromSnapShot(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc) {
      return Choices(
        name: doc.data['name'] ?? '',
        preference: doc.data['preference'] ?? "chai",
        cig: doc.data['cig'] ?? 'Ultra Mild',
        no_cig: doc.data['no_cig'] ?? 0,
        food: doc.data['food'] ?? "parantha",
        qty_food: doc.data['qty_food'] ?? 1,
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
      cig: doc.data['cig'],
      no_cig: doc.data['no_cig'],
      food: doc.data['food'],
      qty_food: doc.data['qty_food'],
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
