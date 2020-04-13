import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:score_mama/src/providers/data_provider.dart';

class TestPage extends StatefulWidget {
  @override
  _TestPageState createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  List<dynamic> _frecuenciaCardiacaList = new List();
  List<dynamic> _frecuenciaCardiacaItems;
  String _frecuenciaCardiacaActual;
  String _presionSistolicaActual;

  int selected = 0;
  List<Widget> _fc = new List();

  // void _createVariables(items, variable){
  //   items.forEach((item) {
  //     setState(() {
  //       _frecuenciaCardiacaList.add(item['range']);
  //       if (item['score'] == 0) {
  //         _frecuenciaCardiacaActual = item['range'];
  //       }
  //     });
  //   });
  // }

  void _loadData() async {
    _frecuenciaCardiacaItems = await dataProvider.loadFrecuenciaCardiaca();
    _frecuenciaCardiacaList = _frecuenciaCardiacaItems.map((item) {
      if (item['score'] == 0) _frecuenciaCardiacaActual = item['range'];
      return item['range'];
    }).toList();
    setState(() {});
  }

  @override
  void initState() {
    _fc = _createList(56, 100);
    _loadData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Testing Page'),
            SizedBox(height: 30.0),
            FlatButton(
              onPressed: () => _picker(context),
              child: Text('Click'),
            ),
            _fc[selected],
            DropdownButton(
              value: _frecuenciaCardiacaActual,
              items: getDropdownOptions(),
              onChanged: (picked) {
                setState(() {
                  _frecuenciaCardiacaActual = picked;
                });
              },
            )
          ],
        ),
      ),
    );
  }

  List<DropdownMenuItem<String>> getDropdownOptions() {
    List<DropdownMenuItem<String>> list = new List();

    _frecuenciaCardiacaList.forEach((item) {
      list.add(DropdownMenuItem(
        child: Text(item),
        value: item,
      ));
    });

    return list;
  }

  _picker(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Scaffold(
          appBar: AppBar(
            title: Text('Title'),
          ),
          body: CupertinoPicker(
            itemExtent: 30.0,
            onSelectedItemChanged: (value) {
              setState(() {
                selected = value;
              });
            },
            children: _fc,
          ),
        );
      },
    );
  }

  List<Widget> _createList(int a, int b) {
    List<Widget> _localList = new List();
    for (var i = a; i <= b; i++) {
      _localList.add(Text(i.toString()));
    }
    _localList.insert(0, Text('< $a'));
    _localList.add(Text('>$b'));

    return _localList;
  }
  // Map<int, Widget> map =
  //     new Map(); // Cupertino Segmented Control takes children in form of Map.
  // List<Widget>
  //     childWidgets; //The Widgets that has to be loaded when a tab is selected.
  // int selectedIndex = 0;

  // @override
  // void initState() {
  //   super.initState();
  //   loadCupertinoTabs(); //Method to add Tabs to the Segmented Control.
  //   loadChildWidgets(); //Method to add the Children as user selected.
  // }

  // @override
  // Widget build(BuildContext context) {
  //   return SafeArea(
  //     child: Column(
  //       children: <Widget>[
  //         CupertinoSegmentedControl(
  //           onValueChanged: (value) {
  //             //Callback function executed when user changes the Tabs
  //             setState(() {
  //               selectedIndex = value;
  //             });
  //           },
  //           groupValue: selectedIndex, //The current selected Index or key
  //           // selectedColor: Colors.blue,
  //           // pressedColor: Colors.red,
  //           unselectedColor: Colors.grey,
  //           children: map,
  //           padding: EdgeInsets.all(10),
  //           borderColor: Colors.white,
  //         ),
  //         Expanded(
  //           child: getChildWidget(),
  //         ),
  //       ],
  //     ),
  //   );
  // }

  // void loadCupertinoTabs() {
  //   map = new Map();
  //   for (int i = 0; i < 4; i++) {
  //     //putIfAbsent takes a key and a function callback that has return a value to that key.
  //     // In our example, since the Map is of type <int,Widget> we have to return widget.
  //     map.putIfAbsent(
  //       i,
  //       () => Container(
  //         width: 100,
  //         child: Text(
  //           "Tab $i",
  //           style: TextStyle(color: Colors.white),
  //         ),
  //       ),
  //     );
  //   }
  // }

  // void loadChildWidgets() {
  //   childWidgets = [];
  //   for (int i = 0; i < 4; i++)
  //     childWidgets.add(
  //       Center(
  //         child: Text(
  //           "child $i",
  //         ),
  //       ),
  //     );
  // }

  // Widget getChildWidget() => childWidgets[selectedIndex];
}
