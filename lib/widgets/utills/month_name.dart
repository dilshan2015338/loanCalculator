

import 'dart:collection';

import 'package:expenses/models/account.dart';
import 'package:expenses/providers/account_state.dart';
import 'package:expenses/screens/loan_details.dart';
import 'package:expenses/widgets/utills/single_month_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class MonthDetails extends StatefulWidget {
  final double cardWidth;
  final double cardHeight;
  const MonthDetails({Key? key,
    required this.cardWidth,
    required this.cardHeight}) : super(key: key);

  @override
  _MonthDetailsState createState() => _MonthDetailsState();
}

class _MonthDetailsState extends State<MonthDetails> {
  String selectedValue = "";
  int monthId = 1;
  @override
  Widget build(BuildContext context) {
    List<String> months = ["January","February","March","April","May","June","July","August","September","October","November","December"];
    selectedValue = months.first;
    final accountState = Provider.of<AccountState>(context);
    return Container(
      color: Colors.blueGrey,
      width: widget.cardWidth,
      height: widget.cardHeight,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text("Select By Month",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                )),
          ),
          Expanded(
            child: SingleChildScrollView(
             child: Container(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            SingleMonthDetail(cardWidth: widget.cardWidth *0.4,cardHeight: widget.cardHeight * 0.2,monthName: "January",monthId: 1,),
                            SingleMonthDetail(cardWidth: widget.cardWidth *0.4,cardHeight: widget.cardHeight * 0.2,monthName: "February",monthId: 2,),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            SingleMonthDetail(cardWidth: widget.cardWidth *0.4,cardHeight: widget.cardHeight * 0.2,monthName: "March",monthId: 3,),
                            SingleMonthDetail(cardWidth: widget.cardWidth *0.4,cardHeight: widget.cardHeight * 0.2,monthName: "April",monthId: 4,),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            SingleMonthDetail(cardWidth: widget.cardWidth *0.4,cardHeight: widget.cardHeight * 0.2,monthName: "May",monthId: 5,),
                            SingleMonthDetail(cardWidth: widget.cardWidth *0.4,cardHeight: widget.cardHeight * 0.2,monthName: "June",monthId: 6,),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            SingleMonthDetail(cardWidth: widget.cardWidth *0.4,cardHeight: widget.cardHeight * 0.2,monthName: "July",monthId: 7,),
                            SingleMonthDetail(cardWidth: widget.cardWidth *0.4,cardHeight: widget.cardHeight * 0.2,monthName: "August",monthId: 8,),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            SingleMonthDetail(cardWidth: widget.cardWidth *0.4,cardHeight: widget.cardHeight * 0.2,monthName: "September",monthId: 9,),
                            SingleMonthDetail(cardWidth: widget.cardWidth *0.4,cardHeight: widget.cardHeight * 0.2,monthName: "October",monthId: 10,),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            SingleMonthDetail(cardWidth: widget.cardWidth *0.4,cardHeight: widget.cardHeight * 0.2,monthName: "November",monthId: 11,),
                            SingleMonthDetail(cardWidth: widget.cardWidth *0.4,cardHeight: widget.cardHeight * 0.2,monthName: "December",monthId: 12,),
                          ],
                        ),
                      ),
                    ],
                  ),
             ),
            ),
          ),
        ],
      ),
    );
  }

  Future<int> getMonthId(String monthName) async {
    switch(monthName){
      case "January":
        return 1;
      case "February":
        return 2;
      case "March":
        return 3;
      case "April":
        return 4;
      case "May":
        return 5;
      case "June":
        return 6;
      case "July":
        return 7;
      case "August":
        return 8;
      case "September":
        return 9;
      case "October":
        return 10;
      case "November":
        return 11;
      case "December":
        return 12;
      default:
        return 0;
    }
  }
}
