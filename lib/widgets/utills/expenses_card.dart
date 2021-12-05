import 'package:expenses/main.dart';
import 'package:expenses/models/account.dart';
import 'package:expenses/models/employee.dart';
import 'package:expenses/providers/account_state.dart';
import 'package:expenses/providers/employee_state.dart';
import 'package:expenses/screens/add_expenses.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class ExpensesCard extends StatelessWidget {
  final double cardWidth;
  final double cardHeight;
  final Account account;
  final String employeeName;
  const ExpensesCard(
      {Key? key,
      required this.cardWidth,
      required this.cardHeight,
      required this.account,
      required this.employeeName})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final DateFormat formatter = DateFormat('y MMMM d');
    final accountState = Provider.of<AccountState>(context);
    final employeeState = Provider.of<EmployeeState>(context);
    var width = MediaQuery.of(context).size.width;
    return GestureDetector(
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Container(
            height: cardHeight * 0.8,
            width: cardWidth,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black54,
                    offset: Offset(0.0, 0.0),
                    blurRadius: 4.0,
                  )
                ]),
            child: Container(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: cardWidth *0.25,
                      child: Text(account.date.day.toString(),
                          style: TextStyle(fontWeight: FontWeight.bold,fontSize: 12)),
                    ),
                    Container(
                      width: cardWidth *0.25,
                      child: Text(employeeName,
                          style: TextStyle(fontWeight: FontWeight.bold,fontSize: 12),textAlign: TextAlign.left,),
                    ),
                    Container(
                      width: cardWidth *0.25,
                      child: Text('${account?.valueIn}',
                          style: TextStyle(fontWeight: FontWeight.bold,fontSize: 12),textAlign: TextAlign.right,),
                    ),
                    Container(
                      width: cardWidth *0.25,
                      child: Text('${account?.valueOut}',
                          style: TextStyle(fontWeight: FontWeight.bold,fontSize: 12),textAlign: TextAlign.right,),
                    ),
                  ],
                ),
              ),
            )),
      ),
    );
  }
}
