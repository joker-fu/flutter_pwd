import 'package:flutter/material.dart';
import 'package:flutter_pwd/res/dimens.dart';
import 'package:flutter_pwd/res/strings.dart';
import 'package:flutter_pwd/utils/app_utils.dart';

class EditPage extends StatefulWidget {
  @override
  _EditPageState createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {
  bool _isObscure = true;
  Color _eyeColor = Colors.grey;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppUtils.getString(context, Ids.titleEditPage)),
      ),
      body: SingleChildScrollView(
          child: Card(
        margin: EdgeInsets.only(top: Dimens.dp10),
        child: Container(
          color: Colors.white,
          padding: EdgeInsets.all(Dimens.dp16),
          child: Column(
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
                      onSaved: (String value) => {},
                      keyboardType: TextInputType.text,
                      validator: (String value) {
                        if (value.isEmpty) {
                          return '请输入网站';
                        }
                      },
                      decoration: InputDecoration(
                        labelText: '网站',
                        hintText: '网站',
                        contentPadding: EdgeInsets.all(Dimens.dp12),
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
                      onSaved: (String value) => {},
                      validator: (String value) {
                        if (value.isEmpty) {
                          return '请输入账号';
                        }
                      },
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        labelText: '账号',
                        hintText: '账号',
                        contentPadding: EdgeInsets.all(Dimens.dp12),
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
                      onSaved: (String value) => {},
                      obscureText: _isObscure,
                      validator: (String value) {
                        if (value.isEmpty) {
                          return '请输入密码';
                        }
                      },
                      decoration: InputDecoration(
                          labelText: '密码',
                          hintText: '密码',
                          contentPadding: EdgeInsets.all(Dimens.dp12),
                          suffixIcon: IconButton(
                              icon: Icon(
                                Icons.remove_red_eye,
                                color: _eyeColor,
                              ),
                              onPressed: () {
                                setState(() {
                                  _isObscure = !_isObscure;
                                  _eyeColor = !_isObscure ? Colors.blue : Colors.grey;
                                });
                              })),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: Dimens.dp100,
              ),
              Center(
                child: RaisedButton(
                  onPressed: () => {},
                  color: Colors.blue,
                  textColor: Colors.white,
                  disabledColor: Colors.grey,
                  disabledTextColor: Colors.black,
                  padding: EdgeInsets.all(Dimens.dp8),
                  splashColor: Colors.blueAccent,
                  child: Text('保存'),
                ),
              )
            ],
          ),
        ),
      )),
    );
  }
}
