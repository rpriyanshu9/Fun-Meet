import 'package:cloud_firestore/cloud_firestore.dart';

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

  //this is the stream setup
  //every bit of data we get using streams is gonna be a snapshot
  Stream<QuerySnapshot> get choice {
    // .snapshots is a method of cloud firestore
    return choicesCollection.snapshots();
  }
}
