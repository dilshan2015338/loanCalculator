

import 'package:expenses/db/account.dart';
import 'package:expenses/models/account.dart';
import 'package:expenses/models/employee.dart';
import 'package:expenses/providers/account_state.dart';
import 'package:expenses/providers/employee_state.dart';
import 'package:expenses/screens/add_expenses.dart';
import 'package:expenses/widgets/utills/expenses_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class LoanDetails extends StatefulWidget {
  final String monthName;
  const LoanDetails({Key? key,required this.monthName}) : super(key: key);

  @override
  _LoanDetailsState createState() => _LoanDetailsState();
}

class _LoanDetailsState extends State<LoanDetails> {
  bool isLoading = false;
  late List<Account> accounts;
  late List<String> accountEmpNames;

  @override
  void initState() {
    super.initState();

    refreshList();
  }

  Future refreshList() async {
    setState(() {
      isLoading = true;
    });

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {

    final DateFormat formatter = DateFormat('y MMMM d');
    var height = MediaQuery.of(context).size.height;
    final accountState = Provider.of<AccountState>(context);
    final employeeState = Provider.of<EmployeeState>(context);
    accounts = accountState.accounts!;
    accountEmpNames = accountState.accountEmpNames!;
    var size = MediaQuery.of(context).size;
    var cardHeight = size.width * 0.4;
    return Scaffold(
      appBar: AppBar(
        title: Text("Loan Details"),
      ),
      body: Center(
        child: Container(
          color: Colors.white,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  top: 8.0,
                  bottom: 8.0,
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text("Month Name: "),
                          Text(widget.monthName,style: TextStyle(
                            fontWeight: FontWeight.bold
                          ),)
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width:size.width * 0.23,
                            child: Text("Date",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                )),
                          ),
                          Container(
                            width:size.width * 0.23,
                            child: Text("Name",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),textAlign: TextAlign.left,),
                          ),
                          Container(
                            width:size.width * 0.23,
                            child: Text("Value In",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18),textAlign: TextAlign.right,),
                          ),
                          Container(
                            width:size.width * 0.23,
                            child: Text("Value Out",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,),textAlign: TextAlign.right,),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              ListView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: accounts.length,
                  itemBuilder: (context, index) {
                    Account account = accounts[index];
                    String empName = accountEmpNames[index];
                    return ExpensesCard(
                        cardWidth: size.width * 0.9,
                        cardHeight: cardHeight * 0.4,
                        account: account,
                        employeeName: empName,);
                  }),
              FloatingActionButton(
                  onPressed: () {
                    accountState.changeUpdateStatus(false);
                    accountState.cleanValues();
                    Navigator.push(
                      context,
                      new MaterialPageRoute(
                        builder: (context) => new AddExpenses(),
                      ),
                    );
                  },
                  child: Icon(Icons.add))
            ],
          ),
        ),
      ),
    );
  }
}
