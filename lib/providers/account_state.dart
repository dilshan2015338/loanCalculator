

import 'package:expenses/db/account.dart';
import 'package:expenses/models/account.dart';
import 'package:expenses/models/employee.dart';
import 'package:flutter/material.dart';

class AccountState extends ChangeNotifier {

  int id= 0;
  DateTime date= DateTime.now();
  double total = 0;
  double valueOut =0;
  List<Account>? accounts = null;
  List<String>? accountEmpNames = [];
  Employee? employee = null;
  bool update=false;

  //Controllers
  TextEditingController descriptionController = TextEditingController();
  TextEditingController valueController = TextEditingController();

  Future<Account> saveValues(){
      Account account = new Account(empId: int.parse(descriptionController.text), valueIn: double.parse(valueController.text), date: DateTime.now(), valueOut: 1000);
      return ExpensesDatabase.instance.create(account);
  }

  Future<int> updateValues(){
    Account account = new Account(id:this.id,empId: int.parse(descriptionController.text), valueIn: double.parse(valueController.text), date: this.date, valueOut: 1000);
    return ExpensesDatabase.instance.update(account);
  }

  Future<int> deleteValues(){
    return ExpensesDatabase.instance.delete(this.id);
  }

  void changeUpdateStatus(bool status){
    update = status;
    notifyListeners();
  }

  Future<void> selectAll() async {
    ExpensesDatabase.instance.readAllAccounts().then((accountDetails) {
      accounts = accountDetails;
      for(Account account in accountDetails){
        ExpensesDatabase.instance.readEmployeeById(account.empId).then((value) {
          accountEmpNames!.add(value!.employeeName);
        });
      }
      notifyListeners();
    });

  }

  Future<void> selectAllByMonth(int monthId) async {
    ExpensesDatabase.instance.readAccountByMonth(monthId).then((accountDetails) {
      accounts = accountDetails;
      for(Account account in accountDetails){
        ExpensesDatabase.instance.readEmployeeById(account.empId).then((value) {
          accountEmpNames!.add(value!.employeeName);
          notifyListeners();
        });
      }

    });
  }

  Future<void> selectEmployeeById(int empId) async {
    ExpensesDatabase.instance.readEmployeeById(empId).then((value) {
      if(value != null){
        employee = value;
      }
      notifyListeners();
    });
  }

  void setValues(Account account){
    this.id = account.id!;
    this.descriptionController.text = account.empId.toString();
    this.valueController.text = account.valueIn.toString();
    this.date = account.date;
    this.valueOut = account.valueOut;
    notifyListeners();
  }

  void cleanValues(){
    this.id =0;
    this.descriptionController.text ='';
    this.valueController.text = '';
    this.date = DateTime.now();
    this.valueOut = 0;
    notifyListeners();
  }

  double calculateTotalCost(List<Account> accountList){
    double sum =0;
    for (int i = 0; i < accountList.length; i++){
      Account account = accountList[i];
      sum += account.valueIn;
    }
    return sum;
  }

}