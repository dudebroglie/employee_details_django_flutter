class Employee {
  final String eid;
  final String eemail;
  final String ename;

  Employee({required this.eid, required this.eemail, required this.ename});

  factory Employee.fromJson(Map<String, dynamic> json) {
    return Employee(
      eid: json['eid'] ?? '',
      ename: json['ename'] ?? '',
      eemail: json['eemail'] ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
        'eid': eid,
        'ename': ename,
        'eemail': eemail,
      };
}
