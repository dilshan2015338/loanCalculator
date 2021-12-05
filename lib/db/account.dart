import 'dart:ffi';

import 'package:expenses/models/account.dart';
import 'package:expenses/models/employee.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class ExpensesDatabase {
  static final ExpensesDatabase instance = ExpensesDatabase._init();

  static Database? _database;

  ExpensesDatabase._init();

  Future<Database?> get database async {
    if (_database != null) return _database;

    _database = await _initDB("account.db");
    return _database;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 7, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    final idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    final empIdType = "INTEGER";
    final valueInType = "DOUBLE";
    final dateType = "DATETIEM";
    final valueOutType = 'DOUBLE';
    await db.execute('''
    CREATE TABLE $tableAccount (
    ${AccountFields.id} $idType,
    ${AccountFields.empId} $empIdType,
    ${AccountFields.valueIn} $valueInType,
    ${AccountFields.date} $dateType,
    ${AccountFields.valueOut} $valueOutType
    )
    ''');
    await db.execute('''
    CREATE TABLE employee (
    ${AccountFields.id} $idType,
    'employeeName' VARCHAR(255)
    )
    ''');
  }

  Future<Account> create(Account account) async {
    final db = await instance.database;
    final id = await db!.insert(tableAccount, account.toJson());
    return account.copy(id: id);
  }

  Future<Employee> createEmployee(Employee employee) async {
    final db = await instance.database;
    final id = await db!.insert(tableEmployee, employee.toJson());
    return employee.copy(id: id);
  }

  Future<Account> readAccount(int id) async {
    final db = await instance.database;

    final maps = await db!.query(
      tableAccount,
      columns: AccountFields.values,
      where: '${AccountFields.id} = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return Account.fromJson(maps.first);
    } else {
      throw Exception('ID $id not found');
    }
  }

  Future<List<Account>> readAccountByMonth(int monthId) async {
    final db = await instance.database;
    final orderBy = '${AccountFields.date} ASC';
    final results = await db!.query(tableAccount, orderBy: orderBy);

    List<Account> accounts = results.map((json) => Account.fromJson(json)).toList();
    List<Account> accountsForMonth = <Account>[];
    for(Account account in accounts){
        if(account.date.month == monthId){
          accountsForMonth.add(account);
        }
    }
    return accountsForMonth;
  }

  Future<Employee?> readEmployeeById(int empId) async {
    final db = await instance.database;
    final orderBy = '_id ASC';
    final results = await db!.query(tableEmployee, orderBy: orderBy);

    Employee? selectedEmployee = null;

    List<Employee> employees = results.map((json) => Employee.fromJson(json)).toList();
    for(Employee employee in employees){
      if(employee.id == empId){
        selectedEmployee = employee;
        break;
      }
    }
    return selectedEmployee;
  }

  Future<List<Account>> readAllAccounts() async {
    final db = await instance.database;
    final orderBy = '${AccountFields.date} ASC';
    final results = await db!.query(tableAccount, orderBy: orderBy);

    return results.map((json) => Account.fromJson(json)).toList();
  }

  Future<List<Employee>> readAllEmployees() async {
    final db = await instance.database;
    final orderBy = '${EmployeeFields.employeeName} ASC';
    final results = await db!.query(tableEmployee, orderBy: orderBy);

    return results.map((json) => Employee.fromJson(json)).toList();
  }

  Future<int> update(Account account) async {
    final db = await instance.database;
    return db!.update(
      tableAccount,
      account.toJson(),
      where: '${AccountFields.id} == ?',
      whereArgs: [account.id],
    );
  }

  Future<int> updateEmployee(Employee employee) async {
    final db = await instance.database;
    return db!.update(
      tableEmployee,
      employee.toJson(),
      where: '${EmployeeFields.id} == ?',
      whereArgs: [employee.id],
    );
  }

  Future<int> delete(int id) async {
    final db = await instance.database;

    return await db!.delete(tableAccount,
        where: '${AccountFields.id} = ?', whereArgs: [id]);
  }

  Future close() async {
    final db = await instance.database;
    db!.close();
  }
}
