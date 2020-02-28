import 'package:flutter_pwd/utils/crypto_utils.dart';
import 'package:sqflite/sqflite.dart';

final String tablePw = "_pw";
final String cId = "_id";
final String cTitle = "title";
final String cUrl = "url";
final String cAccount = "account";
final String cPassword = "password";
final String cVisible = "visible";

class PasswordItem {
  int id;
  String title;
  String url;
  String account;
  String password;
  bool visible;

  PasswordItem(this.title, this.url, this.account, this.password, this.visible);

  PasswordItem.fromMap(Map map) {
    id = map[cId] as int;
    title = map[cTitle] as String;
    url = map[cUrl] as String;
    account = map[cAccount] as String;
    password = map[cPassword] as String;
    visible = map[cVisible] == 1;
  }

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      cTitle: title,
      cUrl: url,
      cAccount: account,
      cPassword: password,
      cVisible: visible == true ? 1 : 0,
    };
    if (id != null) {
      map[cId] = id;
    }
    return map;
  }
}

class PasswordProvider {
  Database db;

  Future open() async {
    db = await openDatabase("path", version: 1, onCreate: (db, version) async {
      await db.execute('''
        create table $tablePw ( 
          $cId integer primary key autoincrement, 
          $cTitle text not null,
          $cUrl text,
          $cAccount text not null,
          $cPassword text not null,
          $cVisible integer not null)
        ''');
    });
  }

  Future close() async {
    if (db != null) {
      db.close();
    }
  }

  Future<PasswordItem> insert(PasswordItem item) async {
    if (db == null) {
      await open();
    }
    item.password = await CryptoUtils.encrypt(item.password);
    item.id = await db.insert(tablePw, item.toMap());
    item.password = await CryptoUtils.decrypt(item.password);
    return item;
  }

  Future<List<PasswordItem>> query(String content) async {
    if (content.isNotEmpty) {
      if (db == null) {
        await open();
      }
      List<Map<String, dynamic>> maps = await db.query(tablePw,
          columns: [cId, cTitle, cUrl, cAccount, cPassword, cVisible],
          where: "$cTitle like ? or $cUrl like ? or $cAccount like ? ",
          whereArgs: ['%$content%', '%$content%', '%$content%']);
      if (maps.isNotEmpty) {
        List<PasswordItem> items = [];
        for (var value in maps) {
          PasswordItem item = PasswordItem.fromMap(value);
          item.password = await CryptoUtils.decrypt(item.password);
          items.add(item);
        }
        return items;
      }
      return null;
    } else {
      return queryAll();
    }
  }

  Future<List<PasswordItem>> queryAll() async {
    if (db == null) {
      await open();
    }
    List<Map<String, dynamic>> maps = await db.query(tablePw,
        columns: [cId, cTitle, cUrl, cAccount, cPassword, cVisible]);
    if (maps.length > 0) {
      List<PasswordItem> list = List();
      for (int i = maps.length; i > 0; i--) {
        PasswordItem item = PasswordItem.fromMap(maps[i - 1]);
        item.password = await CryptoUtils.decrypt(item.password);
        list.add(item);
      }

      return list;
    }
    return null;
  }

  Future<int> delete(int id) async {
    if (db == null) {
      await open();
    }
    return await db.delete(tablePw, where: "$cId = ?", whereArgs: [id]);
  }

  Future<int> update(PasswordItem item) async {
    if (db == null) {
      await open();
    }
    item.password = await CryptoUtils.encrypt(item.password);
    int count = await db
        .update(tablePw, item.toMap(), where: "$cId = ?", whereArgs: [item.id]);
    item.password = await CryptoUtils.decrypt(item.password);
    return count;
  }
}
