import 'package:flutter/material.dart';
import 'package:flutter_pwd/res/Strings.dart';
import 'package:flutter_pwd/utils/app_utils.dart';

class MainPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MainPageState();
  }
}

class _MainPageState extends State<MainPage> {
  var _currentIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppUtils.getString(context, Ids.appName)),
      ),
      body: Center(
        child: Text('Center'),
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: _onItemTapped,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), title: Text(AppUtils.getString(context, Ids.appHome))),
          BottomNavigationBarItem(icon: Icon(Icons.account_box), title: Text(AppUtils.getString(context, Ids.appMe))),
        ],
        currentIndex: _currentIndex,
        selectedFontSize: 14.0,
        unselectedFontSize: 14.0,
      ),
    );
  }
}
