import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pwd/model/bean/password_item.dart';
import 'package:flutter_pwd/res/dimens.dart';
import 'package:flutter_pwd/res/strings.dart';
import 'package:flutter_pwd/utils/app_utils.dart';

class EditPage extends StatefulWidget {
  final PasswordItem passwordItem;

  EditPage({Key key, this.passwordItem}) : super(key: key);

  @override
  _EditPageState createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {
  bool _isObscure = true;
  bool _isHide = true;
  Color _eyeColor = Colors.grey;
  PasswordProvider _pwProvider = PasswordProvider();

  TextEditingController _infoController = TextEditingController();
  TextEditingController _accountController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  _save(BuildContext context) {
    // 取消焦点
    FocusScope.of(context).requestFocus(FocusNode());
    if (Form.of(context).validate()) {
      String info = _infoController.value.text.toString().trim();
      String account = _accountController.value.text.toString().trim();
      String pwd = _passwordController.value.text.toString().trim();
      if (widget.passwordItem != null) {
        widget.passwordItem.title = info;
        widget.passwordItem.account = account;
        widget.passwordItem.password = pwd;
        widget.passwordItem.visible = !_isHide;
        _pwProvider.update(widget.passwordItem).then((count) {
          if (count == 1) {
            Scaffold.of(context).showSnackBar(SnackBar(
              content: Text('${widget.passwordItem.title}修改成功'),
            ));
            Timer(Duration(seconds: 2), () {
              Navigator.of(context).pop(widget.passwordItem);
            });
          } else {
            Scaffold.of(context).showSnackBar(SnackBar(
              content: Text('${widget.passwordItem.title}修改失败'),
            ));
          }
        });
      } else {
        _pwProvider
            .insert(PasswordItem(info, '', account, pwd, !_isHide))
            .then((value) {
          Scaffold.of(context).showSnackBar(SnackBar(
            content: Text('${value.title}添加成功'),
          ));
          Timer(Duration(seconds: 2), () {
            Navigator.of(context).pop(value);
          });
        });
      }
    }
  }

  @override
  void initState() {
    if (widget.passwordItem != null) {
      _infoController.text = widget.passwordItem.title ?? '';
      _accountController.text = widget.passwordItem.account ?? '';
      _passwordController.text = widget.passwordItem.password ?? '';
      _isHide = !widget.passwordItem.visible ?? false;
      _isObscure = _isHide;
      _eyeColor = !_isObscure ? Colors.blue : Colors.grey;
    }
    super.initState();
//    _pwProvider.open();
  }

  @override
  void dispose() {
    _pwProvider.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppUtils.getString(context, Ids.titleEditPage)),
      ),
      body: SingleChildScrollView(
        child: Container(
          color: Colors.white,
          margin: EdgeInsets.only(top: Dimens.dp10),
          padding: EdgeInsets.all(Dimens.dp16),
          child: Form(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  '保存的密码详细信息：',
                  style: TextStyle(
                      color: Colors.grey,
                      fontSize: Dimens.sp18,
                      fontWeight: FontWeight.w400),
                ),
                SizedBox(
                  height: Dimens.dp20,
                ),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: TextFormField(
                        controller: _infoController,
                        autofocus: false,
                        keyboardType: TextInputType.text,
                        textInputAction: TextInputAction.next,
                        validator: (value) =>
                            value.isEmpty ? '请输入网站/应用信息' : null,
                        decoration: InputDecoration(
                          labelText: '网站/应用信息',
                          hintText: '请输入网站/应用信息',
                          labelStyle: TextStyle(
                            fontSize: Dimens.sp16,
                          ),
                          hintStyle: TextStyle(
                            color: Colors.grey,
                            fontSize: Dimens.sp16,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: Dimens.dp16,
                ),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: TextFormField(
                        controller: _accountController,
                        autofocus: false,
                        validator: (value) => value.isEmpty ? '请输入账号' : null,
                        keyboardType: TextInputType.text,
                        textInputAction: TextInputAction.next,
                        decoration: InputDecoration(
                          labelText: '账号',
                          hintText: '账号',
                          labelStyle: TextStyle(
                            fontSize: Dimens.sp16,
                          ),
                          hintStyle: TextStyle(
                            color: Colors.grey,
                            fontSize: Dimens.sp16,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: Dimens.dp16,
                ),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: TextFormField(
                        controller: _passwordController,
                        autofocus: false,
                        obscureText: _isObscure,
                        validator: (value) => value.isEmpty ? '请输入密码' : null,
                        scrollPadding: EdgeInsets.all(10),
                        onEditingComplete: () => Builder(builder: (context) {
                          return _save(context);
                        }),
                        decoration: InputDecoration(
                            labelText: '密码',
                            hintText: '密码',
                            labelStyle: TextStyle(
                              fontSize: Dimens.sp16,
                            ),
                            hintStyle: TextStyle(
                              color: Colors.grey,
                              fontSize: Dimens.sp16,
                            ),
                            suffixIcon: IconButton(
                                icon: Icon(
                                  Icons.remove_red_eye,
                                  color: _eyeColor,
                                ),
                                onPressed: () {
                                  setState(() {
                                    _isObscure = !_isObscure;
                                    _eyeColor =
                                        !_isObscure ? Colors.blue : Colors.grey;
                                  });
                                })),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: Dimens.dp16,
                ),
                CheckboxListTile(
                  value: _isHide,
                  title: Text(
                    '隐藏密码：',
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: Dimens.sp14,
                    ),
                  ),
                  onChanged: (bool) {
                    setState(() {
                      _isHide = bool;
                    });
                  },
                ),
                SizedBox(
                  height: Dimens.dp100,
                ),
                _renderSaveButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _renderSaveButton() {
    return Center(
      child: Row(
        children: <Widget>[
          Expanded(
            child: Builder(builder: (context) {
              return RaisedButton(
                onPressed: () => _save(context),
                color: Colors.blue,
                textColor: Colors.white,
                disabledColor: Colors.grey,
                disabledTextColor: Colors.black,
                padding: EdgeInsets.all(Dimens.dp8),
                splashColor: Colors.blueAccent,
                child: Text('保存'),
              );
            }),
          )
        ],
      ),
    );
  }
}
