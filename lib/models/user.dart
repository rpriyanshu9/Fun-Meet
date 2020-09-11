class User {
  final String uid;
  User({this.uid});
}

class UserData{
  final String uid;
  final String name;
  final String preference;
  final String food;
  final int qtyFood;

  UserData(
      {this.uid,
      this.name,
      this.preference,
      this.food,
      this.qtyFood});
}

