import 'package:expenses/db/account.dart';
import 'package:expenses/providers/account_state.dart';
import 'package:expenses/providers/employee_state.dart';
import 'package:expenses/screens/add_employee.dart';
import 'package:expenses/screens/add_expenses.dart';
import 'package:expenses/screens/loan_details.dart';
import 'package:expenses/widgets/utills/expenses_card.dart';
import 'package:expenses/widgets/utills/month_name.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:async';

import 'package:path/path.dart';
import 'package:provider/provider.dart';
import 'package:sqflite/sqflite.dart';

import 'models/account.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return new MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => AccountState()),
          ChangeNotifierProvider(create: (context) => EmployeeState())
        ],
        builder: (context, child) {
          return MaterialApp(
            title: 'Flutter Demo',
            theme: ThemeData(
              primarySwatch: Colors.blue,
            ),
            home: MyHomePage(title: 'Loan details'),
          );
        });
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({
    Key? key,
    required this.title,
  }) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late List<Account> accounts;
  late List<String> months = ["Jan","Feb","March","April","May","June","July","August","Sep","Oct","Nov","Dec"];
  bool isLoading = false;
  double totalValue = 0;
  String selectedValue = "Jan";

  @override
  void initState() {
    super.initState();

    refreshList();
  }

  Future refreshList() async {
    setState(() {
      isLoading = true;
    });

    this.accounts = await ExpensesDatabase.instance.readAllAccounts();

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final DateFormat formatter = DateFormat('y MMMM d');
    var height = MediaQuery.of(context).size.height;
    final accountState = Provider.of<AccountState>(context);
    var size = MediaQuery.of(context).size;
    var cardHeight = size.width * 0.8;
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Expanded(
              child: SingleChildScrollView(
                child: Container(
                  child: isLoading
                      ? SizedBox(
                          height: height * 0.8,
                          child: Center(
                            child: CircularProgressIndicator(),
                          ),
                        )
                      : SingleChildScrollView(
                        child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: MonthDetails(
                                  cardWidth: size.width,
                                  cardHeight: cardHeight,),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: MonthDetails(
                                  cardWidth: size.width,
                                  cardHeight: cardHeight,),
                              ),
                            ],
                          ),
                      ),
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            accountState.changeUpdateStatus(false);
            accountState.cleanValues();
            // Navigator.push(
            //   context,
            //   new MaterialPageRoute(
            //     builder: (context) => new LoanDetails(monthName: "January",),
            //   ),
            // );
            Navigator.push(
              context,
              new MaterialPageRoute(
                builder: (context) => new AddEmployee(),
              ),
            );
          },
          child: Icon(Icons.add)),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
