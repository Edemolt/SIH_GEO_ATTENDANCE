import 'package:flutter/material.dart';
import 'package:gail_admin/employee.dart';

class MyDetails extends StatefulWidget {
  const MyDetails({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _MyDetailsState createState() => _MyDetailsState();
}

class _MyDetailsState extends State<MyDetails> {
  ListView _buildListView(BuildContext context) {
    return ListView.builder(
      itemCount: 10,
      itemBuilder: (_, index) {
        return ListTile(
          title: Text('Employee $index'),
          subtitle: Text('Employee ID'),
          leading: Icon(Icons.accessibility_new_sharp),
          trailing: Icon(Icons.arrow_circle_right_outlined),
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => EmployeePage(index)));
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Employee Data'),
      ),
      body: _buildListView(context),
    );
  }
}
