class User {
  String _id;
  String email;
  User(this._id, this.email);

  @override
  String toString() {
    return "${this.email}";
  }
}
