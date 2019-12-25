import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
//import 'createtodo.dart';
import '../../services/FirestoreService.dart';

class NewTask extends StatefulWidget {
  NewTask();
  @override
  _NewTaskState createState() => _NewTaskState();
}

class _NewTaskState extends State<NewTask> {
  FirestoreService fireService = new FirestoreService();
  String name, age, status, image, area;

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
          taskVal = 'Flower';
          break;
        case 2:
          taskVal = 'Fruit';
          break;
        case 3:
          taskVal = 'Wood';
          break;
        case 4:
          taskVal = 'Grass';
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
    var record = 'test';
    var comment = [];
    fireService.createTree(id, image, status, isFlower, isFruit, isWood,
        isGrass, name, age, area, todo, idUser, record, comment);
  }

  @override
  Widget build(BuildContext context) {
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
                Padding(
                  padding: EdgeInsets.only(left: 16.0, right: 16.0),
                  child: TextField(
                    // controller: _taskNameController,
                    onChanged: (String name) {
                      getName(name);
                    },
                    decoration: InputDecoration(labelText: "Name: "),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 16.0, right: 16.0),
                  child: TextField(
                    //controller: _taskDetailsController,
                    decoration: InputDecoration(labelText: "Age: "),
                    onChanged: (String age) {
                      getAge(age);
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 16.0, right: 16.0),
                  child: TextField(
                    // controller: _statusController,
                    decoration: InputDecoration(labelText: "Status: "),
                    onChanged: (String taskdate) {
                      getStatus(taskdate);
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 16.0, right: 16.0),
                  child: TextField(
                    // controller: _imageController,
                    decoration: InputDecoration(labelText: "Image: "),
                    onChanged: (String image) {
                      getImage(image);
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 16.0, right: 16.0),
                  child: TextField(
                    // controller: _imageController,
                    decoration: InputDecoration(labelText: "Area: "),
                    onChanged: (String area) {
                      getArea(area);
                    },
                  ),
                ),
                SizedBox(
                  height: 10.0,
                ),
                Center(
                  child: Text(
                    'Select Tree Type:',
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
                          'Flower',
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
                          'Fruit',
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
                          'Wood',
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
                          'Grass',
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
