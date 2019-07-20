import 'package:sqflite/sqflite.dart';

final String tablePw = "_pw";
final String cId = "_id";
final String cTitle = "title";
final String cAccount = "account";
final String cPassword = "password";
final String cVisible = "visible";

class PasswordItem {
  int id;
  String title;
  String account;
  String password;
  bool visible;

  PasswordItem(this.title, this.account, this.password, this.visible);

  PasswordItem.fromMap(Map map) {
    id = map[cId] as int;
    title = map[cTitle] as String;
    account = map[cAccount] as String;
    password = map[cPassword] as String;
    visible = map[cVisible] == 1;
  }

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      cTitle: title,
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
          $cAccount text not null,
          $cPassword text not null,
          $cVisible integer not null)
        ''');
    });
  }

  Future close() async => db.close();

  Future<PasswordItem> insert(PasswordItem item) async {
    item.id = await db.insert(tablePw, item.toMap());
    return item;
  }

  Future<PasswordItem> query(PasswordItem item) async {
    List<Map<String, dynamic>> maps = await db.query(tablePw,
        columns: [cId, cTitle, cAccount, cPassword, cVisible],
        where: "$cTitle = ?",
        whereArgs: [item.title]);
    if (maps.isNotEmpty) {
      return PasswordItem.fromMap(maps.first);
    }
    return null;
  }

  Future<List<PasswordItem>> queryAll() async {
    List<Map<String, dynamic>> maps = await db
        .query(tablePw, columns: [cId, cTitle, cAccount, cPassword, cVisible]);
    if (maps.length > 0) {
      List<PasswordItem> list = List();
//      for (var item in maps) {
//        list.add(PasswordItem.fromMap(item));
//      }
      for (int i = maps.length; i > 0; i--) {
        list.add(PasswordItem.fromMap(maps[i - 1]));
      }

      return list;
    }
    return null;
  }

  Future<int> delete(int id) async {
    return await db.delete(tablePw, where: "$cId = ?", whereArgs: [id]);
  }

  Future<int> update(PasswordItem item) async {
    return await db
        .update(tablePw, item.toMap(), where: "$cId = ?", whereArgs: [item.id]);
  }
}
