import 'package:flutter/material.dart';
import 'package:flutter_pwd/model/bean/password_item.dart';
import 'package:flutter_pwd/res/dimens.dart';

class ItemPasswordWidget extends StatefulWidget {
  final PasswordItem item;

  const ItemPasswordWidget(this.item, {Key key}) : super(key: key);

  @override
  _ItemPasswordWidgetState createState() => _ItemPasswordWidgetState();
}

class _ItemPasswordWidgetState extends State<ItemPasswordWidget> {
  bool _isObscure = true;
  Color _eyeColor = Colors.grey;

  @override
  void initState() {
    _isObscure = widget.item.visible == false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(Dimens.dp12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            widget.item.title,
            style: TextStyle(
              color: Colors.grey,
              fontSize: Dimens.sp18,
              fontWeight: FontWeight.w400,
            ),
          ),
          SizedBox(
            height: Dimens.dp16,
          ),
          Text(
            '账号：${widget.item.account}',
            style: TextStyle(
              color: Colors.black87,
              fontSize: Dimens.sp16,
            ),
          ),
          SizedBox(
            height: Dimens.dp8,
          ),
          Row(
            children: <Widget>[
              Text(
                '密码：${_isObscure ? '********' : widget.item.password}',
                style: TextStyle(
                  color: Colors.black87,
                  fontSize: Dimens.sp16,
                ),
              ),
              IconButton(
                  icon: Icon(
                    Icons.remove_red_eye,
                    color: _eyeColor,
                  ),
                  onPressed: () {
                    setState(() {
                      _isObscure = !_isObscure;
                      _eyeColor = !_isObscure ? Colors.blue : Colors.grey;
                    });
                  }),
            ],
          ),
        ],
      ),
    );
  }
}
