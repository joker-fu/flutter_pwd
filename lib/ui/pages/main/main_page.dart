import 'package:csv/csv.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_pwd/model/bean/password_item.dart';
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
  final GlobalKey<HomePageState> hpKey = GlobalKey<HomePageState>();

  final List<Widget> _bodyWidgets = List();

  var _currentIndex = 0;

  bool _isSearch = false;

  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  List<Widget> _renderActions() {
    return _currentIndex == 0 && !_isSearch
        ? [
            IconButton(
                icon: Icon(
                  Icons.import_export,
                  color: Colors.white,
                ),
                onPressed: () => _importDataByCsv()),
            IconButton(
                icon: Icon(
                  Icons.search,
                  color: Colors.white,
                ),
                onPressed: () {
                  setState(() {
                    _isSearch = true;
                  });
                }),
          ]
        : [];
  }

  /// 导入数据
  _importDataByCsv() {
    rootBundle.loadString('assets/pwd.csv').then((data) {
      PasswordProvider _pwProvider = PasswordProvider();

      var list = CsvToListConverter().convert(data).reversed.toList();

      for (var entity in list.getRange(0, list.length - 1)) {
        //print('---->$entity');
        var item = PasswordItem(
          '${entity[0]}',
          '${entity[1]}',
          '${entity[2]}',
          '${entity[3]}',
          false,
        );
        _pwProvider.insert(item).then((value) {
          hpKey.currentState.addData(item);
        }).catchError((e) {
          print('-->${e.toString()}');
        });
      }
    }).catchError((e) {
      print('-->${e.toString()}');
    });
  }

  @override
  void initState() {
    _bodyWidgets.add(HomePage(key: hpKey));
    _bodyWidgets.add(MePage());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: _isSearch
            ? AnimatedContainer(
                duration: Duration(milliseconds: 300),
                margin: const EdgeInsets.all(16),
                width: _isSearch ? double.infinity : 0,
                child: TextField(
                  autofocus: true,
                  keyboardType: TextInputType.text,
                  cursorColor: Colors.white,
                  textInputAction: TextInputAction.search,
                  style: const TextStyle(color: Colors.white),
                  decoration: const InputDecoration(
                    hintText: '搜索',
                    hintStyle: const TextStyle(color: Colors.white),
                    border: InputBorder.none,
                  ),
                  //onChanged: _toSearch,
                  onSubmitted: _toSearch,
                ),
              )
            : Text(AppUtils.getString(context, Ids.appName)),
        actions: _renderActions(),
      ),
      body: IndexedStack(
        index: _currentIndex,
        children: _bodyWidgets,
      ),
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
      floatingActionButton: _isSearch
          ? null
          : FloatingActionButton(
              onPressed: () {
                RouteUtils.push(context, EditPage()).then((value) {
                  if (value != null) hpKey.currentState.addData(value);
                });
              },
              tooltip: 'new',
              child: Icon(Icons.add),
            ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  _toSearch(String content) {
    hpKey.currentState.toSearch(content);
    setState(() {
      _isSearch = false;
    });
  }
}
