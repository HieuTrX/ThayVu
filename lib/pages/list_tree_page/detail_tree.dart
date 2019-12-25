import 'package:demo/models/Tree.dart';
import 'package:demo/pages/add_record_page/add_record_page.dart';
import 'package:demo/pages/comment_page/comment.dart';
import 'package:demo/pages/list_tree_page/edit_tree.dart';
import 'package:flutter/material.dart';

class DetailTree extends StatelessWidget {
  final Tree tree;

  DetailTree({Key key, @required this.tree}) : super(key: key);

  Widget titleSection() {
    return Container(
      child: Center(
        child: Text(tree.name,
            style: new TextStyle(
              fontSize: 60.0,
              color: Colors.green,
            )),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    print('test');
    print(this.tree);
    return Scaffold(
      appBar: AppBar(
        title: Text(tree.name.toString() + " / " + tree.id.toString()),
        actions: <Widget>[
          new FlatButton(
              child: new Text('Edit',
                  style: new TextStyle(fontSize: 17.0, color: Colors.white)),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => EditTree(tree)),
                );
              })
        ],
      ),
      body: Column(
        children: [
          new Container(
              width: 190.0,
              height: 190.0,
              decoration: new BoxDecoration(
                  shape: BoxShape.circle,
                  image: new DecorationImage(
                      fit: BoxFit.fill, image: new NetworkImage(tree.image)))),
          titleSection(),
          detailSection(context),
        ],
      ),
    );
  }

  Widget detailSection(BuildContext context) {
    return Container(
      alignment: Alignment.bottomLeft,
      padding: const EdgeInsets.all(20.0),
      child: new SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text("NAME:   " + tree.name.toLowerCase(),
                style: new TextStyle(
                  fontSize: 20.0,
                  color: Colors.black,
                )),
            Text("Status:   " + tree.status.toLowerCase(),
                style: new TextStyle(
                  fontSize: 20.0,
                  color: Colors.black,
                )),
            Text("Age:   " + tree.age.toString(),
                style: new TextStyle(
                  fontSize: 20.0,
                  color: Colors.black,
                )),
            Text("Area:   " + tree.area.toString(),
                style: new TextStyle(
                  fontSize: 20.0,
                  color: Colors.black,
                )),
            Text(
                "Kind:" +
                    (tree.isWood
                        ? "Wood"
                        : tree.isGrass
                            ? "Grass"
                            : tree.isFruit
                                ? "Fruit"
                                : tree.isFlower ? "Flower" : "None"),
                style: new TextStyle(
                  fontSize: 20.0,
                  color: Colors.black,
                )),
            Text("Record:" + tree.area.toString(),
                style: new TextStyle(
                  fontSize: 20.0,
                  color: Colors.black,
                )),
            new Container(
              height: 150,
              width: 250,
              margin: const EdgeInsets.all(15.0),
              padding: const EdgeInsets.all(3.0),
              decoration:
                  BoxDecoration(border: Border.all(color: Colors.blueAccent)),
              child: ListView.builder(
                  itemCount: tree.record.split("/").length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text('${tree.record.split("/")[index]}'),
                    );
                  }),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                FlatButton.icon(
                  color: Colors.red,
                  icon: Icon(Icons.comment),
                  label: Text('Comment'),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ListComment(tree.comment)),
                    );
                  },
                ),
                FlatButton.icon(
                  color: Colors.green,
                  icon: Icon(Icons.work),
                  label: Text('Record      '),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => AddRecord(tree)),
                    );
                  },
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
