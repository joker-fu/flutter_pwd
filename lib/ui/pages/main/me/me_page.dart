import 'package:flutter/material.dart';
import 'package:flutter_pwd/res/dimens.dart';
import 'package:flutter_pwd/ui/pages/main/me/safe_setting_page.dart';
import 'package:flutter_pwd/utils/router_utils.dart';

class MePage extends StatefulWidget {
  @override
  _MePageState createState() => _MePageState();
}

class _MePageState extends State<MePage> with AutomaticKeepAliveClientMixin{
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return ListView.separated(
      separatorBuilder: (context, index) => Divider(
        height: Dimens.dp1_2,
        indent: Dimens.dp12,
        endIndent: Dimens.dp12,
        color: routeNames.elementAt(index) == ''
            ? Colors.transparent
            : Colors.grey,
      ),
      itemBuilder: _renderItem,
      itemCount: routeNames.length,
    );
  }

  Widget _renderItem(BuildContext context, int index) {
    String item = routeNames.elementAt(index);
    return item == ''
        ? SizedBox(
            height: 10,
          )
        : InkWell(
            onTap: () {
              if (index == 1) {
                RouteUtils.push(context, SafeSettingPage());
              }
            },
            child: Container(
              padding: EdgeInsets.symmetric(
                vertical: Dimens.dp10,
                horizontal: Dimens.dp16,
              ),
              height: Dimens.dp50,
              color: Colors.white,
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Text(routeNames.elementAt(index)),
                  ),
                  Icon(
                    Icons.keyboard_arrow_right,
                    color: Colors.grey,
                  )
                ],
              ),
            ));
  }


  @override
  bool get wantKeepAlive => true;
}

const routeNames = ["", "安全设置", "关于"];
