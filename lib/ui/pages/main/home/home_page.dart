import 'package:flutter/material.dart';
import 'package:flutter_pwd/model/bean/password_item.dart';
import 'package:flutter_pwd/ui/widget/common_card.dart';
import 'package:flutter_pwd/ui/widget/common_dialog.dart';

import '../../../../res/dimens.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  PasswordProvider _pwProvider = PasswordProvider();

  List<PasswordItem> _data = List();

  void addData(PasswordItem element) {
    setState(() {
      _data.insert(0, element);
    });
  }

  Widget _renderItem(BuildContext context, int index) {
    PasswordItem item = _data[index];
    return InkWell(
      onTap: () => print('tap'),
      onLongPress: () => _longPress(context, item),
      child: CommonCard(
        child: Padding(
          padding: EdgeInsets.all(Dimens.dp12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                item.title,
                style: TextStyle(
                    color: Colors.grey,
                    fontSize: Dimens.sp18,
                    fontWeight: FontWeight.w400),
              ),
              SizedBox(
                height: Dimens.dp16,
              ),
              Text(
                '账号：${item.account}',
                style: TextStyle(color: Colors.black87, fontSize: Dimens.sp16),
              ),
              SizedBox(
                height: Dimens.dp8,
              ),
              Text(
                '密码：${item.visible ? item.password : '********'}',
                style: TextStyle(color: Colors.black87, fontSize: Dimens.sp16),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _pwProvider.open().then((_) {
      _pwProvider.queryAll().then((list) {
        setState(() {
          _data = list;
        });
      });
    });
  }

  @override
  void dispose() {
    _pwProvider.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemBuilder: _renderItem,
        itemCount: _data == null ? 0 : _data.length,
      ),
//      floatingActionButton: FloatingActionButton(
//        onPressed: () {},
//        tooltip: "new",
//        child: Icon(Icons.add),
//        isExtended: true,
//      ),
    );
  }

  _longPress(BuildContext context, PasswordItem item) {
    CommonDialog.show(
      context,
      Text('确定删除${item.title}记录'),
      onYes: () {
        _pwProvider.delete(item.id).then((value) {
          setState(() {
            _data.remove(item);
          });
          Scaffold.of(context).showSnackBar(SnackBar(content: Text('删除成功')));
        });
      },
    );
  }
}
