class User {
  final String uid;
  User({this.uid});
}

class UserData{
  final String uid;
  final String name;
  final String preference;
  final String cig;
  final int no_cig;
  final String food;
  final int qty_food;

  UserData(
      {this.uid,
      this.name,
      this.preference,
      this.cig,
      this.no_cig,
      this.food,
      this.qty_food});
}

