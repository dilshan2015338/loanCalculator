

import 'package:expenses/providers/account_state.dart';
import 'package:expenses/screens/loan_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';

class SingleMonthDetail extends StatefulWidget {
  final String monthName;
  final int monthId;
  final double cardWidth;
  final double cardHeight;
  const SingleMonthDetail({Key? key,required this.cardWidth,required this.cardHeight,
  required this.monthName,required this.monthId}) : super(key: key);

  @override
  _SingleMonthDetailState createState() => _SingleMonthDetailState();
}

class _SingleMonthDetailState extends State<SingleMonthDetail> {
  @override
  Widget build(BuildContext context) {
    final accountState = Provider.of<AccountState>(context);
    return Container(
      width: widget.cardWidth,
      height: widget.cardHeight,
      child: GestureDetector(
        onTap: (){
          accountState.changeUpdateStatus(false);
          accountState.cleanValues();
          accountState.selectAllByMonth(widget.monthId);
          Navigator.push(
            context,
            new MaterialPageRoute(
              builder: (context) => new LoanDetails(monthName: widget.monthName,),
            ),
          );
        },
        child: Material(
          clipBehavior: Clip.antiAlias,
          shape: BeveledRectangleBorder(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20.0),
                  bottomRight: Radius.circular(20.0))),
          child: Container(
            height: 100,
            child: Center(
                child: Text(widget.monthName,textAlign: TextAlign.center,style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),)
            ),
            decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.circular(15.0),
            ),
          ),
        ),
      ),
    );
  }
}
