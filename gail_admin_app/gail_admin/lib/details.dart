import 'package:flutter/material.dart';
import 'package:gail_admin/employe_data.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class MyDetails extends StatefulWidget {
  const MyDetails({super.key});

  @override
  _MyDetailsState createState() => _MyDetailsState();
}

class _MyDetailsState extends State<MyDetails> {
  ListView _buildListView(BuildContext context) {
    return ListView.builder(
      itemCount: 20,
      itemBuilder: (_, index) {
        return Card(
          elevation: 5,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          color: const Color(0xFF8967B3),
          margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          child: ListTile(
            title: Text(
              'Employee $index',
              style: const TextStyle(
                  color: Color(0xFFE6D9A2), fontFamily: 'QuickSand'),
            ),
            subtitle: const Text(
              'Employee ID',
              style: TextStyle(color: Color(0xFFE6D9A2)),
            ),
            leading: const Icon(
              Icons.accessibility_new_sharp,
              color: Color(0xFFE6D9A2),
            ),
            trailing: const Icon(
              Icons.arrow_circle_right_outlined,
              color: Color(0xFFE6D9A2),
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => EmployeePage(index)),
              );
            },
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: GNav(
        tabBackgroundColor: const Color(0xFF8967b3),
        activeColor: const Color(0xFFE6D9A2),
        backgroundColor: const Color(0xFF8967b3),
        gap: 15,
        selectedIndex: 1, // To make Employees active
        onTabChange: (index) {
          if (index == 0) {
            Navigator.pushNamed(context, 'map');
          } else if (index == 1) {
            // Already on Employees page, do nothing
          } else if (index == 2) {
            Navigator.pushNamed(context, 'leave');
          } else if (index == 3) {
            // Log out or navigate to log out functionality
          }
        },
        tabs: const [
          GButton(
            icon: Icons.map,
            text: 'Map',
          ),
          GButton(
            icon: Icons.person,
            text: 'Employees',
          ),
          GButton(
            icon: Icons.messenger_outlined,
            text: 'Requests',
          ),
          GButton(
            icon: Icons.logout_rounded,
            text: 'Log Out',
          ),
        ],
      ),
      body: _buildListView(context),
    );
  }
}
