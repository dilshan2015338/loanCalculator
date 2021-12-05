final String tableEmployee = 'employee';

class EmployeeFields {
  static final List<String> values = [id, employeeName,];
  static final String id = '_id';
  static final String employeeName = 'employeeName';

}

class Employee {
  final int? id;
  final String employeeName;

  const Employee(
      {this.id,
        required this.employeeName,});

  Employee copy({int? id, String? employeeName}) =>
      Employee(
          id: id ?? this.id,
          employeeName: employeeName ?? this.employeeName);

  static Employee fromJson(Map<String, Object?> json) => Employee(
      id: json[EmployeeFields.id] as int?,
      employeeName: json[EmployeeFields.employeeName] as String,);

  Map<String, Object?> toJson() => {
    EmployeeFields.id: id,
    EmployeeFields.employeeName: employeeName,
  };
}
