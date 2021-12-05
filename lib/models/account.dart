final String tableAccount = 'account';

class AccountFields {
  static final List<String> values = [id, empId, valueIn, date, valueOut];
  static final String id = '_id';
  static final String empId = 'empId';
  static final String valueIn = 'valueIn';
  static final String date = 'date';
  static final String valueOut = 'valueOut';

}

class Account {
  final int? id;
  final int empId;
  final double valueIn;
  final DateTime date;
  final double valueOut;

  const Account(
      {this.id,
      required this.empId,
      required this.valueIn,
      required this.date,
      required this.valueOut});

  Account copy({int? id, int? empId, double? valueIn, DateTime? date, double? valueOut}) =>
      Account(
          id: id ?? this.id,
          empId: empId ?? this.empId,
          valueIn: valueIn ?? this.valueIn,
          date: date ?? this.date,
          valueOut: valueOut ?? this.valueOut);

  static Account fromJson(Map<String, Object?> json) => Account(
      id: json[AccountFields.id] as int?,
      empId: json[AccountFields.empId] as int,
      valueIn: json[AccountFields.valueIn] as double,
      date: DateTime.parse(json[AccountFields.date] as String),
      valueOut: json[AccountFields.valueOut] as double);

  Map<String, Object?> toJson() => {
        AccountFields.id: id,
        AccountFields.empId: empId,
        AccountFields.valueIn: valueIn,
        AccountFields.date: date.toIso8601String(),
        AccountFields.valueOut: valueOut,
      };

}
