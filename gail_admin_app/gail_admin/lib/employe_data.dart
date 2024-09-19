import 'package:flutter/material.dart';
import 'package:gail_admin/bar%20graph/bar_graph.dart';

class EmployeePage extends StatefulWidget {
  final int index;

  const EmployeePage(this.index, {super.key});

  @override
  State<EmployeePage> createState() => _EmployeePageState();
}

class _EmployeePageState extends State<EmployeePage> {
  // Graph data
  List<double> weeklySummary = [
    10.40,
    50.00,
    42.42,
    10.50,
    100.20,
    88.99,
    90.10,
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background design
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0xFF8967B3),
                  Color(0xFFCB80AB),
                ],
              ),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 40), // Add spacing for status bar

              // Custom Back Button
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: IconButton(
                  icon: const Icon(Icons.arrow_back, color: Color(0XFFE6D9A2)),
                  onPressed: () {
                    Navigator.pop(context); // Go back to the previous page
                  },
                ),
              ),

              // Title Text
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  'Employee Details',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFFE6D9A2),
                  ),
                ),
              ),

              const SizedBox(height: 30), // Space between title and graph

              // Bar Graph Section
              Center(
                child: SizedBox(
                  height: MediaQuery.of(context).size.height /
                      3, // 1/3 of the screen height
                  width: MediaQuery.of(context).size.width * 0.9, // 90% width
                  child: Card(
                    color: const Color(0xFF8967B3),
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: MyBarGraph(
                        weeklySummary: weeklySummary,
                      ),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 10), // Space between the graph and label

              const Center(
                child: Text(
                  'Weekly Hour Chart',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: Color(0xFFE6D9A2),
                  ),
                ),
              ),

              const SizedBox(
                  height: 30), // Space between chart label and details

              // Employee Details Section
              Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildDetailText('Name: Employee ${widget.index}'),
                    _buildDetailText('Employee ID: #${widget.index + 1000}'),
                    _buildDetailText(
                        'Employee Joining Date: ${_getJoiningDate(widget.index)}'),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // Function to build the detail text widgets
  Widget _buildDetailText(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Text(
        text,
        style: const TextStyle(
          color: Color(0xFFE6D9A2),
          fontFamily: 'QuickSand',
          fontSize: 20,
        ),
      ),
    );
  }

  // A mock function to generate joining date based on index
  String _getJoiningDate(int index) {
    DateTime joiningDate = DateTime(2021, index + 1, 10);
    return "${joiningDate.day}/${joiningDate.month}/${joiningDate.year}";
  }
}
