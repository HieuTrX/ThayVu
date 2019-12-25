class Tree {
  String _id;
  String _image;
  String _status;
  bool _isFlower = false;
  bool _isFruit = false;
  bool _isWood = false;
  bool _isGrass = false;
  String _name;
  int _age;
  String _area;
  List<String> _todo;
  String _idUser;
  String _record;
  List<String> _comment;

  Tree.map(dynamic obj) {
    this._id = obj["id"];
    this._image = obj["image"];
    this._status = obj["status"];
    this._isFlower = obj["isFlower"];
    this._isFruit = obj["isFruit"];
    this._isWood = obj["isWood"];
    this._isGrass = obj["isGrass"];
    this._name = obj["name"];
    this._age = obj["age"];
    this._area = obj["area"];
    this._todo = obj["todo"];
    this._idUser = obj["idUser"];
    this._record = obj["record"];
    this._comment = obj["comment"];
  }

  Tree(
      this._id,
      this._image,
      this._status,
      this._isFlower,
      this._isFruit,
      this._isWood,
      this._isGrass,
      this._name,
      this._age,
      this._area,
      this._todo,
      this._idUser,
      this._record,
      this._comment);

  String get area => _area;

  String get record => _record;
  void updateRecord(field, mail) {
    record += "/" +
        field.toString().toUpperCase() +
        " is done " +
        "in " +
        DateTime.now().toString() +
        " by " +
        mail.toString() +
        "./";
  }

  set record(String value) {
    _record = value;
  }

  int get age => _age;

  String get name => _name;

  bool get isGrass => _isGrass;

  bool get isWood => _isWood;

  bool get isFruit => _isFruit;

  bool get isFlower => _isFlower;

  String get status => _status;

  String get image => _image;

  String get id => _id;

  List<String> get todo => _todo;

  set todo(List<String> value) {
    _todo = value;
  }

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    map["id"] = _id;
    map["image"] = _image;
    map["status"] = _status;
    map["isFlower"] = _isFlower;
    map["isFruit"] = _isFruit;
    map["isWood"] = _isWood;
    map["isGrass"] = _isGrass;
    map["name"] = _name;
    map["age"] = _age;
    map["area"] = _area;
    map["todo"] = _todo;
    map["idUser"] = _idUser;
    map["record"] = _record;
    map["comment"] = _comment;
    return map;
  }

  Tree.fromMap(Map<String, dynamic> map) {
    this._id = map["id"];
    this._image = map["image"];
    this._status = map["status"];
    this._isFlower = map["isFlower"];
    this._isFruit = map["isFruit"];
    this._isWood = map["isWood"];
    this._isGrass = map["isGrass"];
    this._name = map["name"];
    this._age = map["age"];
    this._area = map["area"];
    this._todo = map["todo"].cast<String>();
    this._idUser = map["idUser"];
    this._record = map["record"];
    this._comment = map["comment"].cast<String>();
  }

  @override
  String toString() {
    return 'Tree{_id: $_id, _image: $_image, _status: $_status, _isFlower: $_isFlower, _isFruit: $_isFruit, _isWood: $_isWood, _isGrass: $_isGrass, _name: $_name, _age: $_age, _area: $_area, _todo: $_todo, _idUser: $_idUser, _record: $_record, _comment: $_comment}';
  }

  String get idUser => _idUser;

  set idUser(String value) {
    _idUser = value;
  }

  List<String> get comment => _comment;

  set comment(List<String> value) {
    _comment = value;
  }

  void addComment(email, com) {
    comment.add(email.toString() + "/" + com.toString());
  }
}
