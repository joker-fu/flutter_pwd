import 'package:flutter/material.dart';
import 'package:flutter_pwd/res/dimens.dart';
import 'package:flutter_pwd/res/strings.dart';
import 'package:flutter_pwd/ui/pages/main/home/edit_page.dart';
import 'package:flutter_pwd/ui/pages/main/home/home_page.dart';
import 'package:flutter_pwd/ui/pages/main/me/me_page.dart';
import 'package:flutter_pwd/ui/widget/bottom_app_bar_item.dart';
import 'package:flutter_pwd/utils/app_utils.dart';
import 'package:flutter_pwd/utils/router_utils.dart';

class MainPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MainPageState();
  }
}

class _MainPageState extends State<MainPage> {
  var _currentIndex = 0;
  final GlobalKey<HomePageState> hpKey = GlobalKey<HomePageState>();
  final List<Widget> _bodyWidgets = List();

  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  List<Widget> _renderActions() {
    return _currentIndex == 0
        ? <Widget>[
            IconButton(
                icon: Icon(
                  Icons.search,
                  color: Colors.white,
                ),
                onPressed: null)
          ]
        : <Widget>[];
  }

  @override
  void initState() {
    super.initState();
    _bodyWidgets.add(HomePage(key: hpKey));
    _bodyWidgets.add(MePage());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppUtils.getString(context, Ids.appName)),
        actions: _renderActions(),
      ),
      body: _bodyWidgets.elementAt(_currentIndex),
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        notchMargin: Dimens.dp4,
        color: Colors.white,
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            BottomAppBarItem(
              icon: Icons.home,
              name: AppUtils.getString(context, Ids.appHome),
              selectedColor: Colors.blue,
              unselectedColor: Colors.black54,
              selected: _currentIndex == 0,
              onTap: () => _onItemTapped(0),
            ),
            BottomAppBarItem(
              icon: Icons.account_box,
              name: AppUtils.getString(context, Ids.appMe),
              selectedColor: Colors.blue,
              unselectedColor: Colors.black54,
              selected: _currentIndex == 1,
              onTap: () => _onItemTapped(1),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          RouteUtils.push(context, EditPage()).then((value) {
            if (value != null) hpKey.currentState.addData(value);
          });
        },
        tooltip: 'new',
        child: Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
//      bottomNavigationBar: BottomNavigationBar(
//        onTap: _onItemTapped,
//        items: [
//          BottomNavigationBarItem(
//              icon: Icon(Icons.home),
//              title: Text(AppUtils.getString(context, Ids.appHome))),
//          BottomNavigationBarItem(
//              icon: Icon(Icons.account_box),
//              title: Text(AppUtils.getString(context, Ids.appMe))),
//        ],
//        currentIndex: _currentIndex,
//        selectedFontSize: Dimens.sp14,
//        unselectedFontSize: Dimens.sp14,
//        backgroundColor: Colors.white,
//      ),
    );
  }
}
