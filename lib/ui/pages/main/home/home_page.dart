import 'package:flutter/material.dart';
import 'package:flutter_pwd/ui/widget/common_card.dart';

import '../../../../res/dimens.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Widget _renderItem(BuildContext context, int index) {
    return InkWell(
      child: CommonCard(
          child: Padding(
        padding: EdgeInsets.all(Dimens.dp12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'www.baidu.com',
              style: TextStyle(
                  color: Colors.grey,
                  fontSize: Dimens.sp18,
                  fontWeight: FontWeight.w400),
            ),
            SizedBox(
              height: Dimens.dp16,
            ),
            Text(
              '账号：aaaaaa',
              style: TextStyle(color: Colors.black87, fontSize: Dimens.sp16),
            ),
            SizedBox(
              height: Dimens.dp8,
            ),
            Text(
              '密码：*****************',
              style: TextStyle(color: Colors.black87, fontSize: Dimens.sp16),
            ),
          ],
        ),
      )),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemBuilder: _renderItem,
        itemCount: 20,
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
