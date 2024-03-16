import 'package:flutter/material.dart';

class ViewOrderHistoryDetails extends StatelessWidget {
  const ViewOrderHistoryDetails({super.key});

  @override
  Widget build(BuildContext context) {
    // Sample order history data
    final List<Map<String, dynamic>> orderHistory = [
      {'orderId': '12345', 'date': '2024-Jan-10: 20:34:06', 'status': 'Delivered'},
      {'orderId': '67894', 'date': '2024-Feb-01: 07:47:12', 'status': 'Delivered'},
      {'orderId': '54321', 'date': '2024-Mar-15: 14:00:39', 'status': 'In Transit'},
      // Add more order history data as needed
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Past Orders',
          style: TextStyle(fontSize: 28),
        ),
        backgroundColor: Colors.blue,
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.horizontal, // Allow horizontal scrolling
        child: SingleChildScrollView(
          child: DataTable(
            columns: const <DataColumn>[
              DataColumn(
                label: Text(
                  'Order ID',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              DataColumn(
                label: Text(
                  'Date',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              DataColumn(
                label: Text(
                  'Status',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ],
            rows: List<DataRow>.generate(
              orderHistory.length,
                  (index) => DataRow(
                cells: <DataCell>[
                  DataCell(Text(orderHistory[index]['orderId'])),
                  DataCell(Text(orderHistory[index]['date'])),
                  DataCell(Text(orderHistory[index]['status'])),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
