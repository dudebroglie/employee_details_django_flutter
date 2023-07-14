import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../env.sample.dart';
import '../models/employee.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  HomeState createState() => HomeState();
}

class HomeState extends State<Home> {
  late Future<List<Employee>> employees;
  final employeeListKey = GlobalKey<HomeState>();

  @override
  void initState() {
    super.initState();
    employees = getEmployeeList();
  }

  Future<List<Employee>> getEmployeeList() async {
    final response =
        await http.get(Uri.parse("${Env.URL_PREFIX}/employeedetails/"));
    print(response.body);

    final items = json.decode(response.body).cast<Map<String, dynamic>>();
    try {
      List<Employee> employees = items.map<Employee>((json) {
        return Employee.fromJson(json);
      }).toList();
      print(employees);
      return employees;
    } catch (e) {
      print('Parsing error: $e');
      return []; // Return an empty list or handle the error case appropriately
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: employeeListKey,
      appBar: AppBar(
        title: const Text('Employee List'),
      ),
      body: Center(
        child: FutureBuilder<List<Employee>>(
          future: employees,
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (BuildContext context, int index) {
                  var data = snapshot.data[index];
                  return Card(
                    child: ListTile(
                      leading: const Icon(Icons.person),
                      title: Text(
                        data.ename,
                        style: const TextStyle(fontSize: 20),
                      ),
                    ),
                  );
                },
              );
            } else {
              return const CircularProgressIndicator();
            }
          },
        ),
      ),
    );
  }
}
