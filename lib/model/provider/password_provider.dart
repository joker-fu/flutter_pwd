//import 'package:flutter_pwd/model/bean/password_item.dart';
//import 'package:sqflite/sqflite.dart';
//
//final String tableTodo = "_pw";
//final String cId = "_id";
//final String cTitle = "title";
//final String cAccount = "account";
//final String cPassword = "password";
//final String cVisible = "visible";
//
//class PasswordProvider {
//  Database db;
//
//  Future open() async {
//    db = await openDatabase("path", version: 1, onCreate: (db, version) async {
//      await db.execute('''
//        create table $tableTodo (
//          $cId integer primary key autoincrement,
//          $cTitle text not null,
//          $cAccount text not null,
//          $cPassword text not null,
//          $cVisible integer not null)
//        ''');
//    });
//  }
//
//  Future<PasswordItem> insert(PasswordItem item) async {
//    item.id = await db.insert(tableTodo, item.toMap());
//    return item;
//  }
//
//}
