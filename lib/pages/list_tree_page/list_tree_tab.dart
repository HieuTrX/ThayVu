import 'package:demo/models/Tree.dart';
import 'package:demo/pages/list_tree_page/add_tree.dart';
import 'package:demo/pages/list_tree_page/detail_tree.dart';
import 'package:flutter/material.dart';

class ListTreeTab extends StatelessWidget {
  List<Tree> list;
  ListTreeTab({Key key, this.list}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildList(list),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => NewTask()),
          );
        },
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }

  Widget _buildList(List<Tree> list) {
    return ListView.builder(
        itemCount: list.length,
        padding: const EdgeInsets.all(16.0),
        itemBuilder: (context, index) {
          return ListTile(
            title: Text('${list[index].name}'),
            onTap: () {
              print(list[index].toString());
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DetailTree(tree: list[index]),
                ),
              );
            },
          );
        });
  }
}
