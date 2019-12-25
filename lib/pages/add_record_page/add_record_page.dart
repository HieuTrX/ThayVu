import 'package:demo/models/Tree.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';
//import 'createtodo.dart';
import '../../services/FirestoreService.dart';

class AddRecord extends StatefulWidget {
  final Tree tree;
  AddRecord(this.tree);
  @override
  _AddRecordState createState() => _AddRecordState();
}

class _AddRecordState extends State<AddRecord> {
  FirestoreService fireService = new FirestoreService();

  String id, name, age, status, image, area, record;
  List<String> comment;
  Tree tree;
  initState() {
    this.tree = widget.tree;
    this.id = widget.tree.id;
    this.name = widget.tree.name;
    this.age = widget.tree.age.toString();
    this.status = widget.tree.status;
    this.image = widget.tree.image;
    this.area = widget.tree.area;
    this.record = widget.tree.record;
    this.comment = widget.tree.comment;
  }

  getName(name) {
    this.name = name;
  }

  getAge(age) {
    this.age = age;
  }

  getStatus(status) {
    this.status = status;
  }

  getImage(image) {
    this.image = name;
  }

  getArea(area) {
    this.area = area;
  }

  int _myTreeType = 0;
  String taskVal;
  void _handleTaskType(int value) {
    setState(() {
      _myTreeType = value;
      switch (_myTreeType) {
        case 1:
          taskVal = 'Cut Leaf';
          break;
        case 2:
          taskVal = 'Fertilize';
          break;
        case 3:
          taskVal = 'Cut Branch';
          break;
        case 4:
          taskVal = 'Water';
          break;
      }
    });
  }

  createData() async {
    var id = UniqueKey().toString();

    var isFlower = false, isFruit = false, isWood = false, isGrass = false;
    switch (_myTreeType) {
      case 1:
        isFlower = true;
        break;
      case 2:
        isFruit = true;
        break;
      case 3:
        isWood = true;
        break;
      case 4:
        isGrass = true;
        break;
    }

    var todo = List<String>();
    final prefs = await SharedPreferences.getInstance();
    var age = int.parse(this.age);
    var idUser = prefs.getString('uid') ?? 0;
    var idTreeFireStore = this.id;
    var comment = this.comment;
    var email = prefs.getString('email') ?? 0;
    tree.updateRecord(taskVal, email);
    print(tree.record.toString());
    fireService.updateData(
        idTreeFireStore,
        id,
        image,
        status,
        isFlower,
        isFruit,
        isWood,
        isGrass,
        name,
        age,
        area,
        todo,
        idUser,
        tree.record,
        comment);
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController _controllerName = new TextEditingController();
    _controllerName.text = this.name;
    TextEditingController _controllerAge = new TextEditingController();
    _controllerAge.text = this.age;
    TextEditingController _controllerStatus = new TextEditingController();
    _controllerStatus.text = this.status;
    TextEditingController _controllerImage = new TextEditingController();
    _controllerImage.text = this.image;
    TextEditingController _controllerArea = new TextEditingController();
    _controllerArea.text = this.area;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Column(
        children: <Widget>[
          _myAppBar(),
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height - 80,
            child: ListView(
              children: <Widget>[
                Center(
                  child: Text(
                    'Select Action:',
                    style:
                        TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Radio(
                          value: 1,
                          groupValue: _myTreeType,
                          onChanged: _handleTaskType,
                          activeColor: Color(0xff4158ba),
                        ),
                        Text(
                          'Cut Leaf',
                          style: TextStyle(fontSize: 16.0),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Radio(
                          value: 2,
                          groupValue: _myTreeType,
                          onChanged: _handleTaskType,
                          activeColor: Color(0xfffb537f),
                        ),
                        Text(
                          'Fertilize',
                          style: TextStyle(
                            fontSize: 16.0,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Radio(
                          value: 3,
                          groupValue: _myTreeType,
                          onChanged: _handleTaskType,
                          activeColor: Color(0xff4caf50),
                        ),
                        Text(
                          'Cut branch',
                          style: TextStyle(fontSize: 16.0),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Radio(
                          value: 4,
                          groupValue: _myTreeType,
                          onChanged: _handleTaskType,
                          activeColor: Color(0xff9962d0),
                        ),
                        Text(
                          'Water',
                          style: TextStyle(fontSize: 16.0),
                        ),
                      ],
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    RaisedButton(
                        color: Color(0xFFFA7397),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: const Text(
                          "Cancel",
                          style: TextStyle(color: Color(0xFFFDDE42)),
                        )),
                    // This button results in adding the contact to the database
                    RaisedButton(
                        color: Color(0xFFFA7397),
                        onPressed: () {
                          createData();
                          Navigator.pop(context);
                          Navigator.pop(context);
                        },
                        child: const Text(
                          "Submit",
                          style: TextStyle(color: Color(0xFFFDDE42)),
                        ))
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _myAppBar() {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: Padding(
        padding: const EdgeInsets.only(top: 0.0),
        child: Center(
            child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Expanded(
              flex: 1,
              child: Container(
                child: IconButton(
                    icon: Icon(
                      Icons.list,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    }),
              ),
            ),
            Expanded(
              flex: 5,
              child: Container(
                child: Text(
                  'New Tasks',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20.0),
                ),
              ),
            ),
          ],
        )),
      ),
    );
  }
}
