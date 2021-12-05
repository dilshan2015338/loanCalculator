

import 'package:expenses/db/account.dart';
import 'package:expenses/models/account.dart';
import 'package:expenses/models/employee.dart';
import 'package:flutter/material.dart';

class EmployeeState extends ChangeNotifier {

  int id= 0;
  DateTime date= DateTime.now();
  late List<Employee> employees;
  bool update=false;

  //Controllers
  TextEditingController employeeNameController = TextEditingController();

  Future<Employee> saveValues(){
    Employee employee = new Employee(employeeName: employeeNameController.text);
    return ExpensesDatabase.instance.createEmployee(employee);
  }

  Future<int> updateValues(){
    Employee employee = new Employee(id: this.id, employeeName: employeeNameController.text);
    return ExpensesDatabase.instance.updateEmployee(employee);
  }

  Future<int> deleteValues(){
    return ExpensesDatabase.instance.delete(this.id);
  }

  void changeUpdateStatus(bool status){
    update = status;
    notifyListeners();
  }

  Future<void> selectAll() async {
    ExpensesDatabase.instance.readAllEmployees().then((value) {
      employees = value;
      notifyListeners();
    });
  }

  Future<Employee?> selectEmployeeById(int empId) async {
    ExpensesDatabase.instance.readEmployeeById(empId).then((value) {
      if(value != null){
        return value;
      }
    });
  }

  void setValues(Employee employee){
    this.id = employee.id!;
    this.employeeNameController.text = employee.employeeName;
    notifyListeners();
  }

  void cleanValues(){
    this.id =0;
    this.employeeNameController.text ='';
    notifyListeners();
  }

}