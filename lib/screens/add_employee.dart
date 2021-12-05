
import 'package:expenses/main.dart';
import 'package:expenses/models/employee.dart';
import 'package:expenses/providers/account_state.dart';
import 'package:expenses/providers/employee_state.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class AddEmployee extends StatefulWidget {
  const AddEmployee({Key? key}) : super(key: key);

  @override
  _AddEmployeeState createState() => _AddEmployeeState();
}

class _AddEmployeeState extends State<AddEmployee> {
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final employeeState = Provider.of<EmployeeState>(context);
    return Scaffold(
      appBar: AppBar(
        title: employeeState.update
            ? Text("Update Employee")
            : Text("Create Employee"),
      ),
      body: Container(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(
                    left: 10 * 2, bottom: 10, right: 10 * 2),
                child: TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Please enter description";
                    }
                    return null;
                  },
                  controller: employeeState.employeeNameController,
                  decoration: InputDecoration(
                    labelText: "Employee Name",
                  ),
                ),
              ),
              ElevatedButton(
                  onPressed: () {
                    checkFormValidation(
                        _formKey,
                        employeeState,
                        context);
                  },
                  child: employeeState.update ? Text("Update") : Text("Add")),
            ],
          ),
        ),
      ),
    );
  }

  checkFormValidation(GlobalKey<FormState> _formKey,
      EmployeeState employeeState, context) {
    if (_formKey.currentState!.validate()) {
      if (employeeState.update) {
        employeeState..updateValues().then((value) {
          Fluttertoast.showToast(
              msg: "Expeses updated",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.greenAccent,
              textColor: Colors.black,
              fontSize: 12);
          Navigator.push(
            context,
            new MaterialPageRoute(
              builder: (context) => new MyHomePage(title: "Expenses Details"),
            ),
          );

        }).catchError((onError) {
          print(onError.toString());
          Fluttertoast.showToast(
              msg: onError.toString(),
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.greenAccent,
              textColor: Colors.black,
              fontSize: 12);
        });
      } else {
        employeeState.saveValues().then((value) {
          Fluttertoast.showToast(
              msg: "Expeses Saved",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.greenAccent,
              textColor: Colors.black,
              fontSize: 12);
          Navigator.push(
            context,
            new MaterialPageRoute(
              builder: (context) => new MyHomePage(title: "Expenses Details"),
            ),
          );
        }).catchError((onError) {
          print(onError.toString());
          Fluttertoast.showToast(
              msg: onError.toString(),
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.greenAccent,
              textColor: Colors.black,
              fontSize: 12);
        });
      }
    } else {
      Fluttertoast.showToast(
          msg: "Please fill all fields",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.greenAccent,
          textColor: Colors.black,
          fontSize: 12);
    }
  }
}


