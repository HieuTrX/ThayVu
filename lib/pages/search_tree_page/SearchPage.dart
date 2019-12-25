import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demo/models/Tree.dart';
import 'package:demo/pages/list_tree_page/detail_tree.dart';
import 'package:demo/services/FirestoreService.dart';
import 'package:flutter/material.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => new _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _filter = new TextEditingController();
  FirestoreService fireService = new FirestoreService();
  List _cities = ["chosen", "name", "area"];
  List _items;
  List<DropdownMenuItem<String>> _dropDownMenuItems;
  String _currentCity;

  String _searchText = "";
  List trees = new List();
  List filteredNames = new List();
  Icon _searchIcon = new Icon(Icons.search);
  Widget _appBarTitle;

  _SearchPageState() {
    _filter.addListener(() {
      if (_filter.text.isEmpty) {
        setState(() {
          _searchText = "";
          filteredNames = trees;
        });
      } else {
        setState(() {
          _searchText = _filter.text;
        });
      }
    });
  }
  @override
  void initState() {
    super.initState();

    _dropDownMenuItems = getDropDownMenuItems();
    _currentCity = _dropDownMenuItems[0].value;
    _items = _dropDownMenuItems;
    _appBarTitle = new DropdownButton(
      value: _cities[0].toString(),
      items: _items,
      onChanged: changedDropDownItem,
    );

    var todolists = fireService.getTreeList().listen((QuerySnapshot snapshot) {
      final List<Tree> tasks = snapshot.documents
          .map((documentSnapshot) => Tree.fromMap(documentSnapshot.data))
          .toList();
      setState(() {
        this.trees = tasks;
      });
    });
    print(trees);
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildBar(context),
      body: Container(
        child: _buildList(),
      ),
      resizeToAvoidBottomPadding: false,
    );
  }

  Widget _buildBar(BuildContext context) {
    return new AppBar(
      centerTitle: true,
      title: _appBarTitle,
      leading: new IconButton(
        icon: _searchIcon,
        onPressed: _searchPressed,
      ),
    );
  }

  void _searchPressed() {
    setState(() {
      if (this._searchIcon.icon == Icons.search) {
        this._searchIcon = new Icon(Icons.close);
        this._appBarTitle = new TextField(
          controller: _filter,
          decoration: new InputDecoration(
              prefixIcon: new Icon(Icons.search), hintText: 'Search...'),
        );
      } else {
        this._searchIcon = new Icon(Icons.search);
        this._appBarTitle = new DropdownButton(
          value: _currentCity,
          items: _dropDownMenuItems,
          onChanged: changedDropDownItem,
        );
        filteredNames = trees;
        _filter.clear();
      }
    });
  }

  Widget _buildList() {
    if (!(_searchText.isEmpty)) {
      List tempList = new List();
      if (_currentCity == "name") {
        for (int i = 0; i < filteredNames.length; i++) {
          if (filteredNames[i].name.contains(_searchText)) {
            print("da tim");
            tempList.add(filteredNames[i]);
          }
        }
      } else {
        for (int i = 0; i < filteredNames.length; i++) {
          if (filteredNames[i].area.contains(_searchText)) {
            print("da tim");
            tempList.add(filteredNames[i]);
          }
        }
      }

      print(tempList.toString());
      filteredNames = tempList;
    }
    return ListView.builder(
      itemCount: filteredNames == null ? 0 : filteredNames.length,
      itemBuilder: (BuildContext context, int index) {
        return ListTile(
            title: Text('${filteredNames[index].name}'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DetailTree(tree: filteredNames[index]),
                ),
              );
            });
      },
    );
  }

  List<DropdownMenuItem<String>> getDropDownMenuItems() {
    List<DropdownMenuItem<String>> items = new List();
    return _cities.map((data) {
      return DropdownMenuItem<String>(
        child: new Text(data),
        value: data,
      );
    }).toList();
  }

  void changedDropDownItem(String selectedCity) async {
    print("Selected city $selectedCity, we are going to refresh the UI");
    await setState(() {
      _cities[0] = selectedCity;
      _items = _cities;
      _currentCity = selectedCity;
    });
    print(_items.toString());
    this.setState(() {});

    this._appBarTitle = new DropdownButton(
      value: _currentCity,
      items: _dropDownMenuItems,
      onChanged: changedDropDownItem,
    );
  }
}
