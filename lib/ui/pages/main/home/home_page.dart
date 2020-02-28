import 'package:flutter/material.dart';
import 'package:flutter_pwd/model/bean/password_item.dart';
import 'package:flutter_pwd/ui/pages/main/home/edit_page.dart';
import 'package:flutter_pwd/ui/widget/common_card.dart';
import 'package:flutter_pwd/ui/widget/common_dialog.dart';
import 'package:flutter_pwd/ui/widget/item_password_widget.dart';
import 'package:flutter_pwd/utils/router_utils.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> with AutomaticKeepAliveClientMixin {
  PasswordProvider _pwProvider = PasswordProvider();

  List<PasswordItem> _data = List();

  @override
  void initState() {
    super.initState();
    _pwProvider.queryAll().then((list) {
      setState(() {
        _data = list ?? List();
      });
    }).catchError((e) {
      print('${e.toString()}');
    });
  }

  @override
  void dispose() {
    _pwProvider.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      body: ListView.builder(
        itemBuilder: _renderItem,
        itemCount: _data == null ? 0 : _data.length,
      ),
    );
  }

  void addData(PasswordItem element) {
    setState(() {
      _data.insert(0, element);
    });
  }

  void updateData(PasswordItem element) {
    setState(() {
      int index = _data.indexWhere((item) {
        return element.id == item.id;
      });
      if (index != -1) {
        _data.removeAt(index);
        _data.insert(index, element);
      }
    });
  }

  Widget _renderItem(BuildContext context, int index) {
    PasswordItem item = _data[index];
    return CommonCard(
      child: InkWell(
        onTap: () => _onTap(context, item),
        onLongPress: () => _onLongPress(context, item),
        child: ItemPasswordWidget(item),
      ),
    );
  }

  void _onTap(BuildContext context, PasswordItem item) {
    RouteUtils.push(context, EditPage(passwordItem: item)).then((value) {
      if (value != null) updateData(value);
    });
  }

  void _onLongPress(BuildContext context, PasswordItem item) {
    CommonDialog.show(
      context,
      Text('确定删除${item.title}记录'),
      onYes: () {
        _pwProvider.delete(item.id).then((value) {
          setState(() {
            _data.remove(item);
          });
          Scaffold.of(context).showSnackBar(SnackBar(
            content: Text('删除成功'),
          ));
        });
      },
    );
  }

  void toSearch(String content) {
    _pwProvider.query(content).then((list) {
      setState(() {
        _data.clear();
        _data.addAll(list ?? []);
      });
    }).catchError((e) {
      print('${e.toString()}');
    });
  }

  @override
  bool get wantKeepAlive => true;
}
