import 'package:flutter/material.dart';
import 'package:flutter_pwd/model/bean/password_item.dart';
import 'package:flutter_pwd/ui/widget/common_card.dart';

import '../../../../res/dimens.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  PasswordProvider _pwProvider = PasswordProvider();

  List<PasswordItem> data = List();

  Widget _renderItem(BuildContext context, int index) {
    PasswordItem item = data[index];
    return InkWell(
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
              '密码：${item.password}',
              style: TextStyle(color: Colors.black87, fontSize: Dimens.sp16),
            ),
          ],
        ),
      )),
    );
  }

  @override
  void initState() {
    super.initState();
    _pwProvider.open().then((_) {
      _pwProvider.getAll().then((list) {
        setState(() {
          data = list;
        });
        for (var item in list) {
          print('${item.title}-${item.account}-${item.password}');
        }
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
        itemCount: data.length,
      ),
//      floatingActionButton: FloatingActionButton(
//        onPressed: () {},
//        tooltip: "new",
//        child: Icon(Icons.add),
//        isExtended: true,
//      ),
    );
  }
}
